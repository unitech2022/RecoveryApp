import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer getShimmerWidget({child}) {
  return Shimmer.fromColors(
      child: child,
      baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,);
}
