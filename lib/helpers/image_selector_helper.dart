import '../models/shutter_stock_model.dart';
import 'package:hive/hive.dart';


class FromHiveDataBase{
  static Box? box;

   static showPreviewImages(List<Data> data) {
    for (var d in data) {
      final inside = d.assets!;
      Map<String, dynamic> value = {
        "url": inside.preview!.url,
        "height": inside.preview!.height,
        "width": inside.preview!.width,
        "description": d.description
      };

      box !.add(value);
    }
  }

  static showSmallThumbImages(List<Data> data) {
    for (var d in data) {
      final inside = d.assets!;
      Map<String, dynamic> value = {
        "url": inside.smallThumb!.url,
        "height": inside.smallThumb!.height,
        "width": inside.smallThumb!.width,
        "description": d.description
      };
      box!.add(value);
    }
  }

  static showLargeThumbImages(List<Data> data) {
    for (var d in data) {
      final inside = d.assets!;
      Map<String, dynamic> value = {
        "url": inside.largeThumb!.url,
        "height": inside.largeThumb!.height,
        "width": inside.largeThumb!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }

  static showHugeThumbImages(List<Data> data) {
    for (var d in data) {
      final inside = d.assets!;
      Map<String, dynamic> value = {
        "url": inside.hugeThumb!.url,
        "height": inside.hugeThumb!.height,
        "width": inside.hugeThumb!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }

   static showPreview1000Images(List<Data> data) {
    for (var d in data) {
      final inside = d.assets!;
      Map<String, dynamic> value = {
        "url": inside.preview1000!.url,
        "height": inside.preview1000!.height,
        "width": inside.preview1000!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }

  static showPreview1500Images(List<Data> data) {
    for (var d in data) {
      final inside = d.assets!;
      Map<String, dynamic> value = {
        "url": inside.preview1500!.url,
        "height": inside.preview1500!.height,
        "width": inside.preview1500!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }
}