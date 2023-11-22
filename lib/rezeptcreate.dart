import 'package:flutter/material.dart';

void main() {
  runApp(const RezeptcreateApp());
}

class RezeptcreateApp extends StatelessWidget {
  const RezeptcreateApp({Key? key}) : super(key: key);
  //Hauptklasse der Rezeptcreate

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rezeptcreate App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const Rezeptcreate(),
    );
  }
}
//Grundlegendes wieder wie Farbschema

class Rezeptcreate extends StatefulWidget {
  const Rezeptcreate({Key? key}) : super(key: key);

  @override
  _RezeptcreateState createState() => _RezeptcreateState();
}

class _RezeptcreateState extends State<Rezeptcreate> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _zutatenController = TextEditingController();
  final TextEditingController _zubereitungController = TextEditingController();
  final List<TextEditingController> _additionalTextControllers = [];
  bool _isShareButtonDisabled = true;
  // Zustand der Klasse der veränderbar ist

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _zutatenController.dispose();
    _zubereitungController.dispose();
    _additionalTextControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
  //Kontrolliert Texteingabefelder ob genutzt - sonst wieder Freigabe der Ressourcen

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _addIngredientField() {
    setState(() {
      _additionalTextControllers.add(TextEditingController());
    });
  }
  // einzelne Zutateneingabefelder weiter hinzufügen

  void _saveToDatabase() {
    String title = _textController1.text;
    String preparationTime = _textController2.text;
    String ingredients = _zutatenController.text;
    List<String> additionalIngredients = _additionalTextControllers.map((controller) => controller.text).toList();
    String preparation = _zubereitungController.text;
    //Schreibe eingebene Werte in die Datenbank
    print('Daten in die Datenbank speichern: $title, $preparationTime, $ingredients, $additionalIngredients, $preparation');
    //ZUM TEST: Ausgabe der eingebenen Werte in Konsole
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/images/Knoblauch.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Eigenes Rezept',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'erstellen',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
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
      //Definiert Eigenschaften der Appbar mit Bildern und Titel
      body: GestureDetector(
        onTap: _closeKeyboard,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 34),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _textController1,
                    decoration: InputDecoration(
                      labelText: 'Titel',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _textController2,
                    decoration: InputDecoration(
                      labelText: 'Zubereitungszeit',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _zutatenController,
                    decoration: InputDecoration(
                      labelText: 'Zutat 1',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                //Definiert die Textfelder (Titel, Zubereitungszeit, Zutat 1)


                ..._additionalTextControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return Column(
                    children: [
                      SizedBox(height: 16),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Zutat ${index + 2}',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                //Definiert die zusätzlich erstellten Eingabefelder für Zutaten

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _addIngredientField,
                  child: Text('Weitere Zutat hinzufügen'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellowAccent,
                  ),
                ),
                //Button zum Hinzufügen weiterer Zutatenfelder

                SizedBox(height: 16),

                Container(
                  width: 300,
                  child: TextField(
                    controller: _zubereitungController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Zubereitung',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                //Definiert das Textfeld (Zubereitung)

                SizedBox(height: 16),

                Container(
                  width: 300,
                  padding: EdgeInsets.only(right: 0), // Legt den rechten Abstand fest
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _saveToDatabase,
                      child: Text('Teilen'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                    ),
                  ),
                ),
                //Button zum Speichern in die Datenbank

                SizedBox(height: 16),
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
            Expanded(
              child: FloatingActionButton.extended(
                backgroundColor: Colors.yellowAccent,
                onPressed: () {
                  print('Startseite');
                },
                label: Text('Startseite'),
                icon: Icon(Icons.home),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            //Button zur Startseite hin
            Expanded(
              child: FloatingActionButton.extended(
                onPressed: _isShareButtonDisabled
                    ? null
                    : () {
                  print('Eigene Rezepte teilen');
                },
                label: Text('Eigene Rezepte teilen'),
                icon: Icon(Icons.add),
                backgroundColor: _isShareButtonDisabled ? Colors.grey : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
            //Button zum Erstellen eigener Rezepte hin (ausgegraut hier weil wir auf der Seite sind)
          ],
        ),
      ),
    );
  }
}
