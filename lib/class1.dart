import 'dart:math';
import 'package:flutter/material.dart';
import 'dos.dart';

class Card_Neu {
  Color? color;
  int? number;

  Card_Neu(Color? c, int n) {
    color = c;
    number = n;
  }

  bool action(DrawStack ds,DiscardStack dis, HandStack hand, BuildContext context, int currentPlayer){
    if(dis.lastCard().color != color){
      if(dis.lastCard().number != number){
        return false;
      }
    }

    hand.cardIsPlayed(this, context, currentPlayer);
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
      if(num > 9){
        num = 1;
        j++;
      }
      cards.add(Card_Neu(col[j], num));
      cards.add(Card_Neu(col[j], num));
      num++;
    }
    cards.shuffle();
  }

  bool draw(CardsStack cs) {
    if (cards.isEmpty){
      return true;
    }
    int count = Random().nextInt(cards.length - 1);
    Card_Neu drawnCard = cards[count];

    cards.remove(drawnCard);

    cs.cards.add(drawnCard);
    return false;
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
  HandStack(DrawStack dr, int anz){
    for(int x = 0; x < anz; x++){
      dr.draw(this);
    }
  }

  @override
  void cardIsPlayed(Card_Neu card, BuildContext context, int currentPlayer){
    cards.remove(card);
    if(cards.isEmpty){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EndScreen(ausgang: currentPlayer == 1 ? "Gewonnen" : "Verloren",))
      );
    }
  }

  List<Card_Neu> seeHand(){
    return cards;
  }

  int amountCards()
  {
    return cards.length;
  }
}
