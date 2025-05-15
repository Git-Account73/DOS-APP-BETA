import 'dart:math';

import 'package:flutter/material.dart';

class Card_Neu {
  Color? color;
  int? number;

  Card_Neu(Color? c, int n) {
    color = c;
    number = n;
  }

  bool action(DiscardStack dis, HandStack hand){
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
  List<Card_Neu> cards = <Card_Neu>[];
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
      cards.add(Card_Neu(col[j], num));
    }
    cards.shuffle();
  }

  void draw(CardsStack CS) {
    if (cards.isEmpty){
      return;
    }
    int count = Random().nextInt(cards.length - 1);
    Card_Neu drawnCard = cards[count];

    cards.remove(drawnCard);

    CS.cards.add(drawnCard);
  }

  void shAdd(CardsStack discard) {
    cards.addAll(discard.cards);
  }
}

class DiscardStack extends CardsStack{
  DiscardStack(DrawStack dr){
    dr.draw(this);
  }
  void play (Card_Neu card){
    cards.add(card);
  }

  Card_Neu lastCard() {
    return cards.last;
  }
}

class HandStack extends CardsStack{
  void cardIsPlayed(Card_Neu card){
    cards.remove(card);
  }

  List<Card_Neu> seeHand(){
    return cards;
  }
}
