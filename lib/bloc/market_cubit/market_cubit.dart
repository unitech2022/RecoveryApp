import 'dart:convert';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/models/base_response.dart';
import 'package:discovery_zone/models/market_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit() : super(const MarketState());

  static MarketCubit get(context) => BlocProvider.of<MarketCubit>(context);

  List<MarketResponse> markets = [];

  int currentPage = 1;

  int totalPages = 1;

  // ** get markets By fieldId
  Future getMarketsByFieldId({context, id, page}) async {
    if (page == 1) {
      markets = [];
       emit(const MarketState(getMarketsState: RequestState.loading));
    }else {
       emit(const MarketState(getMarketsState: RequestState.pagination));
    }
    bool hasInternetResult = await hasInternet();
   
    if (hasInternetResult) {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstants.baseUrl}/Market/get-Markets-by-fieldId?page=$page&fieldId=$id'));

      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> getMarketsByFieldId");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);
        BaseResponse baseResponse = BaseResponse.fromJson(jsonData);
       currentPage = baseResponse.currentPage;
        totalPages = baseResponse.totalPages;
        markets.addAll(baseResponse.items);  
        emit(MarketState(
            response: baseResponse, getMarketsState: RequestState.loaded));
      } else {
        emit(const MarketState(getMarketsState: RequestState.error));
      }
    } else {
      emit(const MarketState(getMarketsState: RequestState.noInternet));
    }
  }

  // ** get markets By CategoryId

  Future getMarketsByCategoryId({context, id, page}) async {
   
    if (page == 1) {
      markets = [];
       emit(const MarketState(getMarketsState: RequestState.loading));
    }else {
       emit(const MarketState(getMarketsState: RequestState.pagination));
    }
    bool hasInternetResult = await hasInternet();
    emit(const MarketState(getMarketsState: RequestState.loading));
    if (hasInternetResult) {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstants.baseUrl}/Market/get-Markets-by-catId?page=$page&categoryId=$id'));

      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> getMarketsByCategoryId");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);
        BaseResponse baseResponse = BaseResponse.fromJson(jsonData);
        currentPage = baseResponse.currentPage;
        totalPages = baseResponse.totalPages;
        markets.addAll(baseResponse.items);
        
        emit(MarketState(
            response: baseResponse, getMarketsState: RequestState.loaded));
      } else {
        emit(const MarketState(getMarketsState: RequestState.error));
      }
    } else {
      emit(const MarketState(getMarketsState: RequestState.noInternet));
    }
  }
}
