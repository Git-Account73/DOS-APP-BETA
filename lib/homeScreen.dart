import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dos.dart';

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
