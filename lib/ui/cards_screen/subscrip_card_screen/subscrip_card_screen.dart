import 'package:discovery_zone/bloc/auth_cubit/auth_cubit.dart';

import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/layout/app_fonts.dart';
import 'package:discovery_zone/core/layout/palette.dart';

import 'package:discovery_zone/core/widgets/custom_button.dart';
import 'package:discovery_zone/core/widgets/text_field_widget.dart';
import 'package:discovery_zone/core/widgets/texts.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class SubscribeCardScreen extends StatefulWidget {
  final int id;
  final String titleBar;
  const SubscribeCardScreen({super.key, required this.id,required this.titleBar});

  @override
  State<SubscribeCardScreen> createState() => _SubscribeCardScreenState();
}

class _SubscribeCardScreenState extends State<SubscribeCardScreen> {
  final _controllerFirstName = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerAddress = TextEditingController();
   final _controllerEmail = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    _controllerPhone.dispose();
    _controllerAddress.dispose();
      _controllerEmail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: const BackButton(
          color: Palette.mainColor,
        ),
        title: Texts(
          title: "تسجيل دخول".tr(),
          family: AppFonts.caB,
          size: 20,
          textColor: Palette.mainColor,
          height: 2.0,
        ),
        // actions: const [IconAlertWidget()],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
            child: SingleChildScrollView(
              child: Column(children: [
                Texts(
                    title: "الرجاء ادخال البيانات الخاصة بك".tr(),
                    family: AppFonts.taM,
                    size: 14,
                    textColor: const Color(0xff44494E),
                    widget: FontWeight.normal),
                const SizedBox(
                  height: 20,
                ),

                TextFieldWidget(
                  controller: _controllerFirstName,
                  hint: "الاسم الأول".tr(),
                  icon: const SizedBox(),
                  type: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                  controller: _controllerLastName,
                  hint: 'الاسم الأخير'.tr(),
                  icon: const SizedBox(),
                  type: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                  controller: _controllerPhone,
                  hint: 'رقم الهاتف'.tr(),
                  isPhone: true,
                  icon: const SizedBox(),
                  type: TextInputType.number,
                ),
                 const SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                  controller: _controllerEmail,
                  hint: "البريد الالكترونى".tr(),
                  isPhone: true,
                  icon: const SizedBox(),
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                // **
                Container(
                  padding: const EdgeInsets.only(
                      right: 25, left: 18, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xfffefefe),
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(width: 1.0, color: const Color(0xfff6f6f7)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0f000000),
                        offset: Offset(1, 1),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controllerAddress,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                        fontFamily: AppFonts.taM,
                        fontSize: 14,
                        color: Colors.black),
                    maxLines: 8,
                    decoration: InputDecoration(
                      icon: const SizedBox(),
                      hintText: "العنوان".tr(),
                      border: InputBorder.none,
                      hintStyle: const TextStyle(
                          fontFamily: AppFonts.taM,
                          fontSize: 14,
                          color: Color(0xff1D1D1D)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
             CustomButton(
                  radius: 25,
                  elevation: 10,
                  backgroundColor: Palette.secondaryColor,
                  titleColor: Palette.mainColor,
                  title: "تسجيل".tr(),
                  onPressed: () {
                    // SubscribeModel subscribeModel = SubscribeModel(
                    //     id: 0,
                    //     firstName: _controllerFirstName.text,
                    //     lastName: _controllerLastName.text,
                    //     cardId: widget.id,
                    //     phone: _controllerPhone.text,
                    //     address: _controllerAddress.text,
                    //     status: 0,
                    //     createdAt: "createdAt", expiredDate: 'sdf',userId: AppModel.userId);
                    if (isValidate(context)) {
                      AuthCubit.get(context).registerUser(context: context,fullName: _controllerFirstName.text+ "," + _controllerLastName.text,
                      userName: _controllerPhone.text,city: _controllerAddress.text,email: _controllerEmail.text,titleBar:widget.titleBar
                      );
                    }
                  },
                ),
              ]),
            ),
          );
        },
      ),
    );
  }

  bool isValidate(BuildContext context) {
    if (_controllerFirstName.text.isEmpty || _controllerFirstName.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم الاول".tr(),
            textStyle: const TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerLastName.text.isEmpty ||
        _controllerLastName.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب الاسم الأخير".tr(),
            textStyle: const TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    }
else if (_controllerEmail.text.isEmpty ||
        _controllerEmail.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب  البريد الالكترونى".tr(),
            textStyle: const TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    }

     else if (_controllerPhone.text.isEmpty || _controllerPhone.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب رقم الهاتف".tr(),
            textStyle: const TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerAddress.text.isEmpty ||
        _controllerAddress.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب العنوان الخاص بك".tr(),
            textStyle: const TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }
}
