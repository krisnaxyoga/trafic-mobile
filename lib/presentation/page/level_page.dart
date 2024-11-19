import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_traffic/data/model/level.dart';
import 'package:mobile_traffic/presentation/controller/c_level.dart';
import 'package:mobile_traffic/presentation/page/quiz_page.dart';
import '../../config/app_color.dart';
import '../controller/c_user.dart';
import 'home_page.dart';
import 'profile_page.dart';

class LevelPage extends StatelessWidget {
  LevelPage({super.key});
  final CLevel cLevel = Get.put(CLevel());
  final CUser cUser = Get.put(CUser());
  @override
  Widget build(BuildContext context) {
    Get.put(CUser()).onInit();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Level',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.black,
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              color: Colors.black,
              onPressed: () => Get.to(() => const ProfilePage()),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              color: Colors.black,
              onPressed: () => cLevel.getListLevel(),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: const Text('Home'),
                onTap: () => Get.to(() => const HomePage()),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () => Get.to(() => const ProfilePage()),
              ),
              ListTile(
                title: const Text('Level'),
                onTap: () => Get.to(() => LevelPage()),
              ),
            ],
          ),
        ),
        body: Obx(() {
          final user = cUser.data;
          if (user.idUser == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GetBuilder<CLevel>(builder: (controller) {
              // Memastikan data level selalu terbaru
              if (controller.listLevel.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 50),
                itemCount: controller.listLevel.length,
                itemBuilder: (context, index) {
                  final Level level = controller.listLevel[index];
                  // Logika terkunci jika level sebelumnya belum tercapai
                  final bool isLocked = index > 0 &&
                      !user.userScores!
                          .any((e) => e.idLevel == level.id!.toString());
                  print('$isLocked apa ini');
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: isLocked
                          ? null
                          : () => Get.to(() => QuizPage(), arguments: level.id),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: isLocked
                              ? const Color(0xFF79747E)
                              : AppColor.primary,
                        ),
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Level id ${level.id}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      level.levelDesc ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          'Target Score: ${level.targetScore}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isLocked ? Icons.lock : Icons.play_arrow,
                                color: Colors.white,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          );
        }),
      ),
    );
  }
}
