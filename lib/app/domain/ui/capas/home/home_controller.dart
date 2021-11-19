import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsprueba1/app/domain/ui/utils/mapstyle.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeController extends ChangeNotifier{
  final PanelController _panelController;
  HomeController(this._panelController);
  late String _currentPaciente = "";
  late String _currentPacienteName = "";

  late Map<MarkerId,Marker> _markers = crearMarkers();
  final rnd = Random();
  Set<Marker> get markers => _markers.values.toSet();
  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  String get currentPaciente  {
    print("🔥 getting paciente $_currentPaciente");
    return _currentPaciente;
  }

  String get currentPacienteName {
    return _currentPacienteName;
  }

  set currentPaciente(String paciente){
    print("😈setting paciente $paciente");
    _currentPaciente = paciente;
  }

  set currentPacienteName(String name){
    _currentPacienteName = name;
  }

  final initialCameraPosition = const CameraPosition(
    target: LatLng(10.484922881351808, -66.82052207586102),
    zoom: 18,
  );
  Map<MarkerId,Marker> crearMarkers() {
    List<LatLng> coords = const [
      LatLng(10.486602632209499, -66.82140614837407),
      LatLng(10.483512562000861, -66.81962113827467),
      LatLng(10.487201982915092, -66.82008147239685),
      LatLng(10.485969653306642, -66.818757802248)
    ];
    List<String> pacientes = const [
      "Jose Alberto",
      "Ramon Perez",
      "Jonathan Zheng",
      "Richard Velasco",
    ];
    Map<MarkerId,Marker> markerss = {};
    for (var i = 0; i < 4; i++) {
      markerss[MarkerId(i.toString())] = Marker(
        markerId: MarkerId(i.toString()),
        position: coords[i],
        onTap: (){
          panelInteraction(i.toString());
          _currentPaciente = i.toString();
          _currentPacienteName = pacientes[i];
          notifyListeners();
        }
      );
    }
    return markerss;
  }

  void panelInteraction(String i){
    if(_panelController.isPanelShown && i==_currentPaciente){
      _panelController.hide();
    } else {
      _panelController.show();
    }
  }
  void onTap(LatLng position) async {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final icon = await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'assets/btc.png');
    final Marker marker = Marker(
      markerId: markerId,
      position: position,
      draggable: true,
      icon: icon,
      rotation: double.parse(rnd.nextInt(360).toString()),
      onTap: (){
        _markersController.sink.add(id);
      },
      onDragEnd: (newPosition){
        print("new position: $newPosition");
      }
    );

    _markers[markerId] = marker;
    notifyListeners();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _markersController.close();
    super.dispose();
  }
}