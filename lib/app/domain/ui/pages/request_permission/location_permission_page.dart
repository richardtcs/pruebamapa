import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mapsprueba1/app/domain/ui/pages/request_permission/location_permission_controller.dart';
import 'package:mapsprueba1/app/domain/ui/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionPage extends StatefulWidget {
  const RequestPermissionPage({ Key? key }) : super(key: key);

  @override
  _RequestPermissionPageState createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage> with WidgetsBindingObserver{
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;
  bool _fromSettings = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _subscription = _controller.onStatusChanged.listen(
      (status) {
        switch(status){
          case PermissionStatus.granted:
            Navigator.pushReplacementNamed(context, Routes.HOME);
            break;
          case PermissionStatus.permanentlyDenied:
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Permisos"),
                content: const Text("No se pudo obtener permisos de ubicacion, por favor hagalo manualmente en ajustes"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      _fromSettings = await openAppSettings();
                    },
                    child: const Text("Ajustes")
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  )
                ],
              )
            );
            break;
        }
        if(status == PermissionStatus.granted){
          Navigator.pushReplacementNamed(context, Routes.HOME);
        }
      }
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if(state == AppLifecycleState.resumed && _fromSettings){
      final status = await _controller.check();
      if(status == PermissionStatus.granted){
        Navigator.pushReplacementNamed(context, Routes.HOME);
      }
    }
    _fromSettings = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance!.removeObserver(this);
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Text("Allow"),
            onPressed: (){
              _controller.request();
            },
          ),
        ),
      ),
    );
  }
}