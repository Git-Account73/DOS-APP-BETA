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
  final _textKartenControler = TextEditingController(text: '7',);
  final _textKIsControler = TextEditingController(text: '1',);

  @override
  void dispose() {
    _textKartenControler.dispose();
    _textKIsControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 150,
                        child: TextField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                          maxLength: 1,
                          decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Anzahl KIs'),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                          controller: _textKIsControler,
                          onChanged: (String input){
                            if (_textKIsControler.text == '' || _textKartenControler.text == '')
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
                    SizedBox(
                        width: 150,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                          maxLength: 2,
                          decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Anzahl Startkarten'),
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                          controller: _textKartenControler,
                          onChanged: (String input){
                            if (_textKIsControler.text == '' || _textKartenControler.text == '')
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
                  ],
                ),
                ElevatedButton(
                    onPressed: (){
                      if (_textfieldempty == false)
                      {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => GamePage(title: "DOS", maxSpieler: int.parse(_textKIsControler.text), startkarten: int.parse((_textKartenControler.text))))
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
