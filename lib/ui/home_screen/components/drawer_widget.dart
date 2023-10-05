import 'dart:io';

import 'package:discovery_zone/bloc/home_cubit/home_cubit.dart';
import 'package:discovery_zone/core/animations/slide_transtion.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/router/routes.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:discovery_zone/core/utils/app_model.dart';
import 'package:discovery_zone/core/widgets/custom_button.dart';

import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:discovery_zone/ui/cards_screen/recovery_details_screen/recovery_details_screen.dart';
import 'package:discovery_zone/ui/notifications_screen/notifications_screen.dart';
import 'package:discovery_zone/ui/praivacy_screen/praivacy_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widthScreen(context) / 1.4,
      backgroundColor: Colors.white,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/logo.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ItemDrawerWidget(
                title: "الرئيسية".tr(),
                onTap: () {
                  pushPageRoutName(context, home);
                },
                color: const Color(0xff7E7E7E),
                icon: "assets/icons/home.svg",
              ),
              ItemDrawerWidget(
                title: "الاشعارات".tr(),
                onTap: () {
                  pushTranslationPage(
                      context: context,
                      transtion:
                          FadTransition(page: const NotificationsScreen()));
                },
                color: const Color(0xff7E7E7E),
                icon: 'assets/icons/noty.svg',
              ),
              ItemDrawerWidget(
                title: "ركوفرى كارد".tr(),
                onTap: () {
                  pushTranslationPage(
                      context: context,
                      transtion:
                          FadTransition(page: RecoveryDetailsScreen(cardDetials:state.homeResponse!.cardDetails)));
                },
                color: const Color(0xff7E7E7E),
                icon: 'assets/icons/card.svg',
              ),
              ItemDrawerWidget(
                title: "تواصل معنا".tr(),
                onTap: () {
                  showBottomSheetWidget(
                      context,
                      callUs(
                          context,
                          state.homeResponse != null
                              ? state.homeResponse!.callUsNumber
                              : ""));
                },
                color: const Color(0xff7E7E7E),
                icon: 'assets/icons/call_menu.svg',
              ),
              ItemDrawerWidget(
                title: "الشروط والأحكام".tr(),
                onTap: () {
                  pushTranslationPage(
                      context: context,
                      transtion: FadTransition(page: const PrivacyScreen()));
                },
                color: const Color(0xff7E7E7E),
                icon: 'assets/icons/us.svg',
              ),
              ItemDrawerWidget(
                title: "قيم التطبيق".tr(),
                onTap: () {
                  pushPageRoutName(context, home);
                },
                color: const Color(0xff7E7E7E),
                icon: 'assets/icons/star.svg',
              ),
              ItemDrawerWidget(
                title: "شارك التطبيق".tr(),
                onTap: () {
                  Share.share('https://recovery_zone.com',
                      subject: "Recovery Zone App");
                },
                color: const Color(0xff7E7E7E),
                icon: 'assets/icons/share.svg',
              ),
              ItemDrawerWidget(
                title: "تغيير اللغة".tr(),
                onTap: () {
                  pop(context);

                  showChangeLangDialog(context);
                },
                icon: 'assets/icons/translate.svg',
                color: const Color(0xff7E7E7E),
              ),
            ]),
          );
        },
      ),
    );
  }

  void showChangeLangDialog(BuildContext context) {
    showDialog<void>(
      context: context,

      barrierDismissible: false,
      // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            "تغيير اللغة".tr(),
            style: const TextStyle(fontSize: 20, color: Palette.mainColor),
          ),
          content: SizedBox(
            width: widthScreen(context),
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        "هل تريد تغيير لغة التطبيق  ؟".tr(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    elevation: 0,
                    backgroundColor: Palette.mainColor,
                    titleColor: Colors.white,
                    onPressed: () async {
                      if (AppModel.lang == "en") {
                        AppModel.lang = "ar";
                        context.setLocale(const Locale('ar'));
                        await saveData(ApiConstants.langKey, 'ar');
                        pop(context);
                        Navigator.pushNamed(context, splash);
                      } else {
                        AppModel.lang = "en";
                        context.setLocale(const Locale('en'));
                        await saveData(ApiConstants.langKey, 'en');
                        pop(context);
                        Navigator.pushNamed(context, splash);
                      }
                    },
                    title: "تغيير".tr(),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomButton(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    titleColor: Colors.red,
                    onPressed: () async {
                      pop(context);
                    },
                    title: "الغاء".tr(),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

void showBottomSheetWidget(context, child) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return child;
      });
}

callUs(context, phone) => Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.5),
                color: const Color(0xFFDCDCDF),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        launch('tel:+$phone');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF6F2F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.call,
                              size: 30,
                              color: Palette.mainColor,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Texts(
                                title: "اتصال".tr(),
                                family: AppFonts.caB,
                                size: 15,
                                textColor: Colors.black)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        pop(context);
                        // await FlutterLaunch.launchWhatsapp(
                        //     phone: "00966557755462", message: "مرحبا").then((value) => null);
                        var whatsappURl_android =
                            "whatsapp://send?phone=+$phone";
                        var whatappURL_ios =
                            "https://wa.me/+$phone?text=${Uri.parse("مرحبا بك")}";
                        if (Platform.isIOS) {
                          // for iOS phone only
                          if (await canLaunch(whatappURL_ios)) {
                            await launch(whatappURL_ios, forceSafariVC: false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: new Text("whatsapp no installed")));
                          }
                        } else {
                          // android , web
                          if (await canLaunch(whatsappURl_android)) {
                            await launch(whatsappURl_android);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: new Text("whatsapp no installed")));
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF6F2F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              size: 30,
                              color: Palette.mainColor,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Texts(
                                title: "واتساب".tr(),
                                family: AppFonts.caB,
                                size: 15,
                                textColor: Colors.black)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

class ItemDrawerWidget extends StatelessWidget {
  final String title, icon;
  final void Function() onTap;

  final Color color;
  const ItemDrawerWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: .3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(icon,
                    height: 20, width: 20, color: Palette.mainColor),
                const SizedBox(
                  width: 13,
                ),
                Texts(
                    title: title,
                    family: AppFonts.taB,
                    size: 16,
                    height: .8,
                    textColor: Palette.mainColor,
                    widget: FontWeight.bold)
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Palette.mainColor,
                  size: 15,
                ))
          ],
        ),
      ),
    );
  }
}
