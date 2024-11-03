import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_traffic/config/app_color.dart';
import 'package:mobile_traffic/config/session.dart';

import 'data/model/user.dart';
import 'presentation/page/auth/login_page.dart';
import 'presentation/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          primaryColor: AppColor.primary,
          colorScheme: ColorScheme.light(
            primary: AppColor.primary,
            secondary: AppColor.secondary,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          )),
      home: FutureBuilder(
          future: Session.getUser(),
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.data != null && snapshot.data!.idUser != null) {
              return HomePage();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
