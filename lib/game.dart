import 'package:flutter/material.dart';

class Player {
  String name;
  List<String> cards = [];
  List<String> possibleCards;
  List<Question> questionsAnswered = [];
  var dict_cards = {};

  Player(this.name, this.possibleCards){
    for(String c in possibleCards) {
      dict_cards[c] = const Text("");
    }
  }

  addCard(String c) {
    cards.add(c);
  }

  removePossibleCard(String c){
    possibleCards.remove(c);
  }
}


class Playset {
  late final List<String> suspects;
  late final List<String> weapons;
  late final List<String> rooms;
  late final List<String> allCards;

  Playset(PlaysetType type){
    switch(type){
      case PlaysetType.unitedStates:
        suspects = ["Mr. Green",
          "Prof. Plum",
          "Col. Mustard",
          "Mrs. Peacock",
          "Ms. Scarlet",
          "Mrs. White"];
        weapons = ["Candlestick",
          "Knife",
          "Lead Pipe",
          "Revolver",
          "Rope",
          "Wrench"];
        rooms = ["Conservatory",
          "Lounge",
          "Kitchen",
          "Library",
          "Hall",
          "Study",
          "Ballroom",
          "Dining Room",
          "Billiard Room"];
        break;
      case PlaysetType.canada:
        suspects = [];
        weapons = [];
        rooms = [];
        break;
      case PlaysetType.uk:
        suspects = [];
        weapons = [];
        rooms = [];
        break;
      default:
        suspects = [];
        weapons = [];
        rooms = [];
        break;
    }
    allCards = suspects + weapons + rooms;
  }

}
enum PlaysetType {
  unitedStates,
  canada,
  uk
}

class Question {
  final Set<String> cards;
  final int questioner;
  final List<int> answeredNo;
  final int? answerer;

  Question(this.cards, this.questioner, this.answeredNo, this.answerer);
}

