import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/widgets/custom_button.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final void Function() onPress;
  const NoInternetWidget({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Texts(
              title: "لا يوجد اتصال بالانترنت".tr(),
              family: AppFonts.taB,
              size: 20,
              textColor: Colors.black,
              widget: FontWeight.w700),
          const SizedBox(
            height: 20,
          ),
          const Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 50,
          ),
          CustomButton(
            title: "اعادة المحاولة".tr(),
            onPressed: onPress,
            backgroundColor: Colors.red,
          )
        ],
      ),
    ));
  }
}
