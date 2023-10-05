import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/models/offer.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final List<OfferModel> offers;
  const CarouselWidget({
    super.key,
    required this.offers,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            onPageChanged: (newIndex, car) {
              index = newIndex;
              setState(() {});
            },
            // aspectRatio: 0,
            //  enlargeCenterPage: true,
            aspectRatio: .9,
            viewportFraction:1,
            scrollDirection: Axis.horizontal,
            height: 180,
            autoPlay: true,
            reverse: true,
            enableInfiniteScroll: true,
            initialPage: 0,
          ),
          itemCount: widget.offers.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            OfferModel offerModel = widget.offers[itemIndex];
            return InkWell(
              onTap: () {},
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(15)
                    ),
                child: ClipRRect(
                    // borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                  imageUrl: ApiConstants.imageUrl(offerModel.image),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        // ** indicator
        CarouselIndicator(
          width: 8,
          height: 8,
          activeColor: Palette.mainColor,
          color: Colors.grey.withOpacity(.5),
          cornerRadius: 40,
          count: widget.offers.length,
          index: index,
        ),
      ],
    );
  }
}
