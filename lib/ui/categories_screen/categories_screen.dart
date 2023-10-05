import 'package:discovery_zone/bloc/category_cubit/category_cubit.dart';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/shimmer/shimmer_widget.dart';
import 'package:discovery_zone/core/utils/app_model.dart';

import 'package:discovery_zone/core/widgets/empty_list_widget.dart';
import 'package:discovery_zone/core/widgets/texts.dart';

import 'package:discovery_zone/models/field.dart';
import 'package:discovery_zone/ui/categories_screen/components/list_categories_widget.dart';
import 'package:discovery_zone/ui/components/container_shimmer.dart';
import 'package:discovery_zone/ui/components/no_internet_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/helper_functions.dart';

class CategoriesScreen extends StatefulWidget {
  final FieldModel fieldModel;
  const CategoriesScreen({super.key, required this.fieldModel});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryCubit.get(context)
        .getCategories(context: context, fieldId: widget.fieldModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: const BackButton(
          color: Palette.mainColor,
        ),
        title: Texts(
          title: AppModel.lang == AppModel.arLang
              ? widget.fieldModel.nameAr
              : widget.fieldModel.nameEng,
          family: AppFonts.caB,
          size: 25,
          textColor: Palette.mainColor,
          height: 2.0,
        ),
        // actions: const [IconAlertWidget()],
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          switch (state.getCategoriesState) {
            case RequestState.noInternet:
              return NoInternetWidget(
                onPress: () {
                  CategoryCubit.get(context).getCategories(
                      context: context, fieldId: widget.fieldModel.id);
                },
              );
            case RequestState.loaded:
              return state.categories.isEmpty?
              
              EmptyListWidget(message: "لا توجد أقسام".tr())
              : ListCategoriesWidget(categories: state.categories);
            case RequestState.error:
            case RequestState.loading:
              return Scaffold(
            body: getShimmerWidget(
              child: ListView(
                children: [
                  sizedHeight(5),
             
                  // *** slider
               const SizedBox(
                    height: 35,
                  ),

                  Container(
                    height: 140,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),

                  const ContainerShimmer(
                    hieght: 140,
                  ),
                  const ContainerShimmer(
                    hieght: 140,
                  ),
                  const ContainerShimmer(
                    hieght: 140,
                  ),
                ],
              ),
            ),
          );
             default:
          return Scaffold(
            body: getShimmerWidget(
              child: ListView(
                children: [
                  sizedHeight(5),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 15,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  sizedHeight(20),
                  // *** slider
               const SizedBox(
                    height: 35,
                  ),

                 const ContainerShimmer(
                    hieght: 140,
                  ),

                  const ContainerShimmer(
                    hieght: 140,
                  ),
                  const ContainerShimmer(
                    hieght: 140,
                  ),
                 
                ],
              ),
            ),
          );
              // TODO: Handle this case.
          }
        },
      ),
    );
  }
}
