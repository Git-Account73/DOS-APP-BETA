import 'dart:math';

import 'package:flutter/material.dart';

class Card {
  Color? color;
  int? number;

  Card(Color? c, int n) {
    color = c;
    number = n;
  }

  bool aktion(DiscardStack dis, HandStack hand){
    if(dis.lastCard().color != color){
      if(dis.lastCard().number != number){
        return false;
      }
    }

    hand.cardIsPlayed(this);
    dis.play(this);
    return true;
  }
}

abstract class CardsStack{
  List<Card> cards = <Card>[];
}

class DrawStack extends CardsStack {
  DrawStack () {
    List<Color?> col = <Color?>[Colors.red, Colors.blue, Colors.green, Colors.yellow];
    int num = 1;
    int j = 0;
    for(int i = 0; i < 36; i++){
      if(num > 8){
        num = 1;
        j++;
      }
      cards.add(Card(col[j], num));
    }
    cards.shuffle();
  }

  Card? draw() {
    if (cards.isEmpty){
      return null;
    }
    int count = Random().nextInt(cards.length - 1);
    Card drawnCard = cards[count];

    cards.remove(drawnCard);

    return drawnCard;
  }

  void shAdd(CardsStack discard) {
    cards.addAll(discard.cards);
  }
}

class DiscardStack extends CardsStack{
  void play (Card card){
    cards.add(card);
  }

  Card lastCard() {
    return cards.last;
  }
}

class HandStack extends CardsStack{
  void cardIsPlayed(Card card){
    cards.remove(card);
  }

  List<Card> seeHand(){
    return cards;
  }
}