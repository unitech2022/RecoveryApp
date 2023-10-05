import 'package:discovery_zone/bloc/home_cubit/home_cubit.dart';
import 'package:discovery_zone/core/enums/loading_status.dart';
import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/palette.dart';
import 'package:discovery_zone/core/shimmer/shimmer_widget.dart';

import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:discovery_zone/ui/components/container_shimmer.dart';
import 'package:discovery_zone/ui/components/no_internet_widget.dart';
import 'package:discovery_zone/ui/home_screen/components/carousel_widget.dart';
import 'package:discovery_zone/ui/home_screen/components/drawer_widget.dart';
import 'package:discovery_zone/ui/home_screen/components/list_field_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
   
    super.initState();
    inItFCMNotification();
    HomeCubit.get(context).getHomeUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      switch (state.getHomeState) {
        case RequestState.noInternet:
          return NoInternetWidget(
            onPress: () {
              HomeCubit.get(context).getHomeUser(context: context);
            },
          );
        case RequestState.loaded:
          return Scaffold(
              key: scaffoldkey,
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () {
                      scaffoldkey.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Palette.mainColor,
                      size: 30,
                    )),
                title: Texts(
                  title: "الرئيسية".tr(),
                  family: AppFonts.caB,
                  size: 18,
                  textColor: Palette.mainColor,
                  height: 2.0,
                ),
                // actions: const [IconAlertWidget()],
              ),
              drawer: const DrawerWidget(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    sizedHeight(20),
                    // *** slider
                    CarouselWidget(
                      offers: state.homeResponse!.offers,
                    ),

                    // const SizedBox(
                    //   height: 30,
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   child: Row(
                    //     children: [
                    //       Texts(
                    //         title: "الأقسام".tr(),
                    //         family: AppFonts.taB,
                    //         size: 16,
                    //         textColor: Colors.black,
                    //         height: 2.0,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 35,
                    ),

                    // ** fields
                    ListFieldWidget(
                      fields: state.homeResponse!.fields,
                      code: state.homeResponse!.codeMarkets,
                    )
                  ],
                ),
              ));
        case RequestState.error:
        case RequestState.loading:
          return Scaffold(
            body: getShimmerWidget(
              child: ListView(
                children: [
                  sizedHeight(5),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 15,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  sizedHeight(20),
                  // *** slider
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.grey
                        // borderRadius: BorderRadius.circular(15)
                        ),
                  ),
                  sizedHeight(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey)),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey))
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  Container(
                    height: 140,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),

                  const ContainerShimmer(
                    hieght: 140,
                  ),
                  const ContainerShimmer(
                    hieght: 140,
                  ),
                  const ContainerShimmer(
                    hieght: 140,
                  ),
                ],
              ),
            ),
          );
        default:
          return Scaffold(
            body: getShimmerWidget(
              child: ListView(
                children: [
                  sizedHeight(5),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 15,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  sizedHeight(20),
                  // *** slider
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.grey
                        // borderRadius: BorderRadius.circular(15)
                        ),
                  ),
                  sizedHeight(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey)),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey))
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  Container(
                    height: 140,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),

                  const ContainerShimmer(
                    hieght: 140,
                  ),
                  const ContainerShimmer(
                    hieght: 140,
                  ),
                  const ContainerShimmer(
                    hieght: 140,
                  ),
                ],
              ),
            ),
          );
      }
    });
  }
}
