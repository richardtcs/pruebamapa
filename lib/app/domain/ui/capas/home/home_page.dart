import 'package:flexible_polyline/flexible_polyline.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;
import 'package:mapsprueba1/app/domain/ui/capas/home/home_controller.dart';
import 'package:mapsprueba1/app/domain/ui/capas/home/sliding_up_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mapa"),
        ),
        body: Stack(children: [
          GoogleMap(
            polylines: controller.polyline.values.toSet(),
            onTap: (_) => controller.panelController.hide(),
            markers: controller.markers,
            initialCameraPosition: controller.initialCameraPosition,
            mapType: MapType.normal,
            onMapCreated: controller.onMapCreated,
            //onTap: controller.onTap,
            //onTap: (position) => print(position),
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
          ),
          SlidingUpController(controller.panelController),
          FloatingActionButton(onPressed: (){
            const polyline1 = "BGso-_T7vsu_DzF3DvCzFAjIo4BvtC8QjX8LnQ0FjIsY3hBoQvW8G_JwHsE01Cw0BkIsE0KgFgPsE4N8BgtB8GwvBwHsJoBwjC4I0wC0KwGe";
            const polyline2 = "BGw3ugUl0vu_DvGdsOrqCoLnpBwbvmDkN74B4Nv5B0P7iC8ajnDsO3wB8GvbsEnV4D_dUjDwRnnCUrTArJA_JA3NUvC4DnQ0FvMsEgF8zB4NsqCwRgFUsOkD46B4NwCUoiC8Q0uD4cgP4D0oBgKwqBoLwhD8a8VoGsOsEoawHssBkNkDkD4NgF0FkD8LoL8GgKwCkI4Iw0BkD0K4DoLsE8GoG4DwMwHwHkD0FoB8GoBwRUkSvC8GjDoG3D8GrEsEjDkInG0F_JsEnL8BzPUjNTjS_E7kBnG_sBnG_2B3DvbnBvHoBrJ8L3hBsOzewHrT8LvqBwH7VoG3S0F3IoGjIsdzjB8uBv0B4I7LgK3NoLna4DvM8BzKUzU7BvgBzFrOzFjNjIjNnf_dvH_JnLzP3IzPvH3STjN7BvWoB7GkDvR8BnQwCzFoGnLsOjSgUjX4NzP4IjN4IvW8B_J8BvRoB_xBTrnBkDzZ8Bze4DnVgFnQ0Z74B8G3S0FnVU_O7B_gCoGz6CArY7BnVrJ_sB_Er0CzFrnBnG3rBoB_O4DnQsE7VnBrTAnVnB3NjDnVnG_dTrYUvMwCrY8GzyBoB_T7B31B3I_vCvCrO7GnuB3DnzBUvbkDv5BUnuB_EvqB3DvWvC3XTzZoB_doB7GoBnL4DrT4D7VwC3XoBrJUvRnBrsB3DvoCA3coBzP0Kv0BwCjXT_T7B3S_EnuBwC3S4DzZUvR7BrJ3DzF3I_ErJvCzFU7G8BvHsE3NgPrEoGvMgKnQ8QnBoGwM3IgKAwRwH4DwCoL0KkIwM4S8uBA8VoBkSzFokBnGgjBvC0eU4hB0FwoCnBgyBvMkuC3D8kBoBofkDgU4I4_BoBgZ_EoiCT8zB4DokB8Gk1BwCwRkIw-BoBgUAof3Dge3DgUjDsYrE8QnGkSvH4NvHwMvHgK7L0K3G0E";
            final points1 = FlexiblePolyline.decode(polyline1)
            .map((e) => LatLng(e.lat, e.lng))
            .toList();
            final points2 = FlexiblePolyline.decode(polyline2)
            .map((e) =>LatLng(e.lat, e.lng))
            .toList();
            // Retorna la distancia
            final routetoolkit = (points1 + points2).map((e) => toolkit.LatLng(e.latitude, e.longitude)).toList();
            controller.setPolyline = {
              PolylineId("0"): Polyline(
                polylineId: PolylineId("0"),
                points: points1 + points2,
                color: Colors.blue,
                width: 4,
              )
            };
            final res = toolkit.PolygonUtil.isLocationOnPath(
              toolkit.LatLng(10.509713, -66.833003),
              routetoolkit,
              true
            );
            print(res);
          })
        ],)
    );
  }
}