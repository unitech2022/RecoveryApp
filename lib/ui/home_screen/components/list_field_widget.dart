import 'package:cached_network_image/cached_network_image.dart';
import 'package:discovery_zone/core/animations/slide_transtion.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/core/utils/app_model.dart';
import 'package:discovery_zone/core/widgets/custom_button.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:discovery_zone/models/field.dart';
import 'package:discovery_zone/ui/cards_screen/cards_screen.dart';
import 'package:discovery_zone/ui/categories_screen/categories_screen.dart';
import 'package:discovery_zone/ui/markets_screen/markets_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class ListFieldWidget extends StatefulWidget {
  final List<FieldModel> fields;
  final String code;
  const ListFieldWidget({super.key, required this.fields, required this.code});

  @override
  State<ListFieldWidget> createState() => _ListFieldWidgetState();
}

class _ListFieldWidgetState extends State<ListFieldWidget> {
  final _controllerCode = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.fields.length,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        FieldModel fieldModel = widget.fields[index];
        return GestureDetector(
          onTap: () {
            // ** *fieldModel.status =0 normal 1 ===> markets  2 ======> cards
            if (fieldModel.status == 0) {
              pushTranslationPage(
                  context: context,
                  transtion: FadTransition(
                      page: CategoriesScreen(
                    fieldModel: fieldModel,
                  )));
            } else if (fieldModel.status == 2) {
              pushTranslationPage(
                  context: context,
                  transtion: FadTransition(
                      page: CardsScreen(
                    titleBar: AppModel.lang == AppModel.arLang
                        ? fieldModel.nameAr
                        : fieldModel.nameEng,
                  )));
            } else {
              loginToMarkets(context, fieldModel, widget.code);
            }
          },
          child: Container(
            height: 140,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.imageUrl(fieldModel.imageUrl),
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
                                ? fieldModel.nameAr
                                : fieldModel.nameEng,
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
    );
  }

  Future<dynamic> loginToMarkets(
      BuildContext context, FieldModel fieldModel, String code) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              width: double.infinity,
              // height: heightScreen(context) / 1.5,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // sizedHeight(15),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            pop(context);
                          },
                          icon: Icon(Icons.close, color: Colors.black))
                    ],
                  ),

                  sizedHeight(20),

                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: .8)),
                    child: TextField(
                      controller: _controllerCode,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          hintText: "اكتب كود الدخول".tr(),
                          hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontFamily: AppFonts.taM),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onPressed: () {
                      if (code == _controllerCode.text.trim()) {
                        pop(context);
                        pushTranslationPage(
                            context: context,
                            transtion: FadTransition(
                                page: MarketsScreen(
                              id: fieldModel.id,
                              type: 1,
                              title: AppModel.lang == AppModel.arLang
                                  ? fieldModel.nameAr
                                  : fieldModel.nameEng,
                            )));
                        _controllerCode.clear();
                      } else {
                        showTopMessage(
                            context: context,
                            customBar: CustomSnackBar.error(
                              backgroundColor: Colors.red,
                              message: "الكود غير صحيح".tr(),
                              textStyle: const TextStyle(
                                  fontFamily: "font",
                                  fontSize: 16,
                                  color: Colors.white),
                            ));
                      }
                    },
                    title: "دخول".tr(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
