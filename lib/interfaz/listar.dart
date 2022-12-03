import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geo/controlador/controladorGeneral.dart';
import 'package:geo/proceso/peticionesDB.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class listar extends StatefulWidget {
  const listar({super.key});

  @override
  State<listar> createState() => _listarState();
}

class _listarState extends State<listar> {
  controladorGeneral Control = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Control.CargarTodaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: Control.listaPosicion?.isEmpty == false
              ? ListView.builder(
                  itemCount: Control.listaPosicion!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.location_searching),
                        trailing: IconButton(
                            onPressed: () {
                              Alert(
                                      type: AlertType.warning,
                                      title: "ATENCION!!!",
                                      buttons: [
                                        DialogButton(
                                            color: Colors.green,
                                            child: Text("Si"),
                                            onPressed: () {
                                              peticionesDB.EliminarPosicion(
                                                  Control.listaPosicion![index]
                                                      ["id"]);
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
                                          "Esta seguro que desea eliminar esta posicion?",
                                      context: context)
                                  .show();
                            },
                            icon: Icon(Icons.delete_forever_outlined)),
                        title:
                            Text(Control.listaPosicion![index]["localizacion"]),
                        subtitle:
                            Text(Control.listaPosicion![index]["fechahora"]),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
