import 'package:flutter/material.dart';

class ImageNotifier with ChangeNotifier {
  String _imageQuality = "preview"; //by default

  String get imageQuality => _imageQuality;

  set setImageQualityTo(String imageQuality) {
    _imageQuality = imageQuality;
    notifyListeners();
  }
}

class ResponseNotifier with ChangeNotifier {
  dynamic _response;

  dynamic get response => _response;

  set setResponseTo(dynamic response) {
    _response = response;
    notifyListeners();
  }
}
