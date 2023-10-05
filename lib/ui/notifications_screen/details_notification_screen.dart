import 'package:discovery_zone/bloc/notification_cubit/notification_cubit.dart';

import 'package:discovery_zone/core/utils/app_model.dart';
import 'package:discovery_zone/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout/app_fonts.dart';

import '../../../../core/widgets/texts.dart';

class DetailsNotificationScreen extends StatefulWidget {
  final NotificationModel notificationModel;
  const DetailsNotificationScreen({super.key, required this.notificationModel});

  @override
  State<DetailsNotificationScreen> createState() =>
      _DetailsNotificationScreenState();
}

class _DetailsNotificationScreenState extends State<DetailsNotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xffFEFEFE),
            elevation: 0,
            automaticallyImplyLeading: true,
            title: Texts(
                title: AppModel.lang==AppModel.arLang? widget.notificationModel.titleAr!: widget.notificationModel.titleEng!,
                family: AppFonts.taB,
                size: 18,
                widget: FontWeight.bold),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppModel.lang==AppModel.arLang? widget.notificationModel.descriptionAr!: widget.notificationModel.descriptionEng!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: AppFonts.caB,
                            fontSize: 18,
                            
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ],
              ),
            ),
          ),
        );
      },
    );
  }
}
