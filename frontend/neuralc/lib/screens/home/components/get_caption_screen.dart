import 'package:flutter/material.dart';
import 'package:neuralc/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GetCaption extends StatefulWidget {
  final String caption;
  final bool progress;

  const GetCaption({Key key, this.caption, this.progress}) : super(key: key);

  @override
  _GetCaptionState createState() => _GetCaptionState();
}

class _GetCaptionState extends State<GetCaption> {
  final flutterTts = FlutterTts();

  Future _speak() async{
    await flutterTts.speak(widget.caption);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.progress
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 6,
                      // backgroundColor: kPrimaryColor,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Generating Caption",
                      style: TextStyle(
                        color: kPrimaryColor,
                        letterSpacing: 2.0,
                        fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                )
              ],
            )
          : buildColumnWithSpeak(),
    );
  }

  Column buildColumnWithSpeak() {
    _speak();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  widget.caption,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
           SizedBox(height: 20,),
            FlatButton(
              color: kPrimaryColor,
              child: Icon(
                Icons.play_arrow_rounded,
                size: 40,
              ),
              onPressed: _speak,
            ),
          ],
        );
  }
}
