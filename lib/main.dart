import 'package:clue_notes/game.dart';
import 'package:clue_notes/game_setup_page.dart';
import 'package:flutter/material.dart';
import 'Scorecard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: const MenuPage(title: 'Clue Notes - Menu Page'),
    );
  }
}



class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Playset playset = Playset(PlaysetType.unitedStates);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 50,
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Clue Notes",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 55,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) =>
                                  const SetupPage(title: "Game Setup"),
                              )
                          );
                        },
                        child: Text(
                            "New Game",
                          style: Theme.of(context).textTheme.headline5
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {}
                        ,
                        child: Text(
                            "Load Game",
                            style: Theme.of(context).textTheme.headline5
                        )
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}