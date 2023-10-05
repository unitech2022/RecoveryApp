import 'package:cached_network_image/cached_network_image.dart';
import 'package:discovery_zone/core/animations/slide_transtion.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/shimmer/shimmer_widget.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/core/utils/app_model.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:discovery_zone/models/base_response.dart';

import 'package:discovery_zone/ui/daetails_market_screen/daetails_market_screen.dart';
import 'package:flutter/material.dart';

class ListMarketsWidget extends StatelessWidget {
  final List<MarketResponse> markets;
  const ListMarketsWidget({super.key, required this.markets});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 1.5 / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        shrinkWrap: true,
        itemCount: markets.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemBuilder: (BuildContext context, int index) {
          MarketResponse market = markets[index];
          return GestureDetector(
            onTap: () {
              pushTranslationPage(
                  context: context,
                  transtion: FadTransition(
                      page: DetailsMarketScreen(
                    marketModel: market.market,
                  )));
            },
            child: Container(
              // margin: const EdgeInsets.only(bottom: 25),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: ApiConstants.imageUrl(market.market.logoImage),
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => getShimmerWidget(
                        child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey),
                    )),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                // image Card
                market.card == null
                    ? SizedBox()
                    : Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 45,
                          width: 45,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                             shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.red, width: 2)),
                          child: ClipRRect(
                           borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              imageUrl:
                                  ApiConstants.imageUrl(market.card!.image),
                              width: double.infinity,
                              height: double.infinity,
                              placeholder: (context, url) => getShimmerWidget(
                                  child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey),
                              )),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
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
                                  ? market.market.nameAr
                                  : market.market.nameEng,
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
