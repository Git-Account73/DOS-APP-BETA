import 'dart:math';

import 'package:flutter/material.dart';

import 'package:test_test/class1.dart';

import 'package:test_test/constants.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomeScreen(title: 'Flutter Projekt'),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _counter = 0;
  HandStack hand01 = new HandStack();
  static DrawStack drawStack = new DrawStack();
  DiscardStack discardStack = new DiscardStack(drawStack);


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  List<GestureDetector> _UI_HandGenerieren(List<Card_Neu> Hand)
  {
    List <GestureDetector> UI_Elemente = List<GestureDetector>.empty(growable: true);
    Hand.forEach((Data_Karte)
    {
      /*ClipRect Rect = ClipRect(
        child:*/ GestureDetector UI_Karte = GestureDetector(
          onTap: (){
            setState(() {
              Data_Karte.action(drawStack,discardStack, hand01, context);
            }
            );
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
        //)
      );
    UI_Elemente.add(UI_Karte);
    });
    return UI_Elemente;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
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
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  _handObjekteGenerieren(_handGenerieren(_counter))
              ),*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods
    );
  }

  /*List<Karte> Hand = List<Karte>.empty(growable: true);

  List<Widget> Karten(limit) {
    List<Widget> list = List.empty(growable: true);
    //i<5, pass your dynamic limit as per your requirment
    Hand.forEach((Instanz) {
    list.add(Text("$Instanz.GetFarbe() $limit"));//add any Widget in place of Text("Index $i")
    });
    Hand.add(Karte("www",'9'));
    return list;
    list; // all widget added now retrun the list here
  }*/
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => GamePage(title: "Uno",))
                   );
               },
                child: const Text('Spiel starten')
            ),
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
