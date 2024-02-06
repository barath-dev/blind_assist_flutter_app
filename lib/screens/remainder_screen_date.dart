import 'package:blind_assist/services/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RemainderScreenDate extends StatefulWidget {
  const RemainderScreenDate({super.key});

  @override
  State<RemainderScreenDate> createState() => _RemainderScreenDateState();
}

class _RemainderScreenDateState extends State<RemainderScreenDate> {
  final SpeechToText _speechToText = SpeechToText();
  final title = TextEditingController();

  bool _speechEnabled = false;

  String _lastWords = '';

  @override
  void initState() {
    TTS().speak(
        text: 'On which date you want th remainder to be set');
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
    print(result.recognizedWords);
    setState(() {
      _lastWords = result.recognizedWords;
      title.text = _lastWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remainder'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          const Text(
            'Set Remainder',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: title,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
          Spacer(),
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
                  onTap: (){},
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
      ),
    );
  }
}
