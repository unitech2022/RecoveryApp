import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:discovery_zone/core/helpers/notification_controller.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_model.dart';

pushPage(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

// widthScreen(BuildContext context) {
//   return MediaQuery.of(context).size.width;
// }

// heightScreen(BuildContext context) {
//   return MediaQuery.of(context).size.height;
// }

// Future launchUrl(url) async {
//   final Uri _url = Uri.parse(url);

//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }
//   return null;
// }

// class CustomCacheManager {
//   static const key = 'customCacheKey';
//   static CacheManager instance = CacheManager(
//     Config(
//       key,
//       stalePeriod: const Duration(days: 15),
//       maxNrOfCacheObjects: 20,
//     ),
//   );
// }

showTopMessage({context, customBar}) {
  showTopSnackBar(
    Overlay.of(context),
    customBar,
  );
}

// FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// void firebaseCloudMessagingListeners() {
//   if (Platform.isIOS) {
//     _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }

//   _firebaseMessaging.getToken().then((token) {
//     AppModel.deviceToken = token!;
//     if (kDebugMode) {
//       print("${AppModel.deviceToken} =====> DIVICEToken");
//     }
//   });
// }

showSheet(BuildContext context, child) {
  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return child;
    },
  );
}

callUs(context) => Container(
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
                        launch('tel:+966557755462');
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
                            "whatsapp://send?phone=+966557755462";
                        var whatappURL_ios =
                            "https://wa.me/+966557755462?text=${Uri.parse("مرحبا بك")}";
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

replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

pop(context) {
  Navigator.pop(context);
}

// signOut({ctx}) async {
//   const storage = FlutterSecureStorage();

//   token = "";
//   await storage.delete(key: "token");
//   await storage.delete(key: "role");
//   currentUser.token = '';
//   token = '';
//   currentUser.role = null;
//   currentUser.id = null;

// }

pushPageRoutName(context, route) {
  Navigator.pushNamed(
    context,
    route,
  );
}

pushPageRoutNameReplaced(context, route) {
  Navigator.pushReplacementNamed(
    context,
    route,
  );
}

widthScreen(context) => MediaQuery.of(context).size.width;

heightScreen(context) => MediaQuery.of(context).size.height;

SizedBox sizedHeight(double height) => SizedBox(
      height: height,
    );
SizedBox sizedWidth(double width) => SizedBox(
      width: width,
    );

// showTopMessage({context, customBar}) {
//   showTopSnackBar(
//     Overlay.of(context),
//     customBar,
//   );
// }

saveToken(String userId) {
  const storage = FlutterSecureStorage();

  storage.write(key: 'id', value: userId);
  // storage.write(key: 'userName', value: user.userName);

  // storage.write(key: 'deviceToken', value: user.deviceToken);
  // storage.write(key: 'role', value: user.role);
  // storage.write(key: 'lat', value: userResponse.user!.lat.toString());
  //   storage.write(key: 'lng', value: userResponse.user!.lng.toString());
  // storage.write(key: 'name', value: userResponse.user!.fullName);
  // storage.write(key: 'email', value: currentUser!.user!.email);
  // storage.write(key: 'image', value:currentUser!.user!.profileImage

  // );
}

readData() async {
  const storage = FlutterSecureStorage();
  try {
    AppModel.lang = (await storage.read(key: "lang"))!;
    AppModel.userId = (await storage.read(key: "id"))!;

    if (kDebugMode) {
      print("token : ${AppModel.userId}");
    }
  } catch (e) {
    if (kDebugMode) {
      print("$e error reading data");
    }
  }
}

Future<void> showMyDialog({context, onTap}) async {
  return showDialog<void>(
    context: context,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        content: Container(
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          width: widthScreen(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/close.svg")),
                ],
              ),
              SvgPicture.asset("assets/icons/location.svg"),
              const SizedBox(
                height: 16,
              ),
              const Texts(
                  title: "هل تسمح بالتطبيق بالوصول لموقعك ",
                  family: AppFonts.moS,
                  size: 12,
                  textColor: Colors.black,
                  widget: FontWeight.w700),
              const SizedBox(
                height: 23,
              ),
              GestureDetector(
                onTap: onTap,
                child: const Texts(
                    title: "نعم أسمح بذلك ",
                    family: AppFonts.moS,
                    size: 13,
                    textColor: Color(0xffB8B8B8),
                    widget: FontWeight.w700),
              ),
              const SizedBox(
                height: 23,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showDialogSuccess({context, message}) {
  return showDialog<void>(
    context: context,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        content: Container(
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          width: widthScreen(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/close.svg")),
                ],
              ),
              SvgPicture.asset("assets/icons/successd.svg"),
              const SizedBox(
                height: 16,
              ),
              Texts(
                  title: message,
                  line: 2,
                  family: AppFonts.taM,
                  size: 18,
                  algin: TextAlign.center,
                  textColor: Colors.black,
                  widget: FontWeight.normal),
            ],
          ),
        ),
      );
    },
  );
}

Future saveData(key, value) async {
  const storage = FlutterSecureStorage();
  storage.write(key: key, value: value);
}

