import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_traffic/config/app_asset.dart';
import 'package:mobile_traffic/config/app_color.dart';
import 'package:mobile_traffic/data/source/source_user.dart';
import 'package:mobile_traffic/presentation/page/auth/register_page.dart';
import 'package:mobile_traffic/presentation/page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  login() async {
    if (formKey.currentState!.validate()) {
      bool success =
          await SourceUser.login(controllerEmail.text, controllerPassword.text);
      print(success);
      if (success) {
        DInfo.notifSuccess('success', 'success registrasi');
        Get.off(() => HomePage());
      } else {
        DInfo.dialogError(context, 'gagal login');
        DInfo.closeDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Image.asset(AppAsset.logo),
                          const Center(
                            child: Text(
                              'Traffic Game Quiz',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DView.spaceHeight(20),
                          DView.spaceHeight(40),
                          TextFormField(
                            controller: controllerEmail,
                            validator: (value) =>
                                value == '' ? 'jangan kosong' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Email',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                          ),
                          DView.spaceHeight(),
                          TextFormField(
                            controller: controllerPassword,
                            validator: (value) =>
                                value == '' ? 'jangan kosong' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Password',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                          ),
                          DView.spaceHeight(30),
                          Material(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                Get.to(() => const HomePage());
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'if you dont have account,',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RegisterPage());
                          },
                          child: Text(
                            'Register here',
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
