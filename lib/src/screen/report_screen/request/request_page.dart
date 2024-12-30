import 'package:estacionamiento_aparka/src/services/services.dart';
import 'package:estacionamiento_aparka/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  List? listData = ['a'];

  @override
  void initState() {
    super.initState();
    data();
  }

  data() async {
    List? list = await Services().ListReport(context);
    setState(() {
      listData = list;
    });
  }

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
        body: listData.toString() == '[a]'
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.primary))
            : Padding(
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
                              'Solicitudes vigentes',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppTheme.secondary,
                                  fontWeight: FontWeight.w700),
                            ))
                          ],
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(thickness: 1.5, height: 0,),
                    Flexible(
                      child: listData?.isEmpty == true
                          ? const Center(
                              child: Text('No se encontraron registros'))
                          : ListView.builder(
                              itemCount: listData!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Card(
                                      color: AppTheme.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.all(5),
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 22,
                                            bottom: 22),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  'Codigo 000${listData?[index]['playaId'].toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: AppTheme.secondary,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            TextCard('Descripción:',
                                                '${listData?[index]['descripcion'].toString()}'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextCard('Saldo',
                                                '${listData?[index]['saldo'].toString()}'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextCard('Por vencer',
                                                '${listData?[index]['porVencer'].toString()}'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextCard('Mes anterior',
                                                '${listData?[index]['mesAnterior'].toString()}'),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextCard('Mes actual',
                                                '${listData?[index]['mesActual'].toString()}'),
                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                    ),
                  ],
                ),
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
}
