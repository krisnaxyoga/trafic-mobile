import 'package:get/get.dart';
import 'package:mobile_traffic/data/model/user.dart';
import 'package:mobile_traffic/data/source/source_user.dart';

class CUser extends GetxController {
  final _data = User().obs; // Objek User untuk menyimpan data user login
  User get data => _data.value;

  setData(User user) {
    _data.value = user;
  }

  Future<void> getUserData() async {
    final user =
        await SourceUser.getUser(); // Mengambil data user dari SourceUser
    if (user != null) {
      setData(user); // Menyimpan data user ke state
    }
    update(); // Update UI
  }

  @override
  void onInit() {
    getUserData(); // Panggil fungsi saat controller diinisialisasi
    super.onInit();
  }
}
