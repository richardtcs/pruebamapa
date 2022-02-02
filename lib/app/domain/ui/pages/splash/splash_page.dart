import 'package:flutter/material.dart';
import 'package:mapsprueba1/app/domain/ui/capas/home/home_controller.dart';
import 'package:mapsprueba1/app/domain/ui/pages/splash/splash_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = SplashController(Permission.locationWhenInUse);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.checkPermission();
    });
    _controller.addListener(() {
      if(_controller.routeName != null){
        Navigator.pushReplacementNamed(context, _controller.routeName!);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
  }
}