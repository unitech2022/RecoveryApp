import 'package:discovery_zone/core/extension/theme_extension.dart';
import 'package:discovery_zone/core/layout/screen_size.dart';
import 'package:flutter/material.dart';


import '../layout/app_fonts.dart';
import '../layout/app_radius.dart';
import '../layout/app_sizes.dart';
import '../layout/palette.dart';



class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.backgroundColor = Palette.mainColor,
    this.borderSide = BorderSide.none,
    this.titleColor = Palette.white,
    required this.onPressed,
    this.elevation = 2.0,this.radius=10
  }) : super(key: key);

  final Color backgroundColor;
  final BorderSide borderSide;
  final String title;
  final Color titleColor;
  final VoidCallback? onPressed;
  final double elevation ,radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.wSize,
      height: AppSize.s50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
            backgroundColor,
          ),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: borderSide,
              );
            }
            return  RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(radius),
            );
          }),
        ),
        child: Text(
          title,
          style: context.titleM.copyWith(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.taB,
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    Key? key,
    required this.title,
    this.backgroundColor = Palette.mainColor,
    this.borderSide = BorderSide.none,
    this.titleColor = Palette.white,
    required this.onPressed,
    this.elevation = 2.0,
    required this.icon,
  }) : super(key: key);

  final Color backgroundColor;
  final BorderSide borderSide;
  final String title;
  final Color titleColor;
  final VoidCallback? onPressed;
  final double elevation;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.wSize,
      height: AppSize.s46,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          title,
          style: TextStyle(
            color: titleColor,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: AppRadius.r10,
                side: borderSide,
              );
            }
            return const RoundedRectangleBorder(
              borderRadius: AppRadius.r10,
            );
          }),
        ),
      ),
    );
  }
}
