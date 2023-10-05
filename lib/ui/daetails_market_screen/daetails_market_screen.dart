import 'package:cached_network_image/cached_network_image.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/core/utils/app_model.dart';
import 'package:discovery_zone/core/widgets/custom_button.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:discovery_zone/models/market_model.dart';
import 'package:discovery_zone/ui/daetails_market_screen/show_image_screen/show_image_screen.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class DetailsMarketScreen extends StatefulWidget {
  final MarketModel marketModel;
  const DetailsMarketScreen({super.key, required this.marketModel});

  @override
  State<DetailsMarketScreen> createState() => _DetailsMarketScreenState();
}

class _DetailsMarketScreenState extends State<DetailsMarketScreen> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: CustomButton(
            radius: 25,
            elevation: 10,
            backgroundColor: Palette.secondaryColor,
            titleColor: Palette.mainColor,
            title: "للتواصل".tr(),
            onPressed: () async {
              getUrl();
            },
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: const BackButton(
            color: Palette.mainColor,
          ),

          title: Texts(
            title: AppModel.lang == AppModel.arLang
                ? widget.marketModel.nameAr
                : widget.marketModel.nameEng,
            family: AppFonts.caB,
            size: 18,
            textColor: Palette.mainColor,
            height: 2.0,
          ),
          // actions: const [IconAlertWidget()],
        ),
        body: GridView.builder(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 100),
            //  if (state.photosStat == RequestState.pagination)

            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3),
            itemBuilder: (BuildContext context, int index) {
              String photo = widget.marketModel.images.split("#")[index];
              return GestureDetector(
                onTap: () {
                  pushPage(context, ShowImageScreen(images: photo));
                },
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: CachedNetworkImage(
                    // placeholder: (context, url)=>PlaceHolderWidget(),
                    // cacheManager: CustomCacheManager.instance,
                    key: UniqueKey(),
                    imageUrl: ApiConstants.imageUrl(photo),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            itemCount: widget.marketModel.images.split("#").length)

        // CarouselSlider.builder(
        //   options: CarouselOptions(
        //     onPageChanged: (newIndex, car) {
        //       index = newIndex;
        //       setState(() {});
        //     },
        //     // aspectRatio: 0,
        //     //  enlargeCenterPage: true,
        //     aspectRatio: .9,
        //     viewportFraction: 1,
        //     scrollDirection: Axis.horizontal,
        //     height: MediaQuery.of(context).size.height / 2,
        //     autoPlay: false,
        //     reverse: true,
        //     enableInfiniteScroll: true,
        //     initialPage: 0,
        //   ),
        //   itemCount: widget.marketModel.images.split("#").length,
        //   itemBuilder:
        //       (BuildContext context, int itemIndex, int pageViewIndex) {
        //     String image = widget.marketModel.images.split("#")[itemIndex];
        //     return InkWell(
        //       onTap: () {
        //         pushTranslationPage(
        //             context: context,
        //             transtion: FadTransition(
        //                 page: ShowImageScreen(
        //               images: widget.marketModel.images.split("#"),
        //             )));
        //       },
        //       child: Container(
        //         height: 250,
        //         width: double.infinity,
        //         decoration: const BoxDecoration(
        //             // borderRadius: BorderRadius.circular(15)
        //             ),
        //         child: ClipRRect(
        //             // borderRadius: BorderRadius.circular(15),
        //             child: CachedNetworkImage(
        //           imageUrl: ApiConstants.imageUrl(image),
        //           width: double.infinity,
        //           height: double.infinity,
        //           fit: BoxFit.cover,
        //           errorWidget: (context, url, error) => const Icon(Icons.error),
        //         )),
        //       ),
        //     );
        //   },
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        // // ** indicator
        // CarouselIndicator(
        //   width: 8,
        //   height: 8,
        //   activeColor: Palette.mainColor,
        //   color: Colors.grey.withOpacity(.5),
        //   cornerRadius: 40,
        //   count: widget.marketModel.images.split("#").length,
        //   index: index,
        // ),
        );
  }

  getUrl() async {
    var url = Uri.parse(widget.marketModel.link);
    if (!await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
