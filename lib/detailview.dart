import 'package:flutter/material.dart';

void main() {
  runApp(const DetailviewApp());
}

class DetailviewApp extends StatelessWidget {
  const DetailviewApp({Key? key}) : super(key: key);
  //Hauptklasse der Detailview

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detailview App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const Detailview(),
    );
  }
}
//Grundlegendes wieder wie Farbschema

class Detailview extends StatefulWidget {
  const Detailview({Key? key}) : super(key: key);

  @override
  _DetailviewState createState() => _DetailviewState();
}

class _DetailviewState extends State<Detailview> {

  late Future<String> _titelFuture;
  late Future<String> _zeitFuture;
  late Future<String> _zutatenFuture;
  late Future<String> _zubereitungFuture;
  //Informationen, die aus der Datenbank abgerufen werden

  @override
  void initState() {
    super.initState();
    _titelFuture = _fetchTitelFromDatabase();
    _zeitFuture = _fetchZeitFromDatabase();
    _zutatenFuture = _fetchZutatenFromDatabase();
    _zubereitungFuture = _fetchZubereitungFromDatabase();
  }
  //Vorbereitung für Datebankabruf

  Future<String> _fetchTitelFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Fetched Titel';
  }

  Future<String> _fetchZeitFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Fetched Zeit';
  }

  Future<String> _fetchZutatenFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Fetched Zutaten';
  }

  Future<String> _fetchZubereitungFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Fetched Zubereitung';
  }
  //Funktionen zum Abruf der Daten aus der Datenbank mit einer 2 sekündigen Verzögerung

  void _goToHomePage() {
    Navigator.pop(context);
  }

  void _shareRecipe() {
    print('Eigene Rezepte teilen');
  }

  void _goBack() {
    Navigator.pop(context);
  }
  //Navigationsoptionen für Übergänge (Startseite, Zurück, Eigene Rezepte teilen)

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
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  'assets/images/Brokkoli.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FutureBuilder<String>(
                    future: _titelFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? 'Titel',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  'assets/images/Chili.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
      //Definiert Eigenschaften der Appbar mit Bildern und Titel (aus der Datenbank abgerufen)
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 36.0),
                      child: Text(
                        'Zeit:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 36.0),
                      child: FutureBuilder<String>(
                        future: _zeitFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Container(
                              width: 200,
                              child: TextField(
                                controller: TextEditingController(text: snapshot.data),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 36.0),
                      child: Text(
                        'Zutaten:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 36.0),
                      child: FutureBuilder<String>(
                        future: _zutatenFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Container(
                              width: 200,
                              child: TextField(
                                controller: TextEditingController(text: snapshot.data),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0.0),
                      child: Text(
                        'Zubereitung:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<String>(
                      future: _zubereitungFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Container(
                            width: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: TextEditingController(text: snapshot.data),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 16),
                                //Definiert Textfelder (welche aus der Datenbank befüllt werden) und dazugehörige Titel
                                ElevatedButton(
                                  onPressed: _goBack,
                                  child: Text('Zurück zu allen Suchergebnissen'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orangeAccent
                                  ),

                                ),
                                //Definiert Funktion und Aussehen des Zurück-Buttons
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      //Definition aller Inhalte und Bilder
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
            //Button zum Erstellen eigener Rezepte hin
          ],
        ),
      ),
    );
  }
}
