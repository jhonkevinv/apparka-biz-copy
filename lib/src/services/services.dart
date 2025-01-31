import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:estacionamiento_aparka/src/Environment/environment.dart';
import 'package:estacionamiento_aparka/src/screen/validation_screen/selection_page.dart';
import 'package:estacionamiento_aparka/src/theme/app_theme.dart';
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
        options: Options(contentType: 'application/json', headers: {
          'Ocp-Apim-Subscription-Key':
              'c9d863a8a13e4bdf85147aea222504a5;product=apparka-biz-apiapp'
        }),
        data: data,
      );
      if (response.statusCode == 200) {
        final mapData = json.decode(response.toString());
        if (mapData['token'].toString() == 'null') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(mapData["mensaje"].toString()),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        } else {
          GetStorage().write('tokenAccountAparka', mapData["token"]);
          GetStorage().write('idUserAparka', mapData["idUsuario"]);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bienvenido'),
              backgroundColor: AppTheme.primary,
            ),
          );
          return true;
        }
      } else {
        final mapData = json.decode(response.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mapData["mensaje"].toString()),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } on DioException catch (e) {
      final mapData = json.decode(e.response.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mapData["mensaje"].toString()),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<dynamic> calcularTicket(BuildContext context, String idTicket) async {
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
          headers: {
            'Authorization': 'Bearer $tokenUser',
            'Ocp-Apim-Subscription-Key':
                'c9d863a8a13e4bdf85147aea222504a5;product=apparka-biz-apiapp'
          },
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        final mapData = json.decode(response.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SelectionPage(mapData: mapData)));
        EasyLoading.dismiss();
        return 'true';
      } else {
        final mapData = json.decode(response.toString());
        EasyLoading.dismiss();
        return mapData;
      }
    } on DioException catch (e) {
      final mapData = json.decode(e.response.toString());
      EasyLoading.dismiss();
      return mapData;
    }
  }

  Future<bool?> consumirTicket(BuildContext context, List detalleVales,
      int playaId, int tarifaId, int movimientoId) async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    final tokenUser = GetStorage().read('tokenAccountAparka');
    final idUser = GetStorage().read('idUserAparka');
    final data = {
      "movimientoId": movimientoId,
      "usuarioId": idUser,
      "tarifaId": tarifaId,
      "playaId": playaId,
      "detalleVales": detalleVales
    };
    print('$url/playa/ticket/consumir');
    print('data: ${data.toString()}');
    try {
      final response = await dio.post(
        '$url/playa/ticket/consumir',
        options: Options(
          contentType: 'application/json',
          headers: {
            'Authorization': 'Bearer $tokenUser',
            'Ocp-Apim-Subscription-Key':
                'c9d863a8a13e4bdf85147aea222504a5;product=apparka-biz-apiapp'
          },
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.dismiss();
        return false;
      }
    } on DioException catch (e) {
      EasyLoading.dismiss();
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
          headers: {
            'Authorization': 'Bearer $tokenUser',
            'Ocp-Apim-Subscription-Key':
                'c9d863a8a13e4bdf85147aea222504a5;product=apparka-biz-apiapp'
          },
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
