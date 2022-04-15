import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shutter_stock/constants/api.dart';
import 'package:shutter_stock/models/shutter_stock_model.dart';

import '../constants/variables.dart';
// import 'package:shutter_stock/model/shutter_stock_model.dart';

class ShutterStockServices with ChangeNotifier {
  // static dynamic _resp;
  //
  // dynamic get resp =>_resp;
  //
  //
  //  Future<ShutterStockModel> fetchApi() async {
  //   final response = await http.get(
  //     Uri.parse(Api.baseUrl + Api.shutterStockImages),
  //     // Send authorization headers to the backend.
  //     headers: {HttpHeaders.authorizationHeader: Api.tokenKey},
  //   );
  //   var responseJson = await json.decode(response.body);
  //   if(response.statusCode == 200){
  //     _resp = ShutterStockModel.fromJson(responseJson);
  //   }
  //   else{
  //     _resp = ShutterStockModel.fromJson(responseJson);
  //   }
  //
  //   notifyListeners();
  //   return _resp;
  //   // final List<ShutterStockModel> list = <ShutterStockModel>[];
  //   // List<dynamic> mapData = responseJson["data"];
  //
  //   // mapData.forEach(( dynamic element) {
  //   //   list.add(ShutterStockModel.fromJson(element));
  //   // });
  //
  //   // return list;
  //   // ["data"][0]["assets"]["preview"]["url"].toString();
  // }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  List<Data> _items = [];
  Map<dynamic, dynamic> data = {};

  int _currentPage = 3;
  dynamic _currentResponse;
  final int _totalPage = 20;
  final bool _load = false;

  List<Data> get items => _items;

  int get currentPage => _currentPage;

  int get totalPage => _totalPage;

  dynamic get currentResponse => _currentResponse;

  Box? box;

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  Future<bool> fetchApi(
      {bool isRefresh = false, selectedImage = "preview"}) async {
    await openBox();
    if (isRefresh) {
      _currentPage = 3;
    } else {
      if (_currentPage >= _totalPage) {
        refreshController.loadNoData();
        return _load;
      }
    }

    try {
      final response = await http.get(
        Uri.parse(Api.baseUrl +
            Api.shutterStockImages +
            "?per_page=" +
            "$_currentPage"),
        // Send authorization headers to the backend.
        headers: {HttpHeaders.authorizationHeader: Api.tokenKey},
      );
      if (response.statusCode == 200) {
        var responseJs = await json.decode(response.body);
        final responseJson = ShutterStockModel.fromJson(responseJs);
        _currentResponse = responseJson;
        await putData(responseJson.data!, selectedImage);
        if (isRefresh) {
          _items = responseJson.data!;
        } else {
          items.clear();
          items.addAll(responseJson.data!);
          await putData(responseJson.data!, selectedImage);
        }
        _currentPage += 4;
        // notifyListeners();

        // return true;
      } else {
        return false;
      }
    } catch (socketException) {
      Center(
        child: Text(socketException.toString()),
      );
      // print("No internet");
    }
    // print("404040 : ");
    // print(box!.toMap());
    var myMap = box!.toMap();
    // print(myMap);
    if (myMap.isEmpty) {
      data["empty"] = "empty";
      // notifyListeners();
    } else {
      data = myMap;
      // notifyListeners();
    }
    // print(data);
    notifyListeners();
    return true;
  }

  showPreviewImages(List<Data> data) {
    for (var d in data) {
      Map<String, dynamic> value = {
        "url": d.assets!.preview!.url,
        "height": d.assets!.preview!.height,
        "width": d.assets!.preview!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }

  showSmallThumbImages(List<Data> data) {
    for (var d in data) {
      Map<String, dynamic> value = {
        "url": d.assets!.smallThumb!.url,
        "height": d.assets!.smallThumb!.height,
        "width": d.assets!.smallThumb!.width,
        "description": d.description
      };
      box!.add(value);
    }
  }

  showLargeThumbImages(List<Data> data) {
    for (var d in data) {
      Map<String, dynamic> value = {
        "url": d.assets!.largeThumb!.url,
        "height": d.assets!.largeThumb!.height,
        "width": d.assets!.largeThumb!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }

  showHugeThumbImages(List<Data> data) {
    for (var d in data) {
      Map<String, dynamic> value = {
        "url": d.assets!.hugeThumb!.url,
        "height": d.assets!.hugeThumb!.height,
        "width": d.assets!.hugeThumb!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }

  showPreview1000Images(List<Data> data) {
    for (var d in data) {
      // box!.add(d.assets!.preview1500!.url);
      Map<String, dynamic> value = {
        "url": d.assets!.preview1000!.url,
        "height": d.assets!.preview1000!.height,
        "width": d.assets!.preview1000!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }

  showPreview1500Images(List<Data> data) {
    for (var d in data) {
      Map<String, dynamic> value = {
        "url": d.assets!.preview1500!.url,
        "height": d.assets!.preview1500!.height,
        "width": d.assets!.preview1500!.width,
        "description": d.description
      };

      box!.add(value);
    }
  }

  Future putData(List<Data> data, String selectedImage) async {
    await box!.clear();

    switch (selectedImage) {
      case preview:
        showPreviewImages(data);

        break;
      case smallthumb:
        showSmallThumbImages(data);

        break;
      case largethumb:
        showLargeThumbImages(data);

        break;
      case hugethumb:
        showHugeThumbImages(data);

        break;
      case preview1000:
        showPreview1000Images(data);

        break;
      case preview1500:
        showPreview1500Images(data);

        break;
      default:
        showPreviewImages(data);
    }

    //   for (var d in data) {
    //     // box!.add(d.assets!.preview1500!.url);
    //     Map<String, dynamic> value = {

    //       "url" : d.assets!.preview!.url,
    //       "height" : d.assets!.preview!.height,
    //       "width" : d.assets!.preview!.width,
    //       "description" : d.description
    //     //   box!.put("height", data[i].assets!.preview!.height),
    //     //   box!.put("width", data[i].assets!.preview!.width),
    //     //   // box!.put("width",d.assets!.preview1000!.width);
    //     //   box!.put("description", data[i].description)
    //     // });

    //     // count++;
    //   };

    //     box!.add(
    //      value
    //   );
    //   // print("count : " + count.toString());
    // }
  }
}
