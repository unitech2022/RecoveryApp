import 'package:discovery_zone/core/shimmer/shimmer_widget.dart';
import 'package:flutter/material.dart';

class ShimmerCardsWidget extends StatelessWidget {
  const ShimmerCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getShimmerWidget(
        child: Container(
          height: 250,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 25 ,left: 30,right: 30,top: 20),

        
          decoration: BoxDecoration(  color: Colors.grey,borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
