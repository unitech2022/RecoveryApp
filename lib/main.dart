import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:discovery_zone/bloc/app_cubit/app_cubit.dart';
import 'package:discovery_zone/bloc/auth_cubit/auth_cubit.dart';
import 'package:discovery_zone/bloc/cards_cubit/cards_cubit.dart';
import 'package:discovery_zone/bloc/category_cubit/category_cubit.dart';
import 'package:discovery_zone/bloc/market_cubit/market_cubit.dart';
import 'package:discovery_zone/bloc/notification_cubit/notification_cubit.dart';
import 'package:discovery_zone/bloc/subscribe_cubit/subscribe_cubit.dart';
import 'package:discovery_zone/core/router/routes.dart';
import 'package:discovery_zone/core/styles/thems.dart';
import 'package:discovery_zone/core/utils/payment.dart';
import 'package:discovery_zone/ui/home_screen/home_screen.dart';
import 'package:discovery_zone/ui/payment_test.dart';
import 'package:discovery_zone/ui/selecte_lang_screen/selecte_lang_screen.dart';
import 'package:discovery_zone/ui/splash_screen/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_cubit/home_cubit.dart';
import 'core/helpers/helper_functions.dart';

Future<void> _messageHandler(RemoteMessage message) async {}
void initLocalNotification() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'recovery',
      channelName: 'recovery',
      channelDescription: "Notification recovery",
      defaultColor: Colors.transparent,
      ledColor: Colors.blue,
      channelShowBadge: true,
      importance: NotificationImportance.High,
      // playSound: true,
      // enableLights:true,
      // enableVibration: false
    )
  ]);
}

void main() async {
  // WidgetsBinding widgetsBinding=

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDA2GIsA0-bLzcSkhPCCXevsbOIjpFR0LQ",
            appId: "app-1-704147931709-ios-ce5bd2b603b7ef9a6da054",
            messagingSenderId: "704147931709",
            projectId: "recovery-f86f0"));
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp;
  initLocalNotification();
  await EasyLocalization.ensureInitialized();
  await readData();
  
await PaymentIntegration().configureSDK();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/i18n",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit()),
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<AppCubit>(create: (BuildContext context) => AppCubit()),
        BlocProvider<CategoryCubit>(
            create: (BuildContext context) => CategoryCubit()),
        BlocProvider<MarketCubit>(
            create: (BuildContext context) => MarketCubit()),
        BlocProvider<CardsCubit>(
            create: (BuildContext context) => CardsCubit()),
        BlocProvider<SubscribeCubit>(
            create: (BuildContext context) => SubscribeCubit()),
        BlocProvider<NotificationCubit>(
            create: (BuildContext context) => NotificationCubit()),
      ],
      child: MaterialApp(
          title: "Recovery Zone",
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          initialRoute: splash,
          routes: {
            splash: (context) => const SplashScreen(),
            test: (context) => PaymentTest(),
            lang: (context) => const SelectLangeScreen(),
            // createProvider: (context) => const CreateAccountProviderScreen(),
            // homeProvider: (context) => HomeProviderScreen(),
            home: (context) => const HomeScreen(),
            // navUser: (context) => const NavigationUserScreen(),
            // // detailsProvider: (context) => const DetailsProviderScreen(),
            // cart: (context) => const CartsScreen(),
            // fav: (context) => FavoriteScreen(),
            // notyUser: (context) => NotificationsScreen(),
            // abouteUs: (context) => AboutUsScreen(),
            // praivcy: (context) => PrivacyScreen(),
            // navProvider: (context) => NavigationProviderScreen(),
            // statistics: (context) => StatisticsScreen(),
            // quizscreen: (context) => QuizScreen(),
          }),
    );
  }
}
