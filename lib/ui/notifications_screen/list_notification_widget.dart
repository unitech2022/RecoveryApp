import 'package:discovery_zone/core/animations/slide_transtion.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/utils/app_model.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:discovery_zone/models/notification_model.dart';
import 'package:discovery_zone/ui/notifications_screen/details_notification_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListNotificationWidget extends StatelessWidget {
  final List<NotificationModel> alerts;
  const ListNotificationWidget({
    super.key,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 40),
        itemCount: alerts.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          NotificationModel alertResponse = alerts[index];
          return GestureDetector(
            onTap: () {
              print("object");
              pushTranslationPage(
                  context: context,
                  transtion: FadTransition(
                      page: DetailsNotificationScreen(
                    notificationModel: alertResponse,
                  )));
            },
            child: Container(
              height: 65,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29b6b6b6),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Palette.mainColor),
                    child: Center(
                      child: SvgPicture.asset("assets/icons/alrm.svg"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Texts(
                        title: AppModel.lang == AppModel.arLang
                            ? alertResponse.titleAr!
                            : alertResponse.titleEng!,
                        family: AppFonts.caR,
                        size: 12,
                        // textColor: const Color(0xffC3C3C3),
                      ),
                      Texts(
                        title: AppModel.lang == AppModel.arLang
                            ? alertResponse.descriptionAr!
                            : alertResponse.descriptionEng!,
                        family: AppFonts.caR,
                        size: 12,
                        textColor: const Color(0xffC3C3C3),
                      )
                    ],
                  ),
                  const Spacer(),
                  Texts(
                    title: alertResponse.createdAt!.split("T")[0],
                    family: AppFonts.caR,
                    size: 10,
                    textColor: const Color(0xffC3C3C3),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
