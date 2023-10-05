import 'package:discovery_zone/bloc/app_cubit/app_cubit.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/app_sizes.dart';
import 'package:discovery_zone/core/router/routes.dart';
import 'package:discovery_zone/core/widgets/custom_button.dart';
import 'package:discovery_zone/core/widgets/texts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/helper_functions.dart';
import '../../core/layout/palette.dart';

class SelectLangeScreen extends StatelessWidget {
  const SelectLangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Texts(title: "اختار لغة التطبيق".tr(),
                  family: AppFonts.taB,
                  size: AppSize.s20,
                  textColor: Palette.mainColor,),
                const SizedBox(height: 30,),
                sizedHeight(25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButton(
                    elevation: 10,
                    titleColor: Palette.secondaryColor,
                    backgroundColor: Palette.mainColor,
                    onPressed: () {
                      context.setLocale(const Locale('ar'));

                      AppCubit.get(context).changeLang("ar", context);
                      pushPageRoutNameReplaced(context, home);
                    },
                    title: 'اللغة العربية',
                  ),
                ),
                sizedHeight(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButton(
                    elevation: 10,
                    titleColor: Palette.secondaryColor,
                    backgroundColor: Palette.mainColor,
                    onPressed: () {
                      context.setLocale(const Locale('en'));

                      AppCubit.get(context).changeLang("en", context);
                      pushPageRoutNameReplaced(context, home);
                    },
                    title: "English",
                  ),
                ),
                sizedHeight(50),
              ],
            ),
          );
        },
      ),
    );
  }
}
