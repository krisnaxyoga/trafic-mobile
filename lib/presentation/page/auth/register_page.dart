import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_traffic/config/app_asset.dart';
import 'package:mobile_traffic/config/app_color.dart';
import 'package:mobile_traffic/data/source/source_user.dart';
import 'package:mobile_traffic/presentation/page/auth/login_page.dart';

import '../home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  register() async {
    if (formKey.currentState!.validate()) {
      final result = await SourceUser.register(
        controllerName.text,
        controllerEmail.text,
        controllerPassword.text,
      );
      print('$result >>>INI RESULT');
      if (result) {
        DInfo.notifSuccess('success', 'success login');
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
      backgroundColor: AppColor.bg,
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
                          DView.spaceHeight(40),
                          TextFormField(
                            controller: controllerName,
                            validator: (value) =>
                                value == '' ? 'Jangan kosong' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              hintText: 'name',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                            ),
                          ),
                          // DView.spaceHeight(),
                          // TextFormField(
                          //   // controller: controllerName,
                          //   // validator: (value) =>
                          //   //     value == '' ? 'Jangan kosong' : null,
                          //   // autovalidateMode:
                          //   //     AutovalidateMode.onUserInteraction,
                          //   style: const TextStyle(
                          //       color: Color.fromARGB(255, 0, 0, 0)),
                          //   decoration: InputDecoration(
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide:
                          //           const BorderSide(color: Colors.black),
                          //     ),
                          //     hintText: 'phone',
                          //     isDense: true,
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 20,
                          //       vertical: 20,
                          //     ),
                          //   ),
                          // ),
                          DView.spaceHeight(),
                          TextFormField(
                            controller: controllerEmail,
                            validator: (value) =>
                                value == '' ? 'Jangan kosong' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              hintText: 'email',
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
                                value == '' ? 'Jangan kosong' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              hintText: 'password',
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
                              onTap: () => register(),
                              borderRadius: BorderRadius.circular(30),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16),
                                child: Text(
                                  'REGISTER',
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
                          'Sudah punya akun? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Text(
                            'Login',
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
