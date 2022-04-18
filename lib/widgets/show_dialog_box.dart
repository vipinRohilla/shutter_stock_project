import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/variables.dart';
import '../notifiers/notifiers.dart';
import '../services/shutter_stock_services.dart';

Future selectedImages(ShutterStockServices myServices, String e) async {
  await myServices.fetchApi(isSelected: true,selectedImage: e);
}

class ShowDialogBox extends StatelessWidget {
  const ShowDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageNotifier image = Provider.of<ImageNotifier>(context);
    ShutterStockServices myServices =
        Provider.of<ShutterStockServices>(context);
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shrinkWrap: true,
                children: [
                  preview,
                  smallthumb,
                  largethumb,
                  hugethumb,
                  preview1000,
                  preview1500
                ]
                    .map((e) => InkWell(
                          onTap: () async {
                            
                            // print("1");
                            image.setImageQualityTo = e;
                            // print("2");
                            Navigator.of(context).pop();
                            // print("3");
                            myServices.data.clear();
                            // print("4");
                            await selectedImages(myServices, image.imageQuality);
                            // print("5");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            child: Text(e.toUpperCase()),
                          ),
                        ))
                    .toList(),
              ),
            ),
          );
        },
        icon: Container(
          child: Column(
            children: [
              const Icon(Icons.arrow_drop_down_circle_sharp),
              Text(image.imageQuality)
            ],
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
        ));
  }
}
