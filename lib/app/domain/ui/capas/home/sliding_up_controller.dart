import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'home_controller.dart';

class SlidingUpController extends StatefulWidget {
  final _panelController;
  const SlidingUpController(this._panelController, { Key? key }) : super(key: key);

  @override
  State<SlidingUpController> createState() => _SlidingUpControllerState();
}

class _SlidingUpControllerState extends State<SlidingUpController> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_)=>widget._panelController.hide());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    return SlidingUpPanel(
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Paciente #${controller.currentPaciente}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Nombre del paciente: ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.currentPacienteName,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Llamar ahora"),
                      ),
                      FloatingActionButton(
                        heroTag: 'hr1',
                        onPressed: (){},
                        child: const Icon(Icons.phone),
                      ),
                    ],
                  )
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Ir ahora"),
                      ),
                      FloatingActionButton(
                        heroTag: 'hr2',
                        onPressed: (){},
                        child: const Icon(Icons.directions),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      controller: widget._panelController,
      backdropEnabled: true,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    );
  }
}