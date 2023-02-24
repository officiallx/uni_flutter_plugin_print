import 'package:flutter/material.dart';
import 'package:uni_flutter_plugin_example/printer_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            "assets/print_logo.png",
            height: 100,
          ),
          const Text("Version : 01.00.00-01"),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrinterPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Printer Page",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
