import 'package:flutter/material.dart';

import 'game.dart';

class QuestionPage extends StatefulWidget {

  final List<String> suspects;
  final List<String> weapons;
  final List<String> rooms;
  final List<Player> players;

  const QuestionPage({Key? key, required this.title, required this.suspects, required this.weapons, required this.rooms, required this.players}) : super(key: key);

  final String title;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  String? person;
  String? weapon;
  String? room;

  List<String?> playerResponses = List.filled(6, null);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(

          children: <Widget>[
            Expanded(
              flex: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New Question",
                        textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Suspect",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                          hint: const Text('Select'),
                          value: person,
                          onChanged: (String? value) {
                            setState(() {
                              person = value!;
                            });
                          },
                          items: widget.suspects
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Weapon",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                          hint: const Text('Select'),
                          value: weapon,
                          onChanged: (String? value) {
                            setState(() {
                              weapon = value!;
                            });
                          },
                          items: widget.weapons
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Room",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                          hint: const Text('Select'),
                          value: room,
                          onChanged: (String? value) {
                            setState(() {
                              room = value!;
                            });
                            },
                          items: widget.rooms
                                .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 40,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Player Responses",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5
                        ),
                      ),
                    ],
                  ),
                ] + buildRowForms(),
              ),
            ),
            Expanded(
                flex: 20,
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: _submitQuestion,
                        child: const Text("Submit")
                    ),
                  ],
                ),
            ),

          ]
        )

      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _submitQuestion(){
    int? questioner;
    List<int> answeredNo = [];
    int? answerer;

    //TODO: Add pop up that a person, weapon, and room must be selected
    if (person == null || weapon == null || room == null) return;
    Set<String> cards = {person!, weapon!, room!};

    for(int i = 0; i < widget.players.length; i++){
      switch(playerResponses[i]){
        case 'Questioner':
          //TODO: Only one questioner can be selected
          if (questioner != null) return;
          questioner = i;
          break;
        case 'Answered':
          //TODO: Only one player can answer
          if (answerer != null) return;
          answerer = i;
          break;
        case 'No Card':
          answeredNo.add(i);
          break;
        default:
          break;
      }
    }

    //TODO: Ensure a questioner is given
    if (questioner == null) return;

    Navigator.pop(
      context, Question(cards, questioner, answeredNo, answerer)
    );
  }

  List<Widget> buildRowForms(){
    List<Widget> formList = [];

    int length = (widget.players.length % 2 == 0) ? widget.players.length : widget.players.length - 1;

    for(int i = 0; i < length;) {
      formList += [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildDropdownButton(i),
            buildDropdownButton(i+1),
          ],
        )
      ];
      i += 2;
    }

    if (widget.players.length % 2 == 1) {
      formList += [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildDropdownButton(widget.players.length-1),
          ],
        )
      ];
    }
    return formList;
  }


  Container buildDropdownButton(index) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: DropdownButton(
              borderRadius: BorderRadius.circular(5.0),
              hint: Text(widget.players[index].name),
              value: playerResponses[index],
              onChanged: (String? value) {
                setState(() {
                  playerResponses[index] = value!;
                });
                },
              items: <String>['Questioner', 'Answered', 'No Card', 'Not Asked']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
          ),
        ),
    );
  }
}