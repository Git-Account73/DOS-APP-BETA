import 'dart:math';
import 'package:flutter/material.dart';
import 'dos.dart';

// Eine Klasse für die Elemente der Karten
class Card_Neu {
  Color? color;
  int? number;
  // Initialiesieren einer Karte
  // mit einer Frarbe und einer Zahl als wert
  Card_Neu(Color? c, int n) {
    color = c;
    number = n;
  }

  // Wird ausgeführt wenn die Karte ausgespilet wird
  // zurzeit nur das überprüfen ob Krte gespielt werden darf
  // in Zukunft auch das Ziehen von extra Karten
  bool action(DrawStack ds,DiscardStack dis, HandStack hand, BuildContext context, int currentPlayer){
    // Darf die Karte gespielt werden ?
    if(dis.lastCard().color != color){
      if(dis.lastCard().number != number){
        return false;
      }
    }

    // Spiele Karte Aus
    hand.cardIsPlayed(this, context, currentPlayer);
    dis.play(this);
    return true;
  }
}

// klasse von der die anderen Karten Stabel erben
abstract class CardsStack{
  List<Card_Neu> cards = <Card_Neu>[];
}

// Karten Stappel von dem Während des Spiels gezogen werden soll
class DrawStack extends CardsStack {
  // Wird zu beginn mit den 72 Start Karten gefüllt
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

  // Methode zum ziehen von Karten aus dem Stappel
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

  // Nimm alle Karten aus dem Ablege Stappel zurück in den Ziehe Stappel
  void shAdd(CardsStack discard) {
    cards.addAll(discard.cards);

  }
}

// Klasse für den Ablage Stappel auf den Karten gespielt werden sollen
class DiscardStack extends CardsStack{
  //Zu beginn wird eine Zufällige Karte auf den Ablage Stappel gelegt
  DiscardStack(DrawStack dr){
    dr.draw(this);
  }
  // Methode für das legen von Karten auf den Ablage Stappel
  void play (Card_Neu card){
    cards.add(card);
  }
  //gibt die oberste Karte vom Stappel zurück
  Card_Neu lastCard() {
    return cards.last;
  }
}

// Classe für das Speichern der Handkarten von Spielern und Bots
class HandStack extends CardsStack{
  // Zu beginn wird eine bestimmte Anzahl an Karte auf die Hand genommen
  HandStack(DrawStack dr,int anz){
    for(int x = 0; x <= anz; x++){
      dr.draw(this);
    }
  }

  // Methode für das Spielen von KArten von der Hand
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

  // gibt alle Karten auf der Hand zurück um diese auf dem Monitor anzuzeigen
  List<Card_Neu> seeHand(){
    return cards;
  }

  // gibt die Anzahl der Handkarten zurück
  int amountCards()
  {
    return cards.length;
  }
}
