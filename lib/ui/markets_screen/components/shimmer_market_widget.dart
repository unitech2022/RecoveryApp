import 'package:discovery_zone/core/shimmer/shimmer_widget.dart';
import 'package:flutter/material.dart';

class ShimmerMarketWidget extends StatelessWidget {
  const ShimmerMarketWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getShimmerWidget(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            childAspectRatio: 1.5 / 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
        shrinkWrap: true,
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
           
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)),
          );
        },
      ),
    ));
  }
}
