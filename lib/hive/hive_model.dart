
import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel extends HiveObject{
  @HiveField(0)
  late String url;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late int height;
  @HiveField(3)
  late int width;

  HiveModel({required this.url, required this.description, required this.height, required this.width});

}