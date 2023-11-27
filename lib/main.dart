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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  'Herzlich Willkommen!',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                    'assets/images/Brokkoli.png',
                    height: 160,
                    width: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 35),
                Text(
                  'Womit kochen wir heute?',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                // Definiert Inhalt und den Bereich zwischen dem Button und der Appbar
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(35),
                    primary: Colors.orange,
                    elevation: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Los geht's",
                        style: TextStyle(
                            fontSize: 20,
                            height: 2.0,
                        ),
                      ),
                      SizedBox(height: 5),
                      Icon(
                        Icons.play_arrow_rounded,
                        size: 75,
                      ),
                    ],
                  ),
                )
                // Definiert den Inhalt, Aussehen und Funktion des Buttons
          ],
        ),
       ),
      ),
     ),
    );
  }
}
