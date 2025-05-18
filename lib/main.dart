import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_test/class1.dart';
import 'package:test_test/constants.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomeScreen(title: 'Flutter Projekt'),
    );
  }
}


class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title}); //Hier zusätzliches Argument: Anzahl Startkarten

  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  HandStack hand01 = HandStack();
  static DrawStack drawStack = DrawStack();
  DiscardStack discardStack = DiscardStack(drawStack);

  List<GestureDetector> _UI_HandGenerieren(List<Card_Neu> Hand)
  {
    List <GestureDetector> UI_Elemente = List<GestureDetector>.empty(growable: true);
    Hand.forEach((Data_Karte)
    {
      GestureDetector UI_Karte = GestureDetector(
        onTap: (){
            setState(() {
              Data_Karte.action(drawStack, discardStack, hand01, context);
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
    });
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
                TODO: Anzahl Karten für Gegner
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
                        drawStack.draw(hand01);
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  width: CARD_WIDTH,
                  height: CARD_HEIGHT,
                  color: discardStack.lastCard().color,
                  child: Text(discardStack.lastCard().number.toString(), textAlign: TextAlign.center, textScaler: TextScaler.linear(5),),
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
                      itemCount: _UI_HandGenerieren(hand01.seeHand()).length,
                      itemBuilder: (BuildContext context, int index)
                      {
                       return (_UI_HandGenerieren(hand01.seeHand()))[index];
                      },
               )
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget
{
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => HomescreenState();
}

class HomescreenState extends State<HomeScreen>
{
  bool _textfieldempty = false;
  final _textControler = TextEditingController(text: '7',);

  @override
  void dispose() {
    _textControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                    maxLength: 2,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Anzahl Startkarten'),
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                    controller: _textControler,
                    onChanged: (String input){
                      if (_textControler.text == '')
                         {
                            _textfieldempty = true;

                         }
                      else
                        {
                          _textfieldempty = false;
                        }
                    },
                  )
                ),
                ElevatedButton(
                    onPressed: (){
                      if (_textfieldempty == false)
                        {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => GamePage(title: "TTTTTTTTTTTTTT",))
                         );
                        }
                      else
                        {null;}
                    },
                    child: const Text('Spiel starten')
                )
              ],
            )
        )
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
