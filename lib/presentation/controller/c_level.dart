import 'package:get/get.dart';
import 'package:mobile_traffic/data/model/level.dart';
import 'package:mobile_traffic/data/source/source_level.dart';

class CLevel extends GetxController {
  final _listLevel = <Level>[].obs;
  List<Level> get listLevel => _listLevel.value;

  getListLevel() async {
    _listLevel.value = await SourceLevel.getLevel();
    update();
  }

  @override
  void onInit() {
    getListLevel();
    super.onInit();
  }
}
