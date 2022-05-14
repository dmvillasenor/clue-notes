import 'package:flutter/material.dart';

import 'Scorecard.dart';
import 'game.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  Playset playset = Playset(PlaysetType.unitedStates);
  final List<TextEditingController> _textControllers = [
    TextEditingController(), TextEditingController(), TextEditingController(),
    TextEditingController(), TextEditingController(), TextEditingController(),];
  final List<bool> _displayTextField = [false, false, false, false, false];
  List<Player> players = [];
  int addPlayers = 0;
  bool _buttonVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Text("Enter player initials",
                    style: Theme.of(context).textTheme.headline6
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white
                  ),
                  controller: _textControllers[0],
                )
              ),
              Visibility(
                visible: _displayTextField[0],
                child: Padding(
                    padding: const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white
                      ),
                      controller: _textControllers[1],
                    )
                ),
              ),
              Visibility(
                visible: _displayTextField[1],
                child: Padding(
                    padding: const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white
                      ),
                      controller: _textControllers[2],
                    )
                ),
              ),
              Visibility(
                visible: _displayTextField[2],
                child: Padding(
                    padding: const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white
                      ),
                      controller: _textControllers[3],
                    )
                ),
              ),
              Visibility(
                visible: _displayTextField[3],
                child: Padding(
                    padding: const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white
                      ),
                      controller: _textControllers[4],
                    )
                ),
              ),
              Visibility(
                visible: _displayTextField[4],
                child: Padding(
                    padding: const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white
                      ),
                      controller: _textControllers[5],
                    )
                ),
              ),
              Visibility(
                visible: _buttonVisibility,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if(addPlayers >= 5) {
                          _buttonVisibility = false;
                          return;
                        }
                        _displayTextField[addPlayers] = true;
                      });
                      addPlayers += 1;
                      if(addPlayers >= 5) {
                        _buttonVisibility = false;
                      }
                    },
                    child: const Icon(
                        Icons.plus_one,
                      color: Colors.black,
                    )
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    List<Player> players = [];

                    for(int i = 0; i < (addPlayers+1); i++){
                      players.add(Player(_textControllers[i].text, [...playset.allCards]));
                    }

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>
                          MyHomePage(title: "Clue Notes",
                            players: players,
                            playset: playset,
                          )
                      )
                    );
                  },
                  child: const Text(
                      "Start Game",
                    style: TextStyle(color: Colors.black)
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}