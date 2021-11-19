import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsprueba1/app/domain/ui/capas/home/home_controller.dart';
import 'package:mapsprueba1/app/domain/ui/capas/home/sliding_up_controller.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final PanelController _panelController = PanelController();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_){
        /*final controller = HomeController(_panelController);
        controller.onMarkerTap.listen((id) {
          print("go to $id");
          _panelController.show();
        });*/
        return HomeController(_panelController);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mapa"),
        ),
        body: Stack(children: [
          Consumer<HomeController>(
            builder: (_,controller,__) => GoogleMap(
              onTap: (_) => _panelController.hide(),
              markers: controller.markers,
              initialCameraPosition: controller.initialCameraPosition,
              mapType: MapType.normal,
              onMapCreated: controller.onMapCreated,
              //onTap: controller.onTap,
              //onTap: (position) => print(position),
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
            ),
          ),
          SlidingUpController(_panelController)
        ],)
      )
    );
  }
}