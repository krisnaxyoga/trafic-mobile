import 'package:get/get.dart';
import 'package:mobile_traffic/data/model/user.dart';
import 'package:mobile_traffic/data/source/source_user.dart';

class CUser extends GetxController {
  final _data = User().obs;
  User get data => _data.value;
  setData(n) => _data.value = n;

  final _listUser = <User>[].obs;
  List<User> get listUser => _listUser.value;

  getListUser() async {
    _listUser.value = await SourceUser.getUser();
    update();
  }

  @override
  void onInit() {
    getListUser();
    super.onInit();
  }
}