// DateTime INIT_DATETIME = DateTime.now();
// void showDateTimePicker2(context, {onConfirm}) {
//   DateTime? dateAdded;
//   showModalBottomSheet(
//       context: context,
//       // clipBehavior: Clip.antiAlias,
//       backgroundColor: Colors.white,
//       // isScrollControlled: true,
//       builder: (BuildContext bc) {
//         return Container(
//             height: 400,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: CupertinoDatePicker(
//                       backgroundColor: Colors.white,
//                       use24hFormat: false,
//                       mode: CupertinoDatePickerMode.date,
//                       initialDateTime: INIT_DATETIME,
//                       // minuteInterval: 30,
//                       onDateTimeChanged: (date) {
//                         dateAdded = date;
//                       }),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: MaterialButton(
//                             onPressed: () {
//                               onConfirm(dateAdded);
//                             },
//                             color: Palette.mainColor,
//                             height: 40,
//                             child: Text("اختيار".tr(),
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 16))),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Expanded(
//                         child: MaterialButton(
//                             onPressed: () {
//                               pop(context);
//                             },
//                             color: Colors.red,
//                             height: 40,
//                             child: Text(
//                               "الغاء".tr(),
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 16),
//                             )),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ));
//       });
//   ;
// }

// Future<void> showDialogLogin({context, message}) {
//   return showDialog<void>(
//     context: context,

//     barrierDismissible: false,
//     // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 30),
//         content: Container(
//           // padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//           width: widthScreen(context),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         pop(context);
//                       },
//                       child: SvgPicture.asset("assets/icons/close.svg")),
//                 ],
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Texts(
//                   title: "من فضلك سجل الدخول حتي تتمكن من التسوق ".tr(),
//                   line: 2,
//                   family: AppFonts.taM,
//                   size: 18,
//                   algin: TextAlign.center,
//                   textColor: Colors.black,
//                   widget: FontWeight.normal),
//               const SizedBox(
//                 height: 16,
//               ),
//               CustomButton(
//                   title: "تسجيل الدخول".tr(),
//                   onPressed: () {
//                     pop(context);
//                     pushPageRoutName(context, selectAccount);
//                   })
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// openGoogleMapLocation({lat, lng}) async {
//   // try{
//   // String mapOptions = [
//   //   'saddr=${locData.latitude},${locData.longitude}',
//   //   'daddr=$lat,$lng',
//   //   'dir_action=navigate'
//   // ].join('&');

//   //   String url = 'https://www.google.com/maps?$mapOptions';
//   // // if (await canLaunchUrl(Uri.parse(url),)) {
//   //   await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
//   // // } else {
//   // //   throw 'Could not launch $url';
//   // // }
//   // }catch(e){
//   //    throw 'Could not launch ${e}';
//   // }

//   String appleUrl =
//       'https://maps.apple.com/?saddr=${locData.latitude},${locData.longitude}&daddr=$lat,$lng&directionsmode=driving';
//   String googleUrl =
//       'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

//   Uri appleUri = Uri.parse(appleUrl);
//   Uri googleUri = Uri.parse(googleUrl);

//   if (Platform.isIOS) {
//     if (await canLaunchUrl(appleUri)) {
//       await launchUrl(appleUri, mode: LaunchMode.externalApplication);
//     } else {
//       if (await canLaunchUrl(googleUri)) {
//         await launchUrl(googleUri, mode: LaunchMode.externalApplication);
//       }
//     }
//   } else {
//     if (await canLaunchUrl(googleUri)) {
//       await launchUrl(googleUri, mode: LaunchMode.externalApplication);
//     }
//   }
// }

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

void showDialogWidget(BuildContext context, Widget child) {
  showDialog<void>(
    context: context,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: child,
      );
    },
  );
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd', "en");
  final String formatted = formatter.format(date);
  return formatted; // something like 2013-04-20
}

String formatDate2(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm', "en");
  final String formatted = formatter.format(date);
  return formatted; // something like 2013-04-20
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<bool> hasInternet() async {
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
void firebaseCloudMessagingListeners() {
  if (Platform.isIOS) {
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    _firebaseMessaging.subscribeToTopic("users");
  }else{
    _firebaseMessaging.subscribeToTopic("users");
  }


}

void inItFCMNotification() async {
  firebaseCloudMessagingListeners();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // NotifyAowsome(notification!.title!,notification.body!);
    // if (notification != null && android != null && !kIsWeb) {
      print("tokrrrrrrnseneeeeee");

      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: createUniqueId(),

        color: Colors.blue,

        channelKey: 'recovery',
        title: notification!.title,
        body: notification.body,

        // notificationLayout: NotificationLayout.BigPicture,
        // largeIcon: "asset://assets/images/logo_final.png"
      ));
      AwesomeNotifications().setListeners(
          onActionReceivedMethod: NotificationController.onActionReceivedMethod,
          onNotificationCreatedMethod:
              NotificationController.onNotificationCreatedMethod,
          onNotificationDisplayedMethod:
              NotificationController.onNotificationDisplayedMethod,
          onDismissActionReceivedMethod:
              NotificationController.onDismissActionReceivedMethod);
      // print("aaaaaaaaaaaawww${message.data["desc"]}");
    // }
  });
}


    // "service_id":"",
    // "template_id":"",
    // "user_id":"





