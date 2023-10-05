import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/models/category.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState());
  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);

  // ** get home User
  Future getCategories({context, fieldId}) async {
      emit(const CategoryState(getCategoriesState: RequestState.loading));
    bool hasInternetResult = await hasInternet();
  
    if (hasInternetResult) {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${ApiConstants.baseUrl}/category/get-categories-byFieldid?fieldId=$fieldId'));

      http.StreamedResponse response = await request.send();

      if (kDebugMode) {
        print("${response.statusCode}=======> getCategories");
      }
      if (response.statusCode == 200) {
        String jsonDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonDataString);

        print(jsonData);
        emit(CategoryState(
            categories: List<CategoryModel>.from(
                (jsonData as List).map((e) => CategoryModel.fromJson(e))),
            getCategoriesState: RequestState.loaded));
      } else {
        emit(const CategoryState(getCategoriesState: RequestState.error));
      }
    } else {
      emit(const CategoryState(getCategoriesState: RequestState.noInternet));
    }
  }
}
