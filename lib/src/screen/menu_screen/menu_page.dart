import 'package:estacionamiento_aparka/src/screen/login_screen/login_page.dart';
import 'package:estacionamiento_aparka/src/screen/report_screen/report_page.dart';
import 'package:estacionamiento_aparka/src/screen/validation_screen/selection_page.dart';
import 'package:estacionamiento_aparka/src/screen/validation_screen/validation_page.dart';
import 'package:estacionamiento_aparka/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.secondary,
        title: Image.asset(
          'assets/icon/logo.png',
          width: 180,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sesión Cerrada.')),
              );
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: AppTheme.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectionPage(mapData: {
                            "numero": "string",
                            "placa": "string",
                            "code": "string",
                            "horaIngreso": "string",
                            "horaSalida": "string",
                            "tiempoTotal": "string",
                            "idMovimiento": 0,
                            "idPlaya": 0,
                            "descripcionPlaya": "string",
                            "tiempoMinutos": 0,
                            "systemStatus": {
                              "fechaHora": "2025-02-03T14:27:12.289Z"
                            },
                            "tarifas": [
                              {
                                "id": "123",
                                "descripcion": "string"
                              }
                            ],
                            "vales": []
                          },)));
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                              image: AssetImage('assets/icon/validation.png'))),
                      width: 150,
                      height: 150,
                    ),
                    const Text(
                      'Validación\nde Ticket',
                      style: TextStyle(
                          fontSize: 20,
                          color: AppTheme.secondary,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportPage()));
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                              image: AssetImage('assets/icon/report.png'))),
                      width: 150,
                      height: 150,
                    ),
                    const Text(
                      'Reportes',
                      style: TextStyle(
                          fontSize: 20,
                          color: AppTheme.secondary,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
