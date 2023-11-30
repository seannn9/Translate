import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

const List<String> list = <String>['English', 'Japanese', 'Filipino'];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: Text("Translate"),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Text"
                      ),
                    )
                  )),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  print("Translated");
                },
                child: Text(
                  "Translate"
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
