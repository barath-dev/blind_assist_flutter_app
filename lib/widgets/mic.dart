// ignore_for_file: avoid_unnecessary_containers

import 'package:EchoVision/services/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Mic extends StatefulWidget {
  final bool isMap;
  const Mic({super.key, required this.isMap});

  @override
  State<Mic> createState() => _MicState();
}

class _MicState extends State<Mic> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;

  String _lastWords = '';

  @override
  void initState() {
    TTS().speak(
        text: 'Map Screen opened press the green button to start speaking');
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
        onStatus: (status) {
          print(status);
        },
        onError: (error) {
          print(error);
        },
        finalTimeout: const Duration(seconds: 20));
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    widget.isMap ? TTS().speak(text: "destination set to $_lastWords") : null;
    widget.isMap
        ? TTS().speak(text: "press the white button to start navigation")
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: InkWell(
                onTap: () {
                  MapsLauncher.launchQuery(_lastWords);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: const Center(
                    child: Text("Start Map",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ))),
        const SizedBox(height: 20),
        Text(
          "Destination : $_lastWords",
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: _speechEnabled ? _startListening : _stopListening,
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'Start \n speaking',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: _speechEnabled ? _stopListening : null,
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                        child: Text(
                      'Stop \nspeaking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
