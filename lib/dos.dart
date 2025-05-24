import 'package:flutter/material.dart';
import 'class1.dart';
import 'constants.dart';
import 'homeScreen.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title, required int maxSpieler})
    : maxPlayer = maxSpieler;

  //Hier zusätzliches Argument: Anzahl Startkarten

  final String title;
  final int maxPlayer;

  @override
  State<GamePage> createState() => GamePageState(maxSpieler: maxPlayer);
}

class GamePageState extends State<GamePage> {
  GamePageState({required int maxSpieler}) : maxPlayers = maxSpieler + 1;
  int currentPlayer = 1;
  final int maxPlayers;
  final HandStack _hand01 = HandStack();
  final HandStack _hand02 = HandStack();
  static final DrawStack _drawStack = DrawStack();
  final DiscardStack _discardStack = DiscardStack(_drawStack);

  void next(BuildContext context) {
    if (currentPlayer == 1) {
      currentPlayer = currentPlayer + 1;
    }
    for (
      currentPlayer;
      currentPlayer <= maxPlayers;
      currentPlayer = currentPlayer + 1
    ) {
      //Annahme: Nur 1 mensch. Spieler -> ist Spieler 1
      setState(() {
        bool played = false;
        for (var Karte in _hand02.seeHand()) {
          played = Karte.action(_drawStack, _discardStack, _hand02, context, 2);
          if (played == true) {
            break;
          }
        }
        if (played == false) {
          _drawStack.draw(_hand02);
        }
      });
    }
    currentPlayer = currentPlayer + 1;
    if (currentPlayer > maxPlayers) {
      currentPlayer = 1;
    }
  }

  //Erzeugt aus Kartenliste Liste aus UI-Elementen
  List<GestureDetector> _UI_HandGenerieren(List<Card_Neu> hand) {
    List<GestureDetector> UI_Elemente = List<GestureDetector>.empty(
      growable: true,
    );
    for (var Data_Karte in hand) {
      GestureDetector UI_Karte = GestureDetector(
        onTap: () {
          bool played = false;
          setState(() {
            if (currentPlayer == 1) {
              played = Data_Karte.action(
                _drawStack,
                _discardStack,
                _hand01,
                context,
                currentPlayer,
              );
            }
          });
          if (played == true) {
            next(context);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.black),
            color: Data_Karte.color,
          ),
          width: CARD_WIDTH,
          height: CARD_HEIGHT,
          child: Text(
            Data_Karte.number.toString(),
            textAlign: TextAlign.center,
            textScaler: TextScaler.linear(5),
          ),
        ),
      );
      UI_Elemente.add(UI_Karte);
    }
    return UI_Elemente;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.black38),
                  width: CARD_WIDTH / 2,
                  height: CARD_HEIGHT / 2,
                  child: Text(
                    _hand02.amountCards().toString(),
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(5 / 2),
                  ),
                ),
              ],
            ),
            Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    width: CARD_WIDTH,
                    height: CARD_HEIGHT,
                    color: Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      if (currentPlayer == 1) {
                        _drawStack.draw(_hand01);
                      }
                    });
                    next(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    color: _discardStack.lastCard().color,
                  ),
                  width: CARD_WIDTH,
                  height: CARD_HEIGHT,
                  child: Text(
                    _discardStack.lastCard().number.toString(),
                    textAlign: TextAlign.center,
                    textScaler: TextScaler.linear(5),
                  ),
                ),
              ],
            ),

            Spacer(flex: 1),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.horizontal,
                itemCount: _UI_HandGenerieren(_hand01.seeHand()).length,
                itemBuilder: (BuildContext context, int index) {
                  return (_UI_HandGenerieren(_hand01.seeHand()))[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EndScreen extends StatefulWidget {
  const EndScreen({super.key, required this.ausgang});

  final String ausgang;

  @override
  State<EndScreen> createState() => EndScreenState();
}

class EndScreenState extends State<EndScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.ausgang, textScaler: TextScaler.linear(10)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(title: "Flutter Projekt"),
                  ),
                );
              },
              child: Text('Noch mal?'),
            ),
          ],
        ),
      ),
    );
  }
}
