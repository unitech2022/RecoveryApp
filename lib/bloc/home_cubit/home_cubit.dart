import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/models/home_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  // ** get home User
  Future getHomeUser({context}) async {
    bool hasInternetResult = await hasInternet();
    emit(HomeState(getHomeState: RequestState.loading));
    if (hasInternetResult) {
      var request = http.Request(
          'GET', Uri.parse('${ApiConstants.baseUrl}/home/get-home-data'));

      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> getHome");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);

        HomeResponse homeResponse = HomeResponse.fromJson(jsonData);

        emit(HomeState(
            getHomeState: RequestState.loaded, homeResponse: homeResponse));
      } else {
          emit(const HomeState(getHomeState: RequestState.error));
      }
    } else {
      emit(const HomeState(getHomeState: RequestState.noInternet));
    }
  }


}
