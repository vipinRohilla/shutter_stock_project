import 'package:shutter_stock/helpers/hive_helper.dart';

import '../hive/hive_model.dart';
import '../models/shutter_stock_model.dart';
import 'package:hive/hive.dart';


class FromHiveDataBaseModel{
  // static Box? box;
  static var box = Boxes.getHiveModelBox();

   static showPreviewImagesOfHive(List<Data> data) {
    for (var d in data) {
     final model = HiveModel();
      final inside = d.assets!;
      // Map<String, dynamic> value = {
        model.url = inside.preview!.url!;
        model.height = inside.preview!.height!;
        model.width = inside.preview!.width!;
        model.description = d.description!;
      // };
      
      box.add(model);
      // box !.add(value);
    }
  }

  static showSmallThumbImagesOfHive(List<Data> data) {
    for (var d in data) {
       final model = HiveModel();
      final inside = d.assets!;
      // Map<String, dynamic> value = {
        model.url = inside.smallThumb!.url!;
        model.height = inside.smallThumb!.height!;
        model.width = inside.smallThumb!.width!;
        model.description = d.description!;
      // };
      
      box.add(model);
      // box !.add(value);
    }
  }

  static showLargeThumbImagesOfHive(List<Data> data) {
    for (var d in data) {
       final model = HiveModel();
      final inside = d.assets!;
      // Map<String, dynamic> value = {
        model.url = inside.largeThumb!.url!;
        model.height = inside.largeThumb!.height!;
        model.width = inside.largeThumb!.width!;
        model.description = d.description!;
      // };
      
      box.add(model);
      // box !.add(value);
    }
  }

  static showHugeThumbImagesOfHive(List<Data> data) {
    for (var d in data) {
       final model = HiveModel();
      final inside = d.assets!;
      // Map<String, dynamic> value = {
        model.url = inside.hugeThumb!.url!;
        model.height = inside.hugeThumb!.height!;
        model.width = inside.hugeThumb!.width!;
        model.description = d.description!;
      // };
      
      box.add(model);
      // box !.add(value);
    }
  }

   static showPreview1000ImagesOfHive(List<Data> data) {
    for (var d in data) {
       final model = HiveModel();
      final inside = d.assets!;
      // Map<String, dynamic> value = {
        model.url = inside.preview1000!.url!;
        model.height = inside.preview1000!.height!;
        model.width = inside.preview1000!.width!;
        model.description = d.description!;
      // };
      
      box.add(model);
      // box !.add(value);
    }
  }

  static showPreview1500ImagesOfHive(List<Data> data) {
    for (var d in data) {
       final model = HiveModel();
      final inside = d.assets!;
      // Map<String, dynamic> value = {
        model.url = inside.preview1500!.url!;
        model.height = inside.preview1500!.height!;
        model.width = inside.preview1500!.width!;
        model.description = d.description!;
      // };
      
      box.add(model);
      // box !.add(value);
    }
  }
}