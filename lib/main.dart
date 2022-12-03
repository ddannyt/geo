import 'package:flutter/material.dart';
import 'package:geo/controlador/controladorGeneral.dart';
import 'package:get/get.dart';
import 'interfaz/home.dart';

void main() {
  Get.put(controladorGeneral());
  runApp(const MyApp());
}
