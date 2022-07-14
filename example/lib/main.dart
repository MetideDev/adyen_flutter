import 'dart:convert';

import 'package:adyen_dropin/flutter_adyen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'mock_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _payment_result = 'Unknown';

  String? dropInResponse;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            try {
    dropInResponse = await FlutterAdyen.openDropIn(
    paymentMethods: jsonEncode(examplePaymentMethods),
    baseUrl: 'https://a33e-93-63-161-194.eu.ngrok.io', //'https://99f0-93-63-161-194.eu.ngrok.io', //'https://sso.prenatalstg.isobar.it',
    urlPayments: '/api/v1/payment-gateway/payments',
    urlPaymentsDetail: '/api/v1/payment-gateway/payments/details',
    clientKey: 'test_RSSQUKGFD5EUXPNCT5D64TSLEU6IPZ5G', //'test_NAIAJ4UMOVEHTGS72VQFHKGWUUMGCIMG',
    publicKey: 'pub.v2.8016570101310041.hsPmoL66yx4-R0tmd0RtStSsosoeEAo_Rx9Yu2fEjOk', //'pub.v2.8216402488313521.aHR0cHM6Ly9zc28ucHJlbmF0YWxzdGcuaXNvYmFyLml0.qP9eyMJfLpkpordCTWLhY6GoZ4VWb7CArjm6Ed6HbZI',
    locale: 'it_IT',
    shopperReference: 'FtredesinimetideECOM', //MERCHANT_ACCOUNT,
    returnUrl: 'http://asd.de',
    amount: '1230',
    lineItem: {'id': '1', 'description': 'adyen test'},
    currency: 'EUR',
    additionalData: {},
    environment: "TEST", //LIVE_EUROPE,
    headersHttp: {"Content-Type": "application/json", "test1": "value1", "test2": "value2"}
    );
            } on PlatformException catch (e) {
              if (e.code == 'PAYMENT_CANCELLED')
                dropInResponse = 'Payment Cancelled';
              else
                dropInResponse = 'Payment Error';
            }

            setState(() {
              _payment_result = dropInResponse;
            });
          },
        ),
        appBar: AppBar(
          title: const Text('Flutter Adyen'),
        ),
        body: Center(
          child: Text('Payment Result: $_payment_result\n'),
        ),
      ),
    );
  }
}
