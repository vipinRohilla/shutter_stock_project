import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shutter_stock/hive/hive_model.dart';
import 'package:shutter_stock/notifiers/notifiers.dart';
import 'package:shutter_stock/pages/home_page.dart';
// import 'package:shutter_stock/pages/testing_hive_model.dart';
import 'package:shutter_stock/services/shutter_stock_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  await Hive.openBox<HiveModel>('hivemodelbox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageNotifier()),
        ChangeNotifierProvider(create: (_) => ShutterStockServices())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(body: HomePage()));
  }
}
