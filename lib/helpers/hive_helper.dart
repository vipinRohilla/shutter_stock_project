
import 'package:hive/hive.dart';
import 'package:shutter_stock/hive/hive_model.dart';

class Boxes{
  static Box<HiveModel> getHiveModelBox() => Hive.box<HiveModel>("hivemodelbox");
}