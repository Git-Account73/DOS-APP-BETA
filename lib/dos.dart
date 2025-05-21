import 'package:flutter/material.dart';
import 'class1.dart';
import 'constants.dart';
import 'homeScreen.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title}); //Hier zusätzliches Argument: Anzahl Startkarten

  final String title;

  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final HandStack _hand01 = HandStack();
  static final DrawStack _drawStack = DrawStack();
  final DiscardStack _discardStack = DiscardStack(_drawStack);

  //Erzeugt aus Kartenliste Liste aus UI-Elementen
  List<GestureDetector> _UI_HandGenerieren(List<Card_Neu> hand)
  {
    List <GestureDetector> UI_Elemente = List<GestureDetector>.empty(growable: true);
    for (var Data_Karte in hand) {
      GestureDetector UI_Karte = GestureDetector(
        onTap: (){
          setState(() {
            Data_Karte.action(_drawStack, _discardStack, _hand01, context);
          });
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all (
              width: 2,
              color: Colors.black,
            ),
            color:  Data_Karte.color,
          ),
          width: CARD_WIDTH,
          height: CARD_HEIGHT,
          child: Text(Data_Karte.number.toString(),textAlign: TextAlign.center,textScaler: TextScaler.linear(5)),
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
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*
                TODO: Anzahl Karten der Gegner zeigen
            */
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
                  onTap: (){
                    setState(() {
                      _drawStack.draw(_hand01);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  width: CARD_WIDTH,
                  height: CARD_HEIGHT,
                  color: _discardStack.lastCard().color,
                  child: Text(_discardStack.lastCard().number.toString(), textAlign: TextAlign.center, textScaler: TextScaler.linear(5),),
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
                  itemBuilder: (BuildContext context, int index)
                  {
                    return (_UI_HandGenerieren(_hand01.seeHand()))[index];
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}




class EndScreen extends StatefulWidget
{
  const EndScreen({super.key, required this.title});
  final String title;

  @override
  State<EndScreen> createState() => EndScreenState();
}

class EndScreenState extends State<EndScreen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("GEWONNEN",textScaler: TextScaler.linear(10),),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(title: "Flutter Projekt",))
                    );
                  },
                  child:  Text('Noch mal?')
              )
            ],
          ),
        )
    );
  }
}