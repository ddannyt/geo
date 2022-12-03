import 'package:geo/proceso/peticionesDB.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class controladorGeneral extends GetxController {
  final Rxn<List<Map<String, dynamic>>> _listaPosicion =
      Rxn<List<Map<String, dynamic>>>();

  final _pos = "".obs;
  ////////////////////////
  void carga_unalocalizacion(String X) {
    _pos.value = X;
  }

  String get pos => _pos.value;

//////////////////////////
  void cargar_posiciones(List<Map<String, dynamic>> X) {
    _listaPosicion.value = X;
  }

  List<Map<String, dynamic>>? get listaPosicion => _listaPosicion.value;

/////////
  Future<void> CargarTodaDB() async {
    final datos = await peticionesDB.MostrarPosiciones();
    cargar_posiciones(datos);
  }
}
