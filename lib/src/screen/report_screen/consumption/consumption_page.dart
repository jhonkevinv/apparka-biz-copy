import 'package:estacionamiento_aparka/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsumptionPage extends StatefulWidget {
  const ConsumptionPage({super.key});

  @override
  State<ConsumptionPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<ConsumptionPage> {
  String? dropDownValue;
  List<String> selectItem = ['Eventuales por minuto', 'Experta Clientes 3h'];
  String selectedDate = 'Año';
  final f = DateFormat('dd-MM-yyyy');

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
        body: Column(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Consumo mensual de vales',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppTheme.secondary,
                                fontWeight: FontWeight.w700),
                          ))
                        ],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              Expanded(child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppTheme.colorInput,
                                      ),
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 20, bottom: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedDate,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: selectedDate != 'Año' ? AppTheme.secondary : Colors.grey
                                            ),
                                          ),
                                          const Icon(Icons.arrow_drop_down_outlined, color: AppTheme.primary,)
                                        ],
                                      )))),
                              const SizedBox(width: 20,),
                              Expanded(child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.colorInput,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: AppTheme.white),
                                hint: const Text(
                                  'Tipo de vale',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                iconEnabledColor: AppTheme.primary,
                                isExpanded: true,
                                value: dropDownValue,
                                onChanged: (Value) => setState(() {
                                  dropDownValue = Value;
                                }),
                                items: selectItem
                                    .map((tarifa) => DropdownMenuItem(
                                    value: tarifa,
                                    child: Text(
                                      tarifa,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.secondary,
                                          fontWeight: FontWeight.w400),
                                    )))
                                    .toList(),
                              ))
                            ],
                          ))),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppTheme.colorInput,
                                ),
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  decoration: const BoxDecoration(
                                      color: AppTheme.secondary,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: TextTable(
                                      'Mes',
                                      'Cantidad\nde vales',
                                      'Minutos consumidos',
                                      AppTheme.white,
                                      FontWeight.w600),
                                ),
                                Container(
                                  height: 320,
                                  child: ListView(
                                    children: [
                                      TextTable('Enero', '30', '100',
                                          AppTheme.secondary, FontWeight.w400),
                                      const Divider(
                                        color: AppTheme.secondary,
                                        thickness: 1,
                                      ),
                                      TextTable('Febrero', '6', '100',
                                          AppTheme.secondary, FontWeight.w400),
                                      const Divider(
                                        color: AppTheme.secondary,
                                        thickness: 1,
                                      ),
                                      TextTable('Marzo', '6', '100',
                                          AppTheme.secondary, FontWeight.w400),
                                      const Divider(
                                        color: AppTheme.secondary,
                                        thickness: 1,
                                      ),
                                      TextTable('Abril', '6', '100',
                                          AppTheme.secondary, FontWeight.w400),
                                      const Divider(
                                        color: AppTheme.secondary,
                                        thickness: 1,
                                      ),
                                      TextTable('Mayo', '6', '100',
                                          AppTheme.secondary, FontWeight.w400),
                                      const Divider(
                                        color: AppTheme.secondary,
                                        thickness: 1,
                                      ),
                                      TextTable('Junio', '6', '100',
                                          AppTheme.secondary, FontWeight.w400),
                                      const Divider(
                                        color: AppTheme.secondary,
                                        thickness: 1,
                                      ),
                                      TextTable('Julio', '6', '100',
                                          AppTheme.secondary, FontWeight.w400),
                                      const SizedBox(
                                        height: 5,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Card(
                        color: AppTheme.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(5),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 22, bottom: 22),
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Saldo',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.secondary,
                                        fontWeight: FontWeight.w600),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextCard('30 minutos', '10'),
                              const SizedBox(
                                height: 8,
                              ),
                              TextCard('60 minutos', '5'),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            )),
          ],
        ));
  }

  Widget TextCard(title, subtile) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.secondary,
                  fontWeight: FontWeight.w400),
            )),
        Expanded(
            flex: 4,
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

  Widget TextTable(text, text2, text3, Color color, FontWeight fontWeight) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              text,
              style:
                  TextStyle(fontSize: 16, color: color, fontWeight: fontWeight),
              textAlign: TextAlign.center,
            )),
            Expanded(
                child: Text(
              text2,
              style:
                  TextStyle(fontSize: 16, color: color, fontWeight: fontWeight),
              textAlign: TextAlign.center,
            )),
            Expanded(
                child: Text(
              text3,
              style:
                  TextStyle(fontSize: 16, color: color, fontWeight: fontWeight),
              textAlign: TextAlign.center,
            ))
          ],
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppTheme.primary,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.secondary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = f.format(picked).toString();
      });
    }
  }
}
