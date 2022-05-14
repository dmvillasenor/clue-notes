import 'package:clue_notes/question_page.dart';
import 'package:clue_notes/settings_page.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.players, required this.playset}) : super(key: key);

  final String title;

  final List<Player> players;
  final Playset playset;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<Question> questions = [];

  void _changeScreen(int index) {
    if (index == 0){
      _settingsScreen();
    }
    else if (index == 1){
      _questionScreen();
    }

  }

  void _questionScreen() async {
    Question? question = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            QuestionPage(title: "Question Page",
                suspects: widget.playset.suspects, weapons: widget.playset.weapons, rooms: widget.playset.rooms,
                players: widget.players
            ))
    );

    if (question == null) return;

    questions.add(question);

    for(int i in question.answeredNo) {
      widget.players[i].questionsAnswered.add(question);
      
      for(String c in question.cards) {
        if(!widget.players[i].possibleCards.contains(c)) continue;

        widget.players[i].possibleCards.remove(c);
        setState(() {
          widget.players[i].dict_cards[c] = const Icon(Icons.close);
        });
      }
    }
    
    if (question.answerer == null) return;

    widget.players[question.answerer!].questionsAnswered.add(question);
    for(String c in question.cards) {

      if (!widget.players[question.answerer!].possibleCards.contains(c) || widget.players[question.answerer!].cards.contains(c)) continue;
      Text textWidget = widget.players[question.answerer!].dict_cards[c];

      widget.players[question.answerer!].dict_cards[c] = Text(textWidget.data! + " ${widget.players[question.answerer!].questionsAnswered.length}");
    }

  }

  void _settingsScreen() async {
    var result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SettingsPage(title: "Settings Page", players: widget.players))
    );

    if (result == null) return;

    for (int i = 0; i < result.length; i++) {
      if(result[i] == "") continue;
      setState(() {
        widget.players[i].name = result[i];
      });
    }

  }

  List<TableRow> generateTable(){

    List<TableRow> tableRows = [];

    List<TableCell> headerCells = [
      const TableCell(
        child: Text(""),
      )
    ];

    for (Player p in widget.players) {
      headerCells += [
        TableCell(
          child: Text(p.name, textAlign: TextAlign.center, softWrap: false,),
          verticalAlignment: TableCellVerticalAlignment.middle,
        )
      ];
    }

    tableRows += [
      TableRow(
        decoration: const BoxDecoration(color: Colors.blueGrey),
        children: headerCells,
      ),
    ];

    for (String c in widget.playset.allCards) {
      List<TableCell> cardCells = [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Text(c, textAlign: TextAlign.center),
          ),
          verticalAlignment: TableCellVerticalAlignment.middle,
        ),
      ];

      for(Player p in widget.players) {
        //TODO: Add button to switch text
        cardCells += [
          TableCell(
            child: TextButton(
               style: TextButton.styleFrom(
                 primary: Colors.black
               ),
                onPressed: () {
                  if (!p.possibleCards.contains(c)) return;

                  //p.possibleCards.remove(c);
                  setState(() {
                    p.dict_cards[c] = const Icon(Icons.close);
                  });
                },
                onLongPress: () {
                  //p.possibleCards.remove(c);
                  p.cards.add(c);
                  setState(() {
                    p.dict_cards[c] = const Icon(Icons.check);
                  });
                },
                child: p.dict_cards[c],
            ),
          ),
        ];
      }

      tableRows += [
        TableRow(
            children: cardCells,
            decoration: BoxDecoration(
              color: widget.playset.suspects.contains(c) ? Colors.blue[100] : widget.playset.weapons.contains(c) ? Colors.red[100] : Colors.green[100]
            )
        )
      ];
    }

    return tableRows;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                },
                border: TableBorder.all(),
                children: generateTable(),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: "Question",
          ),
        ],
        onTap: _changeScreen,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}