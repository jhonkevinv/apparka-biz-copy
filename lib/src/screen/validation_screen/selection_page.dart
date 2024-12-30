import 'package:estacionamiento_aparka/src/services/services.dart';
import 'package:estacionamiento_aparka/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key, this.mapData});

  final dynamic mapData;

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  String? dropDownValue;
  List listDropdown = [];
  List listVales = [];
  List<int> items = [];
  List<int> items2 = [];

  @override
  void initState() {
    super.initState();
    items = List.generate(widget.mapData['vales'].length, (index) => 0);
    items2 = List.generate(widget.mapData['vales'].length,
        (index) => widget.mapData['vales'][index]['minutosNumero']);
    listDropdown = widget.mapData['tarifas'];
    listVales = widget.mapData['vales'];
  }

  // Incrementar valor
  void increment(int index) {
    setState(() {
      items[index]++;
    });
  }

  // Decrementar valor
  void decrement(int index) {
    setState(() {
      if (items[index] > 0) {
        items[index]--;
      }
    });
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
                              TextCard('Playa',
                                  widget.mapData['idPlaya'].toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCard('Ticket',
                                  widget.mapData['numero'].toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCard('Placa',
                                  widget.mapData['placa'] ?? 'Sin placa'),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCard('Ingreso',
                                  widget.mapData['horaIngreso'].toString()),
                              const SizedBox(
                                height: 10,
                              ),
                              TextCard('Tiempo',
                                  widget.mapData['tiempoTotal'].toString()),
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
                  Flexible(
                      child: ListView.builder(
                    itemCount: listVales.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
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
                                  Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vales ${listVales[index]['minutosNumero']} minutos',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: AppTheme.secondary,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Saldo: ${listVales[index]['cantidad']} vales',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.secondary,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'Asignado: ${items[index].toString()} vales',
                                            style: const TextStyle(
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
                                                      if (listVales[index]
                                                              ['cantidad'] >
                                                          0) {
                                                        decrement(index);
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
                                                  items[index].toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: AppTheme.secondary,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      if (items[index] <
                                                          listVales[index]
                                                              ['cantidad']) {
                                                        increment(index);
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
                          ));
                    },
                  ))
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
                        if (dropDownValue != null &&
                            List.generate(
                                  items.length,
                                  (index) => items[index] * items2[index],
                                ).fold(0, (sum, number) => sum + number) >
                                0)
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
                                    '${items.fold(0, (sum, number) => sum + number).toString()} ${items.fold(0, (sum, number) => sum + number) == 1 ? 'vale' : 'vales'}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.secondary,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${List.generate(
                                      items.length,
                                      (index) => items[index] * items2[index],
                                    ).fold(0, (sum, number) => sum + number).toString()} minutos',
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
                                  if (dropDownValue != null &&
                                      List.generate(
                                            items.length,
                                            (index) =>
                                                items[index] * items2[index],
                                          ).fold(0,
                                              (sum, number) => sum + number) >
                                          0) {
                                    EasyLoading.show(
                                      status: 'Validando...',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    final result = await Services()
                                        .consumirTicket(
                                            context,
                                            List.generate(
                                              items.length,
                                              (index) =>
                                                  items[index] * items2[index],
                                            ).fold(0,
                                                (sum, number) => sum + number),
                                            items.fold(0,
                                                (sum, number) => sum + number),
                                            widget.mapData['idPlaya'],
                                            int.parse(dropDownValue ?? ''),
                                            widget.mapData['idMovimiento']);

                                    if (result == false) {
                                      alert(context, error: true);
                                    } else {
                                      alert(context);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Seleccionar la tarifa o vales'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
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

  alert(context, {bool error = false}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: customLogic(),
          child: AlertDialog(
              title: Column(
                children: [
                  Icon(
                    error ? Icons.error : Icons.check_circle,
                    color: error ? Colors.red : const Color(0xFF6CAC3B),
                    size: 80,
                  ),
                  Text(
                    error ? '¡Ups!' : 'Ticket\nvalidado',
                    style: TextStyle(
                        fontSize: 36,
                        color: error ? Colors.red : AppTheme.secondary,
                        fontWeight: error ? FontWeight.w700 : FontWeight.w500),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    error
                        ? 'No se asignaron las horas\ncorrectamente'
                        : 'Se asignaron las horas\ncorrectamente',
                    style: const TextStyle(
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
