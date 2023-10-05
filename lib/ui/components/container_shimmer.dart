import 'package:flutter/material.dart';

class ContainerShimmer extends StatelessWidget {
  final double hieght;
  
  const ContainerShimmer({
    super.key,
    required this.hieght,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hieght,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
    );
  }
}
class ContainerShimmerWisget extends StatelessWidget {
  final double hieght,width;
  
  const ContainerShimmerWisget({
    super.key,
    required this.hieght, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hieght,
      width: width,
     
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
    );
  }
}