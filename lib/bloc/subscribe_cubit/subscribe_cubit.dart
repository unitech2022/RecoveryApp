import 'package:bloc/bloc.dart';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/models/subscribe_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'subscribe_state.dart';

class SubscribeCubit extends Cubit<SubscribeState> {
  SubscribeCubit() : super(const SubscribeState());

  static SubscribeCubit get(context) =>
      BlocProvider.of<SubscribeCubit>(context);
// ** subscribe Card
  Future subscribeCard(SubscribeModel model, {context}) async {
    emit(const SubscribeState(subscribeCardState: RequestState.loading));

    bool hasInternetResult = await hasInternet();

    if (hasInternetResult) {
      var request = http.MultipartRequest('POST',
          Uri.parse('${ApiConstants.baseUrl}/subscription/add-Subscription'));

      request.fields.addAll({
        'CardId': model.cardId.toString(),
          'FirstName': model.firstName,
        'LastName': model.lastName,
        'Phone': model.phone,
        'Address': model.address
      });
      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> subscribeCard");
      }
      if (response.statusCode == 200) {
        // String jsonDataString = await response.stream.bytesToString();
        // final jsonData = jsonDecode(jsonDataString);

        emit(const SubscribeState(subscribeCardState: RequestState.loaded));
      } else {
        emit(const SubscribeState(subscribeCardState: RequestState.error));
      }
    } else {
      emit(const SubscribeState(subscribeCardState: RequestState.noInternet));
    }
  }
}
