import 'package:bekoorel/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'filter_network_list_page.dart';
import 'printroshet.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final String title = 'Filter & Search ListView';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/printroshet": (context) => printroshet("PRINT"),
        "/sersh": (context) => FilterNetworkListPage(),
        "/splash": (context) => splash(),
      },
    );
  }
}
