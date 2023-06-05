
import 'second.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.qr_code_scanner,
                  size: 40))
            ]
          ),
          title: const Text(
            '              QR / Barcode Scanner',
          ),
        ),
        body:  Center(
          child:  ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.indigo[900]),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Second()));
            },
            child: const Text('Scan the QR Code')
          ),
        )
      ),
    );
  }
}
