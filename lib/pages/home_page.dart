// import 'dart:html';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// import 'package:shutter_stock/models/shutter_stock_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shutter_stock/constants/variables.dart';

// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:shutter_stock/model/preview.dart';
// import 'package:shutter_stock/model/shutter_stock_model.dart';
// import 'package:shutter_stock/notifiers/notifiers.dart';
import 'package:shutter_stock/services/shutter_stock_services.dart';

// import '../constants/api.dart';

// import '../constants/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ScrollController _scrollController = ScrollController();

  // String imagesQuality = "preview";
  // ShutterStockServices services = ShutterStockServices();
  // dynamic imageQuality;

  // ["preview","small_thumb","large_thumb","huge_thumb","preview_1000","preview_1500"];
  // ResponseNotifier responseNotifier = ResponseNotifier();

  // Future fetchImage() async {
  //   response = await services.fetchApi();
  //   setState(() {
  //     response = response;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // services.fetchApi();
    // _scrollController.addListener((){
    //   if(_scrollController.position.maxScrollExtent == _scrollController.offset){
    //     print(currentPage);
    //     fetchApi();
    //   }
    // });
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  void selectedImages(ShutterStockServices myServices, String e) {
    myServices.fetchApi(selectedImage: e);
  }

  @override
  Widget build(BuildContext context) {
    // ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    // ImageNotifier imageNotifier = Provider.of<ImageNotifier>(context);
    ShutterStockServices myServices =
        Provider.of<ShutterStockServices>(context);
 
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
            child: IconButton(
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
                                  onTap: () {
                                    selectedImages(myServices, e);
                                    Navigator.of(context).pop(e);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                      Text(currentImageQuality)
                    ],
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                )),
            width: double.infinity,
          ),
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        Expanded(
          flex: 5,
          child: SmartRefresher(
            controller: myServices.refreshController,
            enablePullUp: true,
            onRefresh: () async {
              final result = await myServices.fetchApi(isRefresh: true);
              if (result) {
                myServices.refreshController.refreshCompleted();
              } else {
                myServices.refreshController.refreshFailed();
              }
            },
            onLoading: () async {
              final result = await myServices.fetchApi();
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
                      // if(index< items.length){
                      // print(services.data);
                      // final item = myServices.items[index];
                      // final currentData = item.assets!.preview!;
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
                                child: myServices.data[index]["description"] ==
                                        null
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text(
                                        // item
                                        // .description.
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
                              child: myServices.data[index]["url"] == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Image.network(
                                      myServices.data[index]["url"].toString(),
                                      //  myServices.data[index].toString(),
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
                                  myServices.data[index]["height"] == null
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          "height : " +
                                              myServices.data[index]["height"]
                                                  .toString(),

                                          // "height : " + currentData.height.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                  myServices.data[index]["width"] == null
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
                      // }
                      // else{
                      //   return const Padding(
                      //     padding : EdgeInsets.symmetric(vertical: 32),
                      //     child: Center(
                      //       child : CircularProgressIndicator()
                      //     ),
                      //   );
                      // }
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
        // Expanded(
        //   child: FutureBuilder<ShutterStockModel>(
        //       future: services.fetchApi(),
        //       builder: (context, snapshot) {
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         } else if (snapshot.hasError) {
        //           // print(snapshot.error);
        //           return Center(
        //               child: Text(
        //             snapshot.hasError.toString(),
        //           ));
        //         } else if (snapshot.hasData) {
        //           return Column(
        //             children: [
        //               Expanded(
        //                 child: SizedBox(
        //
        //                   child: IconButton(
        //                       onPressed: () {
        //                         showDialog(
        //                           context: context,
        //                           builder: (context) => Dialog(
        //                             child: ListView(
        //                               padding:
        //                                   const EdgeInsets.symmetric(vertical: 16),
        //                               shrinkWrap: true,
        //                               children: [
        //                                 'preview',
        //                                 "small thumb",
        //                                 "large thumb",
        //                                 "huge thumb",
        //                                 "preview 1000",
        //                                 "preview 1500"
        //                               ]
        //                                   .map((e) => InkWell(
        //                                         onTap: () {
        //                                             Navigator.of(context).pop(e);
        //                                         },
        //                                         child: Container(
        //                                           decoration: BoxDecoration(
        //                                               color: Colors.grey[200],
        //                                             borderRadius: BorderRadius.circular(10)
        //                                           ),
        //                                           margin: const EdgeInsets.symmetric(vertical : 10,
        //                                             horizontal: 10
        //
        //                                           ),
        //
        //                                           padding:
        //                                               const EdgeInsets.symmetric(
        //                                                   vertical: 20,
        //                                                   horizontal: 16),
        //                                           child: Text(e.toUpperCase()),
        //                                         ),
        //                                       ))
        //                                   .toList(),
        //                             ),
        //                           ),
        //                         );
        //                       },
        //                       icon:
        //                         Container(
        //
        //                           child: Column(
        //                             children: const [
        //                               Icon(Icons.arrow_drop_down_circle_sharp),
        //                               Text("select image quality")
        //                             ],
        //                           ),
        //                           width: double.infinity,
        //                           padding: const EdgeInsets.all(20),
        //                         )
        //                   ),
        //                   width: double.infinity,
        //                 ),
        //               ),
        //               Expanded(
        //                 flex : 5,
        //                 child: ListView.builder(
        //                   controller: _scrollController,
        //                     itemCount: snapshot.data!.data!.length+1,
        //                     itemBuilder: (context, index) {
        //
        //                     if(index < snapshot.data!.data!.length){
        //                       // final item = snapshot
        //                       //     .data!.data![index];
        //                       String url = snapshot
        //                           .data!.data![index].assets!.preview!.url
        //                           .toString();
        //                       return Padding(
        //                         padding: const EdgeInsets.symmetric(
        //                             vertical: 2.0),
        //                         child: SizedBox(
        //                           height: 300,
        //                           width: double.infinity,
        //                           child: Image.network(
        //                             url,
        //                             fit: BoxFit.cover,
        //                             scale: (snapshot
        //                                 .data!.data![index].aspect!) *
        //                                 1.0,
        //                           ),
        //                         ),
        //                       );
        //
        //                     }
        //                     else{
        //                       return const Padding(
        //                           padding: EdgeInsets.symmetric(vertical: 32),
        //                           child: Center(
        //                             child: CircularProgressIndicator()
        //                           )
        //                       );
        //
        //                     }
        //
        //                       // return Padding(
        //                       //   padding: const EdgeInsets.symmetric(
        //                       //       vertical: 2.0),
        //                       //   child: SizedBox(
        //                       //     height: 300,
        //                       //     width: double.infinity,
        //                       //     child: Image.network(
        //                       //       url,
        //                       //       fit: BoxFit.cover,
        //                       //       scale: (snapshot
        //                       //               .data!.data![index].aspect!) *
        //                       //           1.0,
        //                       //     ),
        //                       //   ),
        //                       // );
        //                     }),
        //               ),
        //             ],
        //           );
        //         } else {
        //           return const Center(
        //             child: Text("waiting.."),
        //           );
        //         }
        //       }),
        // ),
      ],
    ));

    // Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 28.0),
    //       child: Wrap(
    //         alignment: WrapAlignment.center,
    //         children: [
    //           ElevatedButton(
    //               onPressed: () {
    //                 imageNotifier.setImageQualityTo = "preview";
    //               },
    //               child: Text("preview")),
    //           const SizedBox(width: 10),
    //           ElevatedButton(
    //               onPressed: () {
    //                 imageNotifier.setImageQualityTo = "small_thumb";
    //               },
    //               child: const Text("small thumb")),
    //           const SizedBox(width: 10),
    //           ElevatedButton(
    //               onPressed: () {
    //                 imageNotifier.setImageQualityTo = "large_thumb";
    //               },
    //               child: const Text("large thumb")),
    //           const SizedBox(width: 10),
    //           ElevatedButton(
    //               onPressed: () {
    //                 imageNotifier.setImageQualityTo = "huge_thumb";
    //               },
    //               child: const Text("huge thumb")),
    //           const SizedBox(width: 10),
    //           ElevatedButton(
    //               onPressed: () {
    //                 imageNotifier.setImageQualityTo = "preview_1000";
    //               },
    //               child: const Text("preview_1000")),
    //           const SizedBox(width: 10),
    //           ElevatedButton(
    //               onPressed: () {
    //                 imageNotifier.setImageQualityTo = "preview_1500";
    //               },
    //               child: const Text("preview_1500"))
    //         ],
    //       ),
    //     ),
    //     response == null
    //         ? const Center(
    //       child: CircularProgressIndicator(),
    //     )
    //         : Expanded(
    //       child: ListView.builder(
    //         itemCount: response == null ? 0 : response.length,
    //         itemBuilder: (context, index) {
    //           return Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 20.0),
    //             child: response == null
    //                 ? const Center(
    //               child: CircularProgressIndicator(),
    //             )
    //                 : SizedBox(
    //               width: double.infinity,
    //               height: 200,
    //               child: Image.network(
    //                 response[index]["assets"]
    //                 [imageNotifier.imageQuality]["url"],
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   ],
    // ),
  }
}
