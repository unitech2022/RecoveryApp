import 'package:cached_network_image/cached_network_image.dart';
import 'package:discovery_zone/core/animations/slide_transtion.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/core/widgets/custom_button.dart';
import 'package:discovery_zone/models/card_model.dart';
import 'package:discovery_zone/ui/cards_screen/subscrip_card_screen/subscrip_card_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListCardsWidget extends StatelessWidget {
  final List<CardModel> cards;
  const ListCardsWidget({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cards.length,
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        CardModel categoryModel = cards[index];
        return Container(
          height: 250,
          margin: const EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Stack(children: [
            Padding(
              padding:const EdgeInsets.only(bottom: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.imageUrl(categoryModel.image),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
             bottom: 0,
             left: 40,
             right: 40,
              child: CustomButton(
                radius: 25,
                elevation: 10,
                backgroundColor: Palette.secondaryColor,
              titleColor: Palette.mainColor,
                title: "احصل علي الكارد".tr(), onPressed: () { 
                        pushTranslationPage(
                context: context,
                transtion: FadTransition(
                    page: SubscribeCardScreen(
                  id: categoryModel.id,
                      titleBar: "",
                 
                )));
                 },
                    
                
                ),
              ),
            
          ]),
        );
      },
    );
  }
}
