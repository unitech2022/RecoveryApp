import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xffFEFEFE),
              elevation: 0,
              automaticallyImplyLeading: true,

              title: Texts(
                  title:  "الشروط والأحكام".tr(),
                  family: AppFonts.taB,
                  size: 18,
                  widget: FontWeight.bold),
              // actions: [
              //  IconAlertWidget()
              // ],
            ),
            body: Texts(
                  title:  "الشروط والأحكام".tr(),
                  family: AppFonts.taB,
                  size: 18,
                  widget: FontWeight.bold),
              // actions: [
              //  IconAlertWidget()
              // ],
            
    );
  }
}