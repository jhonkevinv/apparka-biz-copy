import 'dart:convert';

import 'package:estacionamiento_aparka/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SelectionPage extends StatefulWidget {
  SelectionPage({super.key, this.mapData});

  dynamic mapData;

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  String? dropDownValue;
  int index = 0;
  List listDropdown = [];
  List<String> selectItem = ['Eventuales por minuto', 'Experta Clientes 3h'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDropdown = widget.mapData['tarifas'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.white,
        appBar: AppBar(
          backgroundColor: AppTheme.secondary,
          title: const Text(
            'Validación de Ticket',
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
        body: Column(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Card(
                        color: AppTheme.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(10),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              TextCard('Playa', widget.mapData['idPlaya'].toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCard('Ticket', widget.mapData['numero'].toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCard('Placa',  widget.mapData['placa'].toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCard('Ingreso', widget.mapData['horaIngreso'].toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCard('Tiempo', widget.mapData['tiempoTotal'].toString()),
                              const SizedBox(
                                height: 20,
                              ),
                              DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: AppTheme.white),
                                hint: const Text(
                                  'Seleccionar tarifa',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textNormal,
                                      fontWeight: FontWeight.w400),
                                ),
                                value: dropDownValue,
                                onChanged: (value) => setState(() {
                                  dropDownValue = value.toString();
                                }),
                                items: listDropdown
                                    .map((map) => DropdownMenuItem(
                                        value: map['id'],
                                        child: Text(
                                          map['descripcion'],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.secondary,
                                              fontWeight: FontWeight.w400),
                                        )))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      )),
                  if (dropDownValue == 'Eventuales por minuto')
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Card(
                              color: AppTheme.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.all(10),
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Vales 30 minutos',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppTheme.secondary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Saldo: 10 vales',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.secondary,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'Asignado: 3 vales',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.secondary,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppTheme.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: AppTheme.primary)),
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 8,
                                                  right: 8),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        if (index > 0) {
                                                          setState(() {
                                                            index--;
                                                          });
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: AppTheme.primary,
                                                        size: 20,
                                                      )),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    index.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            AppTheme.secondary,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        if (index < 3) {
                                                          setState(() {
                                                            index++;
                                                          });
                                                        }
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: AppTheme.primary,
                                                        size: 20,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Card(
                              color: AppTheme.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.all(10),
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Vales 60 minutos',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppTheme.secondary,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Saldo: 10 vales',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.secondary,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'Asignado: 0 vales',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme.secondary,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppTheme.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: AppTheme.primary)),
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 8,
                                                  right: 8),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {},
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: AppTheme.primary,
                                                        size: 20,
                                                      )),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  const Text(
                                                    '0',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            AppTheme.secondary,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {},
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: AppTheme.primary,
                                                        size: 20,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            )),
                      ],
                    )
                ],
              ),
            )),
            SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  const Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 30, top: 10),
                    child: Row(
                      children: [
                        if (index != 0)
                          Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Consumo:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.secondary,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '${index.toString()} ${index == 1 ? 'vale' : 'vales'}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.secondary,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${index * 30} minutos',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.secondary,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )),
                        Expanded(
                            flex: 7,
                            child: GestureDetector(
                                onTap: () async {
                                  if (index != 0) {
                                    alertSuccess(context);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: AppTheme.primary,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Column(
                                    children: [
                                      Text(
                                        'Finalizar',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppTheme.white,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                )))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget TextCard(title, subtile) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.secondary,
                  fontWeight: FontWeight.w400),
            )),
        Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  subtile,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.secondary,
                      fontWeight: FontWeight.w400),
                )
              ],
            ))
      ],
    );
  }

  alertSuccess(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: customLogic(),
          child: AlertDialog(
              title: const Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFF6CAC3B),
                    size: 80,
                  ),
                  Text(
                    'Ticket\nvalidado',
                    style: TextStyle(
                        fontSize: 36,
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Se asignaron las horas\ncorrectamente',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    color: AppTheme.primary,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Column(
                                  children: [
                                    Text(
                                      'Cerrar',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppTheme.white,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              )))
                    ],
                  )
                ],
              )),
        );
      },
    );
  }

  bool customLogic() {
    {
      return false;
    }
  }
}
