import 'package:estacionamiento_aparka/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.white,
        appBar: AppBar(
          backgroundColor: AppTheme.secondary,
          title: const Text(
            'Reportes',
            style: TextStyle(
                fontSize: 24,
                color: AppTheme.white,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              color: AppTheme.white,
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                        flex: 6,
                        child: Text(
                          'Consumo mensual de vales',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.secondary,
                              fontWeight: FontWeight.w400),
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.primary,
                              size: 20,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                        flex: 6,
                        child: Text(
                          'Solicitudes vigentes',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.secondary,
                              fontWeight: FontWeight.w400),
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppTheme.primary,
                              size: 20,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
