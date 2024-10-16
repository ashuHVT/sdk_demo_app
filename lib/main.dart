import 'dart:developer';

import 'package:demo_sdk/demo_sdk.dart';
import 'package:demo_sdk/scan_qr_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _token = "";
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _loading?const Center(child: CupertinoActivityIndicator(),): Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    
                    _loading =true;
                  });
                  var loginData = await Iden2Provider().login(context);
                  log("loginDetails $loginData");
                  setState(() {
                    _token = loginData;
                    _loading =false;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.amber),
                    padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child:const Text("Login")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  ScanQrProvider().scanQr(context, _token);
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.amber),
                    padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child:const Text("Scan QR")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
