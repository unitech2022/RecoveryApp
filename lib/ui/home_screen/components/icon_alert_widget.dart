import 'package:discovery_zone/core/layout/palette.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
class IconAlertWidget extends StatelessWidget {
  const IconAlertWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
       padding: const EdgeInsets.symmetric(horizontal: 10),
                   onPressed: () {
                     // pushPageRoutName(context, notyUser);
                   },
                   minWidth: 40,
                   height: 40,
                   child: badges.Badge(
                     badgeContent: const Text(
                       "4",
                       style: TextStyle(
                           color: Colors.white, height: 1.8),
                     ),
                     position:
                     badges.BadgePosition.topStart(top: -12),
                     badgeStyle: const badges.BadgeStyle(
                         badgeColor: Palette.mainColor),
                     child:
                     SvgPicture.asset("assets/icons/noty.svg"),
                   ),
                 ),
    );
  }
}
