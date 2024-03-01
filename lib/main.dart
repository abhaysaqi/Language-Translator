import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

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
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Language Translator'),
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
  var languages = [
    'Hindi',
    'English',
    'Punjabi',
    'Bengoli',
  ];
  var originlang = "From";
  var dest_lang = "To";
  var output = "";
  TextEditingController lang_controller = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text;
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Fail to Translate';
      });
    }
  }

  String getlanguagecode(String language) {
    if (language == "English") {
      return "en";
    } else if (language == 'Hindi') {
      return "hi";
    } else if (language == "Punjabi") {
      return "pa";
    } else if (language == 'Bengoli') {
      return "bn";
    } else {
      return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          backgroundColor: Colors.pink.shade500,
          title: Center(
              child: Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    // focusColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    hint: Text(
                      originlang,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropdownitem) {
                      return DropdownMenuItem(
                        child: Text(dropdownitem),
                        value: dropdownitem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originlang = value!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 40,
                    width: 20,
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.red,
                    size: 40,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    // focusColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    hint: Text(
                      dest_lang,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropdownitem) {
                      return DropdownMenuItem(
                        child: Text(dropdownitem),
                        value: dropdownitem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dest_lang = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Please Enter Your Text..',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    errorStyle: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  controller: lang_controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter text";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xff2b3c5a)),
                    onPressed: () {
                      translate(getlanguagecode(originlang),
                          getlanguagecode(dest_lang), lang_controller.text);
                    },
                    child: Text(
                      "Translate",
                      style: TextStyle(color: Colors.pink.shade400),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "\n $output",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              )
            ],
          ),
        ));
  }
}
