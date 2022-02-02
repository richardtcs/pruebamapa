import 'package:flutter/material.dart';
import 'package:mapsprueba1/app/domain/ui/routes/pages.dart';
import 'package:mapsprueba1/app/domain/ui/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'app/domain/ui/capas/home/home_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final PanelController _panelController = PanelController();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(create: (_) {return HomeController(_panelController);},
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.SPLASH,
      routes: appRoutes(),
    ));
  }
}