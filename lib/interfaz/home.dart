import 'package:flutter/material.dart';
import 'package:geo/controlador/controladorGeneral.dart';
import 'package:geo/proceso/peticionesDB.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'listar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  controladorGeneral Control = Get.find();

  void Obtenerposicion() async {
    Position posi = await peticionesDB.determinarPosicion();
    Control.carga_unalocalizacion(posi.toString());
    print(posi.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geo Crop"),
        actions: [
          IconButton(
              onPressed: () {
                Alert(
                        type: AlertType.warning,
                        title: "ATENCION!!!",
                        buttons: [
                          DialogButton(
                              color: Colors.green,
                              child: Text("Si"),
                              onPressed: () {
                                peticionesDB.EliminarTodasPosiciones();
                                Control.CargarTodaDB();
                                Navigator.pop(context);
                              }),
                          DialogButton(
                              color: Colors.red,
                              child: Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                        desc:
                            "Esta seguro que desea eliminar TODAS las posiciones?",
                        context: context)
                    .show();
              },
              icon: Icon(Icons.delete_forever_sharp))
        ],
      ),
      body: listar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on_outlined),
        onPressed: () {
          Obtenerposicion();
          Alert(
                  type: AlertType.info,
                  title: "ATENCION!!!",
                  desc: "Esta seguro que desea almacenar su  locacalizacion " +
                      Control.pos +
                      "?",
                  buttons: [
                    DialogButton(
                        color: Colors.green,
                        child: Text("Si"),
                        onPressed: () {
                          final fh = DateTime.now();
                          peticionesDB.guardarPosicion(
                              Control.pos.toString(), fh.toString());
                          Control.CargarTodaDB();

                          Navigator.pop(context);
                        }),
                    DialogButton(
                        color: Colors.red,
                        child: Text("No"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                  context: context)
              .show();
        },
      ),
    );
  }
}
