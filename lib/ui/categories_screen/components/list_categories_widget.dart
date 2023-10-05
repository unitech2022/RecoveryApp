import 'package:cached_network_image/cached_network_image.dart';
import 'package:discovery_zone/core/animations/slide_transtion.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/core/utils/app_model.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:discovery_zone/models/category.dart';
import 'package:discovery_zone/ui/markets_screen/markets_screen.dart';
import 'package:flutter/material.dart';

class ListCategoriesWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  const ListCategoriesWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          CategoryModel categoryModel = categories[index];
          return GestureDetector(
            onTap: () {
              pushTranslationPage(
                context: context,
                transtion: FadTransition(
                    page: MarketsScreen(
                  id: categoryModel.id,type: 0, title: AppModel.lang==AppModel.arLang?categoryModel.nameAr:categoryModel.nameEng,
                )));
            },
            child: Container(
              height: 140,
              margin: const EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: ApiConstants.imageUrl(categoryModel.imageUrl),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        gradient: LinearGradient(
                            begin: Alignment(0.0, -1.279),
                            end: Alignment(0.0, 0.618),
                            colors: [Color(0x000d0d0d), Color(0xff000000)],
                            stops: [0.0, 1.0])),
                    child: Center(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Texts(
                              title: AppModel.lang == AppModel.arLang
                                  ? categoryModel.nameAr
                                  : categoryModel.nameEng,
                              textColor: Colors.white,
                              size: 16,
                              family: AppFonts.caM,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
