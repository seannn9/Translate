import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

const List<String> list = <String>['en', 'es', 'zh-cn', 'de', 'fr', 'hi', 'it', 'ja', 'pt', 'ru', 'tl'];

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
  final translator = GoogleTranslator();
  final tts = FlutterTts();
  dynamic text;
  var translated = "";

  void translateText() {
    translator.translate(text, to: dropdownValue).then((result) {
      setState(() {
        translated = result.text;
      });
    });
  }

  speak(String text, String lang) async {
    await tts.setLanguage(lang);
    await tts.setPitch(1); // 0.5 to 1.5
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Translate"),
              centerTitle: true,
              backgroundColor: Colors.grey[900],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                text = val;
                              });
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Text"
                            ),
                          )
                      )),
                      Container(
                        margin: const EdgeInsets.only(right: 20.0),
                        child: DropdownMenu<String>(
                          initialSelection: list.first,
                          onSelected: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: list.map<
                              DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      translateText();
                    },
                    child: const Text(
                        "Translate"
                    ),
                  ),
                  const SizedBox(height:30.0,
                  child: Divider(thickness: 1.0, color: Colors.black)),
                  const Text(
                    "Result",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                      color: Colors.green,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                              translated,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            )
                          )
                      )
                  ),
                  ElevatedButton(
                      onPressed: () => speak(translated, dropdownValue),
                      child: const Icon(Icons.volume_up)
                  )
                ],
              ),
            )
        )
    );
  }
}
