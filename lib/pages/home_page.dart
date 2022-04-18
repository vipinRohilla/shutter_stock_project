import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shutter_stock/notifiers/notifiers.dart';
import 'package:shutter_stock/services/shutter_stock_services.dart';
import 'package:shutter_stock/widgets/show_dialog_box.dart';

import '../helpers/helper_function.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
   
    ShutterStockServices myServices =
        Provider.of<ShutterStockServices>(context);
        ImageNotifier image =
        Provider.of<ImageNotifier>(context);

    // print(myServices.data);

    return SafeArea(
        child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 243, 243),
            ),
            child: const ShowDialogBox(),
            width: double.infinity,
          ),
        ),
        Expanded(
          flex: 5,
          child: SmartRefresher(
            controller: myServices.refreshController,
            enablePullUp: true,
            onRefresh: () async {
              final result = await myServices.fetchApi(
                  isRefresh: true, selectedImage: image.imageQuality);
              if (result) {
                myServices.refreshController.refreshCompleted();
              } else {
                myServices.refreshController.refreshFailed();
              }
            },
            onLoading: () async {
              final result =
                  await myServices.fetchApi(isLoading : true, selectedImage: image.imageQuality);
              if (result) {
                myServices.refreshController.loadComplete();
              } else {
                myServices.refreshController.loadFailed();
              }
            },
            child: myServices.data.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 233, 233, 233),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18.0),
                                child: 
                                ifItIsNull(myServices, index, "description")
                                // myServices.data[index]["description"] ==
                                        // null
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        myServices.data[index]["description"]
                                            .toString()
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                              ),
                            ),
                            SizedBox(
                              child: ifItIsNull(myServices, index, "url")
                              // myServices.data[index]["url"] == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Image.network(
                                      myServices.data[index]["url"].toString(),
                                      fit: BoxFit.cover,
                                    ),
                              width: double.infinity,
                              height: 300,
                            ),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ifItIsNull(myServices, index, "height")
                                  // myServices.data[index]["height"] == null
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          "height : " +
                                              myServices.data[index]["height"]
                                                  .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ifItIsNull(myServices, index, "width")
                                  // myServices.data[index]["width"] == null
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          "width : " +
                                              myServices.data[index]["width"]
                                                  .toString(),
                                          // "width : " + currentData.width.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                ],
                              ),
                              height: 40,
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(
                            thickness: 5,
                          ),
                        ),
                    itemCount: myServices.data.length),
          ),
        )
      ],
    ));
  }
}
