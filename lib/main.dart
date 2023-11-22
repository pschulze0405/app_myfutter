import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //Hauptklasse in der Startseite
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: ' MyFutter '),
    );
  }
}
// Grundgerüst für gewisse Eigenschaften der App (wie Farbschema und Titel)
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// Klasse = die Startseite der App

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final List<TextEditingController> _additionalTextControllers = [];
  bool _isOnHomePage = true;
  // Zustand der Klasse der veränderbar ist

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _additionalTextControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
  //Kontrolliert Texteingabefelder ob genutzt - sonst wieder Freigabe der Ressourcen

  void _addAdditionalTextField() {
    setState(() {
      _additionalTextControllers.add(TextEditingController());
    });
  }
  // einzelne Textfelder weiter hinzufügen

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _searchInDatabase() {
    List<String> searchTerms = [
      _textController1.text,
      _textController2.text,
      _textController3.text,
      ..._additionalTextControllers.map((controller) => controller.text),
      // Suche in Datenbank nach den eingegeben Zutaten
    ];

    print('Suche in der Datenbank nach: ${searchTerms.join(', ')}');
    // ZUM TEST: Ausgabe der eingegebenen Zutaten in Konsole
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 150,
        elevation: 0.0,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  'assets/images/Knoblauch.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CooperBlack',
                        color: Colors.black,
                      )
                  )
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  'assets/images/Zwiebel.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),

      ),
      // Ausschmücken der Appbar mit Schriftart und Bildern (+jeweilige Eigenschaften)
      body: GestureDetector(
        onTap: _closeKeyboard,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'Womit kochen wir heute?',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                // Definiert Inhalt und den Bereich zwischen Textfeldern und Appbar
                SizedBox(height: 74),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _textController1,
                    decoration: InputDecoration(
                      hintText: 'Zutat 1',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _textController2,
                    decoration: InputDecoration(
                      hintText: 'Zutat 2',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _textController3,
                    decoration: InputDecoration(
                      hintText: 'Zutat 3',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                // Definiert Eigenschaften der drei festen Eingabefelder
                ..._additionalTextControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return Column(
                    children: [
                      SizedBox(height: 25),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Zutat ${index + 4}',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                SizedBox(height: 16),
                // Definiert Eigenschaften von zusätzlich hinzugefügten Texteingabefeldern
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _addAdditionalTextField,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellowAccent,
                      ),
                      child: Text('Weitere Zutaten hinzufügen'),
                    ),
                    // Klicken fügt weiteres Textfeld zur Eingabe mehrerer Zutaten hinzu
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _searchInDatabase,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text('Suchen'),
                    ),
                    // Suche in Datenbank
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Navigationsleiste mit 2 Buttons
            Expanded(
              child: FloatingActionButton.extended(
                onPressed: _isOnHomePage
                    ? null
                    : () {
                  print('Startseite');
                },
                label: Text('Startseite'),
                icon: Icon(Icons.home),
                backgroundColor: _isOnHomePage ? Colors.grey : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            // Button zur Startseite hin (in dem Fall ausgegraut, weil bereits auf Starseite
            Expanded(
              child: FloatingActionButton.extended(
                backgroundColor: Colors.yellowAccent,
                onPressed: () {
                  print('Eigene Rezepte teilen');
                },
                label: Text('Eigene Rezepte teilen'),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            // Button zum Erstellen eigener Rezepte hin
          ],
        ),
      ),
    );
  }
}
