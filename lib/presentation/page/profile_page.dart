import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:mobile_traffic/config/app_color.dart";
import "package:mobile_traffic/presentation/page/home_page.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Profile',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ],
          ),
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
              onPressed: () {
                Get.to(() => const ProfilePage());
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: const Text('home'),
                onTap: () {
                  Get.to(() => const HomePage());
                },
              ),
              ListTile(
                title: const Text('Level'),
                onTap: () {
                  Navigator.pushNamed(context, '/level');
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 194, 194, 194),
                ),
                width: 400,
                height: 260,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name : Ismail',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email: tV7bP@example.com',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'phone: 0862552',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'score: 600',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
