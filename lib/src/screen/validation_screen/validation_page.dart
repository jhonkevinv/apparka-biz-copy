import 'dart:developer';
import 'dart:io';
import 'package:estacionamiento_aparka/src/services/services.dart';
import 'package:estacionamiento_aparka/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ValidationPage extends StatefulWidget {
  const ValidationPage({super.key});

  @override
  State<ValidationPage> createState() => _ValidationPageState();
}

class _ValidationPageState extends State<ValidationPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Escanea ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.secondary,
                                  fontWeight: FontWeight.w700)),
                          TextSpan(
                              text: 'tu ticket de estacionamiento',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.secondary,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: _buildQrView(context)),
              // TextButton(
              //     onPressed: () async {
              //       final result = await Services().calcularTicket(context, '');

              //       if (result == false) {
              //         controller?.resumeCamera();
              //       }
              //     },
              //     child: const Text('Reporte'))
            ],
          ),
        ));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width / 1.3;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          cutOutHeight: 170,
          cutOutWidth: scanArea,
          overlayColor: Colors.black87,
          borderColor: AppTheme.secondary,
          borderRadius: 20,
          borderLength: 1,
          borderWidth: 1),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      EasyLoading.show(
        status: 'Validando...',
        maskType: EasyLoadingMaskType.black,
      );
      final result =
          await Services().calcularTicket(context, scanData.code.toString());

      if (result == false) {
        controller.resumeCamera();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
