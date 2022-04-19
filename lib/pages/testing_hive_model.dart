import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shutter_stock/helpers/hive_helper.dart';
import 'package:shutter_stock/hive/hive_model.dart';
import 'package:shutter_stock/services/shutter_stock_services.dart';

class TestingHive extends StatefulWidget {
  const TestingHive({ Key? key }) : super(key: key);

  @override
  State<TestingHive> createState() => _TestingHiveState();
}

class _TestingHiveState extends State<TestingHive> {

@override
  void initState() {
    ShutterStockServices myServices = ShutterStockServices();
    // myServices.fetchApi(isLoading: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<HiveModel>>(
      valueListenable: Boxes.getHiveModelBox().listenable(),
      builder: (context, box, _){
        final hiveModelBox = box.values.toList().cast<HiveModel>();
        print(hiveModelBox);
        return ListView.builder(
          itemCount: hiveModelBox.length,
          itemBuilder: (context, index) => 
        ListTile(
          title: Text(hiveModelBox[index].url),
        )
        );
      },
      child: Container(
        child: Text("hello"),
      ),
    );
  }
}