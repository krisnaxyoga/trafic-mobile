import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_traffic/data/model/level.dart';
import 'package:mobile_traffic/presentation/controller/c_level.dart';
import 'package:mobile_traffic/presentation/page/addworkshoppage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final CLevel cLevel = Get.put(CLevel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigasi ke halaman AddWorkshopPage ketika tombol tambah ditekan
              Get.to(() => AddWorkshopPage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            GetBuilder<CLevel>(
              builder: (_) => _buildWorkshopList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkshopList() {
    return cLevel.listLevel.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: cLevel.listLevel.length,
            itemBuilder: (context, index) {
              Level level = cLevel.listLevel[index];
              return ListTile(
                title: Text(
                    'Level: ${int.parse(level.levelNumber.toString() ?? '0')}'),
                subtitle: Text(level.levelDesc ?? ''),
                onTap: () {
                  // Handle tap on workshop item if needed
                },
              );
            },
          );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:mobile_traffic/config/session.dart';
// import 'package:mobile_traffic/data/model/workshop.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   Future<List<Workshop>> fetchWorkshops() async {
//     String url = 'http://172.17.2.76:8005/api/workshop';
//     String? token = await Session.getToken();

//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       print(token);
//       if (response.statusCode == 200) {
//         List<dynamic> data = json.decode(response.body)['data'];
//         return data.map((json) => Workshop.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load workshops');
//       }
//     } catch (e) {
//       print('Error fetching workshops: $e');
//       throw Exception('Failed to load workshops');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Workshops')),
//       body: FutureBuilder<List<Workshop>>(
//         future: fetchWorkshops(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             List<Workshop> workshops = snapshot.data!;
//             return ListView.builder(
//               itemCount: workshops.length,
//               itemBuilder: (context, index) {
//                 Workshop workshop = workshops[index];
//                 return ListTile(
//                   title: Text(workshop.ownerName ?? ''),
//                   subtitle: Text(workshop.email ?? ''),
//                   onTap: () {
//                     // Handle tap on workshop item if needed
//                   },
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text('No workshops available'));
//           }
//         },
//       ),
//     );
//   }
// }
