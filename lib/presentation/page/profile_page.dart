import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/c_user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CUser cUser = Get.put(CUser()); // Inisialisasi controller
    Get.put(CUser()).onInit();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black, // Set back button color to black
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.black,
              onPressed: () async {
                await cUser.getUserData(); // Refresh user data
              },
            ),
          ],
        ),
        body: Obx(() {
          // Obx untuk memantau perubahan data user
          final user = cUser.data;
          if (user.idUser == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 194, 194, 194),
                    ),
                    width: 400,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${user.name ?? "-"}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Email: ${user.email ?? "-"}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Role: ${user.role ?? "-"}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Score: ${user.total_score ?? "-"}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
