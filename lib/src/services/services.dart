import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:estacionamiento_aparka/src/Environment/environment.dart';
import 'package:estacionamiento_aparka/src/screen/validation_screen/selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

class Services {
  Duration connectTimeout = const Duration(minutes: 1);
  Duration receiveTimeout = const Duration(minutes: 1);
  Dio dio = Dio();
  String url = Environment.apiUrl;

  Future<bool?> LoginResponse(
      BuildContext context, String username, String password) async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    final data = {"username": username, "password": password};
    try {
      final response = await dio.post(
        '$url/usuario/obtenertoken',
        options: Options(
          contentType: 'application/json',
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        final mapData = json.decode(response.toString());
        GetStorage().write('tokenAccountAparka', mapData["token"]);
        GetStorage().write('idUserAparka', mapData["idUsuario"]);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bienvenido')),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data["mensaje"])),
        );
        return false;
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response?.data["mensaje"])),
      );
      return false;
    }
  }

  Future<bool?> calcularTicket(BuildContext context, String idTicket) async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    final tokenUser = GetStorage().read('tokenAccountAparka');
    final idUser = GetStorage().read('idUserAparka');
    final data = {"idTicket": idTicket, "idUser": idUser};
    try {
      final response = await dio.post(
        '$url/playa/ticket/calcular',
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer $tokenUser'},
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        final mapData = json.decode(response.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SelectionPage(mapData: mapData)));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Escaneo Exitoso'),
            backgroundColor: Colors.green,
          ),
        );
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data["Ticket no valido."])),
        );
        return false;
      }
    } on DioException catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response?.data["Ticket no valido."])),
      );
      return false;
    }
  }

  Future<bool?> consumirTicket(BuildContext context, int minutosNumero,
      int cantidad, int playaId, int tarifaId, int movimientoId) async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    final tokenUser = GetStorage().read('tokenAccountAparka');
    final idUser = GetStorage().read('idUserAparka');
    final data = {
      "movimientoId": movimientoId,
      "usuarioId": idUser,
      "tarifaId": tarifaId,
      "playaId": playaId,
      "cantidad": cantidad,
      "minutosNumero": minutosNumero
    };
    try {
      final response = await dio.post(
        '$url/playa/ticket/reporte',
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer $tokenUser'},
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data["mensaje"])),
        );
        return false;
      }
    } on DioException catch (e) {
      EasyLoading.dismiss();
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.response?.data)),
      );
      return false;
    }
  }

  Future<List?> ListReport(BuildContext context) async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    final tokenUser = GetStorage().read('tokenAccountAparka');
    final idUser = GetStorage().read('idUserAparka');
    try {
      final response = await dio.get(
        '$url/playa/ticket/reporte?idUsuario=$idUser',
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': 'Bearer $tokenUser'},
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response?.data["mensaje"]),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }
}
