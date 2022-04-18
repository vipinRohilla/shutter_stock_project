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
import 'package:shutter_stock/helpers/image_selector_helper.dart';
import 'package:shutter_stock/models/shutter_stock_model.dart';

import '../constants/variables.dart';

class ShutterStockServices with ChangeNotifier {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  List<Data> _items = [];
  Map<dynamic, dynamic> _data = {};

  Map<dynamic, dynamic> get data => _data;

  set setDataToCurrentData(Map<dynamic, dynamic> newData) {
    _data = newData;
  }

  int _currentPage = 3;
  dynamic _currentResponse;
  final int _totalPage = 20;
  final bool _load = false;

  List<Data> get items => _items;

  int get currentPage => _currentPage;

  int get totalPage => _totalPage;

  dynamic get currentResponse => _currentResponse;

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    FromHiveDataBase.box = await Hive.openBox('data');
    return;
  }

  Future<bool> fetchApi(
      {bool isLoading = false,
      bool isRefresh = false,
      bool isSelected = false,
      selectedImage = "preview"}) async {
    // _currentPage = 3;
    // print("6");
    await openBox();
    if (isSelected) {
      _currentPage = 3;
    }
    if (isRefresh) {
      // print("7");
      _currentPage = 3;
    } else {
      // print("8");
      if (_currentPage >= _totalPage) {
        // print("9");
        refreshController.loadNoData();
        return _load;
      }
    }

    try {
      // print("10");
      final response = await http.get(
        Uri.parse(Api.baseUrl +
            Api.shutterStockImages +
            "?per_page=" +
            "$_currentPage"),
        // Send authorization headers to the backend.
        headers: {HttpHeaders.authorizationHeader: Api.tokenKey},
      );
      // print("11");
      // print(response.statusCode);
      if (response.statusCode == 429) {
        // 429 == too many requests
        // print("too many request");

      }
      if (response.statusCode == 200) {
        // print("12");
        var responseJs = await json.decode(response.body);
        final responseJson = ShutterStockModel.fromJson(responseJs);
        _currentResponse = responseJson;
        // print("13");
        await putData(responseJson.data!, selectedImage);
        // print("14");
        if (isRefresh) {
          // print("15");
          _items = responseJson.data!;
        } else {
          // print("16");
          items.clear();
          items.addAll(responseJson.data!);
          await putData(responseJson.data!, selectedImage);
          // print("17");
        }
        if (isLoading) {
          _currentPage += 4;
        }
      } else {
        return false;
      }
    } catch (socketException) {
      Center(
        child: Text(socketException.toString()),
      );
    }
    var _toHiveData = FromHiveDataBase.box!.toMap();
    if (_toHiveData.isEmpty) {
      data["empty"] = "empty";
    } else {
      // print("18");
      _data = _toHiveData;
      // print("19");
    }
    notifyListeners();
    return true;
  }

  Future putData(List<Data> data, String selectedImage) async {
    await FromHiveDataBase.box!.clear();

    switch (selectedImage) {
      case preview:
        FromHiveDataBase.showPreviewImages(data);

        break;
      case smallthumb:
        FromHiveDataBase.showSmallThumbImages(data);

        break;
      case largethumb:
        FromHiveDataBase.showLargeThumbImages(data);

        break;
      case hugethumb:
        FromHiveDataBase.showHugeThumbImages(data);

        break;
      case preview1000:
        FromHiveDataBase.showPreview1000Images(data);

        break;
      case preview1500:
        FromHiveDataBase.showPreview1500Images(data);

        break;
      default:
        FromHiveDataBase.showPreviewImages(data);
    }
  }
}
