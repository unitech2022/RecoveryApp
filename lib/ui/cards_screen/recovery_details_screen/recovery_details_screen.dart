import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RecoveryDetailsScreen extends StatelessWidget {
  final String cardDetials;
  const RecoveryDetailsScreen({super.key,required this.cardDetials});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Texts(
            title:"ركوفرى كارد".tr(),
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
        // actions: [
        //  IconAlertWidget()
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                child: Texts(
              title: cardDetials,
              family: AppFonts.taB,
              size: 18,
              line: 300,
              algin: TextAlign.center,
              widget: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
