import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/core/utils/app_model.dart';
import 'package:discovery_zone/core/utils/utils.dart';
import 'package:discovery_zone/models/card_response.dart';
import 'package:discovery_zone/models/subscribe_model.dart';
import 'package:discovery_zone/ui/cards_screen/cards_screen.dart';

// import 'package:discovery_zone/models/response_payment.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'dart:async';
import 'package:go_sell_sdk_flutter/model/models.dart';

import 'package:http/http.dart' as http;

part 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit() : super(const CardsState());

  static CardsCubit get(context) => BlocProvider.of<CardsCubit>(context);

  // ** get markets By fieldId
  Future getCards({context}) async {
    emit(state.copyWith(getCardsState: RequestState.loading));

    bool hasInternetResult = await hasInternet();

    if (hasInternetResult) {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstants.baseUrl}/card/get-Card-user?userId=${AppModel.userId ?? "not"}'));

      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> getCards");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);
        CardResponse cardResponse = CardResponse.fromJson(jsonData);
        // if (cardResponse.userDetailResponse != null) {

        // }

        emit(state.copyWith(
            cardResponse: cardResponse, getCardsState: RequestState.loaded));
      } else {
        emit(state.copyWith(getCardsState: RequestState.error));
      }
    } else {
      emit(state.copyWith(getCardsState: RequestState.noInternet));
    }
  }

  // Future paymentConfirm(
  //     {context, amount, firstName, lastName, phone, email}) async {
  //   showUpdatesLoading(context);
  //   emit(state.copyWith(paymentConfirmState: RequestState.loading));
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer sk_test_TCf8a5D6uhLEW9UXtZv7oJn0'
  //   };
  //   var request =
  //       http.Request('POST', Uri.parse('https://api.tap.company/v2/charges'));
  //   request.body = json.encode({
  //     "amount": amount,
  //     "currency": "KWD",
  //     "threeDSecure": true,
  //     "save_card": false,
  //     "description": "Test Description",
  //     "statement_descriptor": "Sample",
  //     "metadata": {"udf1": "test 1", "udf2": "test 2"},
  //     "reference": {"transaction": "txn_0001", "order": "ord_0001"},
  //     "receipt": {"email": false, "sms": true},
  //     "customer": {
  //       "first_name": firstName,
  //       "middle_name": "test",
  //       "last_name": lastName,
  //       "email": email,
  //       "phone": {"country_code": "965", "number": phone}
  //     },
  //     "merchant": {"id": ""},
  //     "source": {"id": "src_card"},
  //     "post": {"url": "https://tap.company"},
  //     "redirect": {"url": "https://tap.company"}
  //   });
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();
  //   print(response.statusCode.toString() + "====== > paymentConfirm");
  //   if (response.statusCode == 200) {
  //     String jsonDataString = await response.stream.bytesToString();
  //     final jsonData = jsonDecode(jsonDataString);

  //     ResponsePayment responsePayment = ResponsePayment.fromJson(jsonData);
  //     if (responsePayment.status == "INITIATED") {
  //       pop(context);
  //       pushPage(context,
  //           PaymentWebViewPage(url: responsePayment.transaction!.url!));

  //       emit(state.copyWith(paymentConfirmState: RequestState.loaded));
  //     }
  //   } else {
  //     pop(context);
  //     emit(state.copyWith(paymentConfirmState: RequestState.loaded));
  //   }
  // }

  Map<dynamic, dynamic>? tapSDKResult;
  String responseID = "";
  String sdkStatus = "";
  String sdkErrorCode = "";
  String sdkErrorMessage = "";
  String sdkErrorDescription = "";

  Future<void> startSDK(SubscribeModel subscribeModel,
      {context, titleBar}) async {
    showUpdatesLoading(context);
    emit(state.copyWith(paymentConfirmState: RequestState.loading));

    tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;

    print('SDK Result>>>> ${tapSDKResult?['sdk_result']}');

    switch (tapSDKResult!['sdk_result']) {
      case "SUCCESS":
        sdkStatus = "SUCCESS";
        
        subscribeCard(subscribeModel,titleBar: titleBar,context: context);
        break;
      case "FAILED":
        sdkStatus = "FAILED";
        handleSDKResult();
        pop(context);
        emit(state.copyWith(
            paymentConfirmState: RequestState.loaded,
            paymentMessage: tapSDKResult.toString()));
        break;
      case "SDK_ERROR":
        print('sdk error............');
        print(tapSDKResult!['sdk_error_code']);
        print(tapSDKResult!['sdk_error_message']);
        print(tapSDKResult!['sdk_error_description']);
        print('sdk error............');
        sdkErrorCode = tapSDKResult!['sdk_error_code'].toString();
        sdkErrorMessage = tapSDKResult!['sdk_error_message'];
        sdkErrorDescription = tapSDKResult!['sdk_error_description'];
        pop(context);
        emit(state.copyWith(
            paymentConfirmState: RequestState.loaded,
            paymentMessage: "${tapSDKResult!['sdk_error_code']}"));
        break;

      case "NOT_IMPLEMENTED":
        sdkStatus = "NOT_IMPLEMENTED";
        pop(context);
        emit(state.copyWith(
            paymentConfirmState: RequestState.loaded,
            paymentMessage: "NOT_IMPLEMENTED"));
        break;
    }
  }

  Future<void> setupSDKSession(
      {firstName, lastName, email, phone, ammount}) async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
        trxMode: TransactionMode.PURCHASE,
        transactionCurrency: "kwd",
        amount: ammount,
        customer: Customer(
          customerId: "",
          // customer id is important to retrieve cards saved for this customer
          email: email,
          isdNumber: "965",
          number: phone,
          firstName: firstName,
          middleName: "ebrahime",
          lastName: lastName,
          metaData: null,
        ),
        paymentItems: <PaymentItem>[
          // PaymentItem(
          //   name: "item1",
          //   amountPerUnit: 1,
          //   quantity: Quantity(value: 1),
          //   discount: {
          //     "type": "F",
          //     "value": 10,
          //     "maximum_fee": 10,
          //     "minimum_fee": 1
          //   },
          //   description: "Item 1 Apple",
          //   taxes: [
          //     Tax(
          //       amount: Amount(
          //         type: "F",
          //         value: 10,
          //         minimumFee: 1,
          //         maximumFee: 10,
          //       ),
          //       name: "tax1",
          //       description: "tax description",
          //     )
          //   ],
          //   totalAmount: 100,
          // ),
        ],
        // List of taxes
        taxes: [
          // Tax(
          //   amount: Amount(
          //     type: "F",
          //     value: 10,
          //     minimumFee: 1,
          //     maximumFee: 10,
          //   ),
          //   name: "tax1",
          //   description: "tax description",
          // ),
          // Tax(
          //   amount: Amount(
          //     type: "F",
          //     value: 10,
          //     minimumFee: 1,
          //     maximumFee: 10,
          //   ),
          //   name: "tax1",
          //   description: "tax description",
          // )
        ],
        // List of shipping
        shippings: [
          // Shipping(
          //   name: "shipping 1",
          //   amount: 100,
          //   description: "shipping description 1",
          // ),
          // Shipping(
          //   name: "shipping 2",
          //   amount: 150,
          //   description: "shipping description 2",
          // )
        ],
        postURL: "https://tap.company",
        // Payment description
        paymentDescription: "paymentDescription",
        // Payment Metadata
        paymentMetaData: {
          "a": "a meta",
          "b": "b meta",
        },
        // Payment Reference
        paymentReference: Reference(
            acquirer: "acquirer",
            gateway: "gateway",
            payment: "payment",
            track: "track",
            transaction: "trans_910101",
            order: "order_262625"),
        // payment Descriptor
        paymentStatementDescriptor: "paymentStatementDescriptor",
        // Save Card Switch
        isUserAllowedToSaveCard: true,
        // Enable/Disable 3DSecure
        isRequires3DSecure: true,
        // Receipt SMS/Email
        receipt: Receipt(true, false),
        // Authorize Action [Capture - Void]
        authorizeAction:
            AuthorizeAction(type: AuthorizeActionType.CAPTURE, timeInHours: 10),
        // Destinations
        destinations: null,
        // merchant id
        merchantID: "",
        // Allowed cards
        allowedCadTypes: CardType.ALL,
        applePayMerchantID: "merchant.applePayMerchantID",
        allowsToSaveSameCardMoreThanOnce: false,
        // pass the card holder name to the SDK
        cardHolderName: "Card Holder NAME",
        // disable changing the card holder name by the user
        allowsToEditCardHolderName: false,
        // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
        paymentType: PaymentType.ALL,
        // Transaction mode
        sdkMode: SDKMode.Sandbox,
      );
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }
  }

  void handleSDKResult() {
    print('SDK Result>>>> $tapSDKResult');

    print('Transaction mode>>>> ${tapSDKResult!['trx_mode']}');

    switch (tapSDKResult!['trx_mode']) {
      case "CHARGE":
        printSDKResult('Charge');
        break;

      case "AUTHORIZE":
        printSDKResult('Authorize');
        break;

      case "SAVE_CARD":
        printSDKResult('Save Card');
        break;

      case "TOKENIZE":
        print('TOKENIZE token : ${tapSDKResult!['token']}');
        print('TOKENIZE token_currency  : ${tapSDKResult!['token_currency']}');
        print('TOKENIZE card_first_six : ${tapSDKResult!['card_first_six']}');
        print('TOKENIZE card_last_four : ${tapSDKResult!['card_last_four']}');
        print('TOKENIZE card_object  : ${tapSDKResult!['card_object']}');
        print('TOKENIZE card_exp_month : ${tapSDKResult!['card_exp_month']}');
        print('TOKENIZE card_exp_year    : ${tapSDKResult!['card_exp_year']}');
        print('TOKENIZE issuer_id    : ${tapSDKResult!['issuer_id']}');
        print('TOKENIZE issuer_bank    : ${tapSDKResult!['issuer_bank']}');
        print(
            'TOKENIZE issuer_country    : ${tapSDKResult!['issuer_country']}');
        responseID = tapSDKResult!['token'];
        break;
    }
  }

  void printSDKResult(String trxMode) {
    print('$trxMode status                : ${tapSDKResult!['status']}');
    if (trxMode == "Authorize") {
      print('$trxMode id              : ${tapSDKResult!['authorize_id']}');
    } else {
      print('$trxMode id               : ${tapSDKResult!['charge_id']}');
    }
    print('$trxMode  description        : ${tapSDKResult!['description']}');
    print('$trxMode  message           : ${tapSDKResult!['message']}');
    print('$trxMode  card_first_six : ${tapSDKResult!['card_first_six']}');
    print('$trxMode  card_last_four   : ${tapSDKResult!['card_last_four']}');
    print('$trxMode  card_object         : ${tapSDKResult!['card_object']}');
    print('$trxMode  card_id         : ${tapSDKResult!['card_id']}');
    print('$trxMode  card_brand          : ${tapSDKResult!['card_brand']}');
    print('$trxMode  card_exp_month  : ${tapSDKResult!['card_exp_month']}');
    print('$trxMode  card_exp_year: ${tapSDKResult!['card_exp_year']}');
    print('$trxMode  acquirer_id  : ${tapSDKResult!['acquirer_id']}');
    print(
        '$trxMode  acquirer_response_code : ${tapSDKResult!['acquirer_response_code']}');
    print(
        '$trxMode  acquirer_response_message: ${tapSDKResult!['acquirer_response_message']}');
    print('$trxMode  source_id: ${tapSDKResult!['source_id']}');
    print('$trxMode  source_channel     : ${tapSDKResult!['source_channel']}');
    print('$trxMode  source_object      : ${tapSDKResult!['source_object']}');
    print(
        '$trxMode source_payment_type : ${tapSDKResult!['source_payment_type']}');

    if (trxMode == "Authorize") {
      responseID = tapSDKResult!['authorize_id'];
    } else {
      responseID = tapSDKResult!['charge_id'];
    }
  }

  // Future<void> setupSDKSession() async {
  //   try {
  //     GoSellSdkFlutter.sessionConfigurations(
  //       trxMode: TransactionMode.PURCHASE,
  //       transactionCurrency: "kwd",
  //       amount: '50',
  //       customer: Customer(
  //         customerId: "",
  //         // customer id is important to retrieve cards saved for this customer
  //         email: "ammarebrahime2019@gmail.com",
  //         isdNumber: "965",
  //         number: "5050505050",
  //         firstName: "ammar",
  //         middleName: "ebrahime",
  //         lastName: "Khalaf",
  //         metaData: null,
  //       ),
  //       paymentItems: <PaymentItem>[
  //         // PaymentItem(
  //         //   name: "item1",
  //         //   amountPerUnit: 1,
  //         //   quantity: Quantity(value: 1),
  //         //   discount: {
  //         //     "type": "F",
  //         //     "value": 10,
  //         //     "maximum_fee": 10,
  //         //     "minimum_fee": 1
  //         //   },
  //         //   description: "Item 1 Apple",
  //         //   taxes: [
  //         //     Tax(
  //         //       amount: Amount(
  //         //         type: "F",
  //         //         value: 10,
  //         //         minimumFee: 1,
  //         //         maximumFee: 10,
  //         //       ),
  //         //       name: "tax1",
  //         //       description: "tax description",
  //         //     )
  //         //   ],
  //         //   totalAmount: 100,
  //         // ),
  //       ],
  //       // List of taxes
  //       taxes: [
  //         // Tax(
  //         //   amount: Amount(
  //         //     type: "F",
  //         //     value: 10,
  //         //     minimumFee: 1,
  //         //     maximumFee: 10,
  //         //   ),
  //         //   name: "tax1",
  //         //   description: "tax description",
  //         // ),
  //         // Tax(
  //         //   amount: Amount(
  //         //     type: "F",
  //         //     value: 10,
  //         //     minimumFee: 1,
  //         //     maximumFee: 10,
  //         //   ),
  //         //   name: "tax1",
  //         //   description: "tax description",
  //         // )
  //       ],
  //       // List of shipping
  //       shippings: [
  //         // Shipping(
  //         //   name: "shipping 1",
  //         //   amount: 100,
  //         //   description: "shipping description 1",
  //         // ),
  //         // Shipping(
  //         //   name: "shipping 2",
  //         //   amount: 150,
  //         //   description: "shipping description 2",
  //         // )
  //       ],
  //       postURL: "https://tap.company",
  //       // Payment description
  //       paymentDescription: "paymentDescription",
  //       // Payment Metadata
  //       paymentMetaData: {
  //         "a": "a meta",
  //         "b": "b meta",
  //       },
  //       // Payment Reference
  //       paymentReference: Reference(
  //           acquirer: "acquirer",
  //           gateway: "gateway",
  //           payment: "payment",
  //           track: "track",
  //           transaction: "trans_910101",
  //           order: "order_262625"),
  //       // payment Descriptor
  //       paymentStatementDescriptor: "paymentStatementDescriptor",
  //       // Save Card Switch
  //       isUserAllowedToSaveCard: true,
  //       // Enable/Disable 3DSecure
  //       isRequires3DSecure: true,
  //       // Receipt SMS/Email
  //       receipt: Receipt(true, false),
  //       // Authorize Action [Capture - Void]
  //       authorizeAction:
  //           AuthorizeAction(type: AuthorizeActionType.CAPTURE, timeInHours: 10),
  //       // Destinations
  //       destinations: null,
  //       // merchant id
  //       merchantID: "",
  //       // Allowed cards
  //       allowedCadTypes: CardType.CREDIT,
  //       applePayMerchantID: "merchant.applePayMerchantID",
  //       allowsToSaveSameCardMoreThanOnce: true,
  //       // pass the card holder name to the SDK
  //       cardHolderName: "Card Holder NAME",
  //       // disable changing the card holder name by the user
  //       allowsToEditCardHolderName: true,
  //       // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
  //       paymentType: PaymentType.ALL,
  //       // Transaction mode
  //       sdkMode: SDKMode.Sandbox,
  //     );
  //   } on PlatformException {
  //     // platformVersion = 'Failed to get platform version.';
  //   }

  // }

  Future subscribeCard(SubscribeModel model, {context, titleBar}) async {
    // emit(const SubscribeState(subscribeCardState: RequestState.loading));

    bool hasInternetResult = await hasInternet();

    if (hasInternetResult) {
      var request = http.MultipartRequest('POST',
          Uri.parse('${ApiConstants.baseUrl}/subscription/add-Subscription'));

      request.fields.addAll({
        'CardId': model.cardId.toString(),
        'FirstName': model.firstName,
        'LastName': model.lastName,
        'Phone': model.phone,
        "userId":model.userId,
        'Address': model.address
      });
      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> subscribeCard");
      }
      if (response.statusCode == 200) {
        // String jsonDataString = await response.stream.bytesToString();
        // final jsonData = jsonDecode(jsonDataString);
        pop(context);
        pushPage(context, CardsScreen(titleBar: titleBar));
        emit(state.copyWith(
            paymentConfirmState: RequestState.loaded));
      } else {
        emit(state.copyWith(
          paymentConfirmState: RequestState.error,
        ));
      }
    } else {
      emit(state.copyWith(
        paymentConfirmState: RequestState.error,
      ));
    }
  }
}
