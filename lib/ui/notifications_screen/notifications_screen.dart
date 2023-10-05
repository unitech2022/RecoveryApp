import 'package:discovery_zone/bloc/notification_cubit/notification_cubit.dart';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/widgets/empty_list_widget.dart';
import 'package:discovery_zone/ui/components/no_internet_widget.dart';
import 'package:discovery_zone/ui/notifications_screen/list_notification_widget.dart';
import 'package:discovery_zone/ui/notifications_screen/notifications_shimmer_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/widgets/texts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    NotificationCubit.get(context).getAlerts(context: context, page: 1);

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        print(NotificationCubit.get(context).totalPages);
        if (NotificationCubit.get(context).currentPage <
            NotificationCubit.get(context).totalPages) {
          NotificationCubit.get(context).currentPage++;

          NotificationCubit.get(context).getAlerts(
              context: context,
              page: NotificationCubit.get(context).currentPage);
        }
      }
    });
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
                  title: "الاشعارات".tr(),
                  family: AppFonts.taB,
                  size: 18,
                  widget: FontWeight.bold),
              // actions: [
              //  IconAlertWidget()
              // ],
            ),
            body: getBody(state));
      },
    );
  }

  Widget getBody(NotificationState state) {
    switch (state.getAlertsState) {
      case RequestState.loaded:
        return NotificationCubit.get(context).alerts.isEmpty
            ? EmptyListWidget(message: "لا توجد اشعارات ".tr())
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    ListNotificationWidget(
                        alerts: NotificationCubit.get(context).alerts),
                    const SizedBox(
                      height: 20,
                    ),
                    state.getAlertsState == RequestState.pagination
                        ? const SizedBox(
                            height: 35,
                            width: 35,
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ));
      case RequestState.loading:
      case RequestState.error:
        return const NotificationsShimmerWidget();

      case RequestState.noInternet:
        return NoInternetWidget(
          onPress: () {
            NotificationCubit.get(context).getAlerts(context: context, page: 1);
          },
        );

      default:
        return const NotificationsShimmerWidget();
    }
  }
}
