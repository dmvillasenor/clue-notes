import 'package:flutter/material.dart';

import 'game.dart';

class SettingsPage extends StatefulWidget {

  const SettingsPage({Key? key, required this.title, required this.players}) : super(key: key);

  final String title;
  final List<Player> players;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<TextEditingController> _textControllers = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(

        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Change player initials",
                    style: Theme.of(context).textTheme.headline6)
              ] + buildNameForms() + [
                ElevatedButton(
                  onPressed: (){
                    var newNames = [];
                    for(TextEditingController t in _textControllers){
                      newNames.add(t.text);
                    }
                    Navigator.pop(
                      context, newNames
                    );
                  },
                  child: const Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> buildNameForms() {
    List<Widget> formList = [];

    int length = (widget.players.length % 2 == 0) ? widget.players.length : widget.players.length - 1;

    for(int i = 0; i < length;) {
      formList += [Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildNameForm(i),
            buildNameForm(i+1),
          ],
        ),
      )];
      i += 2;
    }

    if (widget.players.length % 2 == 1) {
      formList += [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildNameForm(widget.players.length-1),
            ],
          ),
        ),
      ];
    }

    return formList;
  }

  Expanded buildNameForm(int playerNumber) {
    _textControllers.add(TextEditingController());
    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllers[playerNumber],
                          decoration: InputDecoration(
                            labelText: widget.players[playerNumber].name,
                          ),
                        ),
                      ),
                    );
  }
}