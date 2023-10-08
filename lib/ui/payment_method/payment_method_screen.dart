// import 'package:discovery_zone/core/widgets/custom_button.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_form.dart';
//
// import '../../core/helpers/helper_functions.dart';
// import '../../core/layout/app_fonts.dart';
// import '../../core/layout/palette.dart';
// import '../../core/widgets/texts.dart';
//
// class PaymentMethodScreen extends StatefulWidget {
//   const PaymentMethodScreen({super.key});
//
//   @override
//   State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
// }
//
// class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
//
//      String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Texts(
//           title: "بيانات الدفع",
//           family: AppFonts.caB,
//           size: 22,
//           textColor: Palette.mainColor,
//           height: 2.0,
//         ),
//       ),
// body: Padding(
//   padding: const EdgeInsets.all(20.0),
//   child:   SingleChildScrollView(
//     child: Column(
//
//       children: [
//         sizedHeight(35),
//        Container(
//          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(10),
//            border: Border.all(color:Colors.grey,width:.8)
//          ),
//          child: CreditCardForm(
//                                 formKey: formKey,
//                                 obscureCvv: true,
//                                 obscureNumber: true,
//                                 cardNumber: cardNumber,
//                                 cvvCode: cvvCode,
//                                 isHolderNameVisible: true,
//                                 isCardNumberVisible: true,
//                                 isExpiryDateVisible: true,
//                                 cardHolderName: cardHolderName,
//                                 expiryDate: expiryDate,
//                                 themeColor: Colors.blue,
//                                 textColor: Colors.black,
//                                 cardNumberDecoration: InputDecoration(
//
//                                   labelText: 'Number',
//                                   hintText: 'XXXX XXXX XXXX XXXX',
//                                   hintStyle: const TextStyle(color: Colors.grey),
//                                   labelStyle: const TextStyle(color: Colors.black),
//                                   focusedBorder: border,
//                                   enabledBorder: border,
//                                 ),
//                                 expiryDateDecoration: InputDecoration(
//                                   hintStyle: const TextStyle(color: Colors.grey),
//                                   labelStyle: const TextStyle(color: Colors.black),
//                                   focusedBorder: border,
//                                   enabledBorder: border,
//                                   labelText: 'Expired Date',
//                                   hintText: 'XX/XX',
//                                 ),
//                                 cvvCodeDecoration: InputDecoration(
//                                   hintStyle: const TextStyle(color: Colors.grey),
//                                   labelStyle: const TextStyle(color: Colors.black),
//                                   focusedBorder: border,
//                                   enabledBorder: border,
//                                   labelText: 'CVV',
//                                   hintText: 'XXX',
//                                 ),
//                                 cardHolderDecoration: InputDecoration(
//                                   hintStyle: const TextStyle(color: Colors.grey),
//                                   labelStyle: const TextStyle(color: Colors.black),
//                                   focusedBorder: border,
//                                   enabledBorder: border,
//                                   labelText: 'Card Holder',
//                                 ), onCreditCardModelChange: (CreditCardModel ) {
//
//                                  },
//                                 // onCreditCardModelChange: onCreditCardModelChange,
//                               ),
//        ),
//                     sizedHeight(25),
//                     CustomButton(
//                         onPressed: () {
//
//                         },
//                         title: "دفع".tr(),
//                       ),],
//     ),
//   ),
// ),
//     );
//   }
// }
