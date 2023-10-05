import 'package:discovery_zone/core/shimmer/shimmer_widget.dart';
import 'package:discovery_zone/ui/components/container_shimmer.dart';
import 'package:flutter/material.dart';

class NotificationsShimmerWidget extends StatelessWidget {
  const NotificationsShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getShimmerWidget(
          child: ListView.builder(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 30, bottom: 40),
              itemCount: 15,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    crossAxisAlignment:   CrossAxisAlignment.center,
                    children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        
                          shape: BoxShape.circle, color: Colors.grey),
                    ),
                    const SizedBox(width: 10,),
                   
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContainerShimmerWisget(
                          hieght: 15,
                          width: 100,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ContainerShimmerWisget(
                          hieght: 15,
                          width: 200,
                        ),
                      ],
                    )
                  ]),
                );
              }))),
    );
  }
}
