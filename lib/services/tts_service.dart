import 'package:flutter_tts/flutter_tts.dart';

class TTS {
  FlutterTts flutterTts = FlutterTts();

  void speak({required String text}) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.4);

    await flutterTts
        .setVoice({'locale': 'en-IN', 'name': 'en-in-x-end-network'});
    await flutterTts.speak(text);
  }
}
