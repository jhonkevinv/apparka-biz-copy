import 'package:estacionamiento_aparka/src/screen/report_screen/consumption/consumption_page.dart';
import 'package:estacionamiento_aparka/src/screen/report_screen/request/request_page.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // GestureDetector(
              //   onTap: (){
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const ConsumptionPage()));
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.only(top: 10, bottom: 10),
              //     child: Row(
              //       children: [
              //         Expanded(
              //             flex: 6,
              //             child: Text(
              //               'Consumo mensual de vales',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: AppTheme.secondary,
              //                   fontWeight: FontWeight.w400),
              //             )),
              //         Expanded(
              //             flex: 1,
              //             child: Column(
              //               children: [
              //                 Icon(
              //                   Icons.arrow_forward_ios,
              //                   color: AppTheme.primary,
              //                   size: 20,
              //                 ),
              //               ],
              //             ))
              //       ],
              //     ),
              //   ),
              // ),
              // const Divider(),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RequestPage()));
                },
                child: const Padding(
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
              )
            ],
          ),
        ));
  }
}
