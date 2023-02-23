import 'package:flutter/material.dart';
import 'dart:async';

import 'package:uni_flutter_plugin/uni_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final uniFlutterPlugin = UniFlutterPlugin();
  final textController = TextEditingController();

  Future<void> initPrinter() async {
    int ret = await uniFlutterPlugin.initPrinter();
    setStatus("Printer : Init Status : $ret");
  }

  Future<void> printText() async {
    String data = textController.text;
    if (data.isNotEmpty) {
      int ret = await uniFlutterPlugin.printText("$data\n");
      setStatus("Printer : Print Text Status : $ret");
    }
  }

  void setStatus(String status) {
    this.status = status;
    setState(() {});
  }

  String status = "Printer Status";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () => initPrinter(),
                        child: const Text("Init Printer")),
                  ),
                ],
              ),
              TextField(
                decoration: const InputDecoration(label: Text("Data")),
                controller: textController,
              ),
              ElevatedButton(
                  onPressed: () => printText(), child: const Text("Print Text"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }
}
