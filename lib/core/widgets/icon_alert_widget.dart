

// class IconAlertWidget extends StatelessWidget {
//   final double t, l;
//   IconAlertWidget({this.t = 10, this.l = 20});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         return MaterialButton(
//           onPressed: () {
//             // pushPage(context, const NotificationsScreen());
//             // pushTranslationPage(
//             //     context: context,
//             //     transtion: FadTransition(page: NotificationsScreen()));
//           },
//           minWidth: 40,
//           height: 40,
//           child: Padding(
//             padding: EdgeInsets.only(top: t, left: l),
//             child: badges.Badge(
//               badgeContent: Text(
//                 currentUser.role == AppModel.userRole
//                     ? state.homeUserResponse != null
//                         ? state.homeUserResponse!.notiyCount.toString()
//                         : "0"
//                     : state.homeResponseProvider != null
//                         ? state.homeResponseProvider!.notiyCount.toString()
//                         : "0",
//                 style: const TextStyle(color: Colors.white, height: 1.8),
//               ),
//               position: badges.BadgePosition.topStart(top: -12),
//               badgeStyle:
//                   const badges.BadgeStyle(badgeColor: Palette.mainColor),
//               child: SvgPicture.asset("assets/icons/noty.svg"),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
