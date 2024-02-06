// ignore_for_file: avoid_print

import 'dart:io';

import 'package:blind_assist/services/gemini_service.dart';
import 'package:blind_assist/services/tts_service.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String text;
  final File image;
  final bool isMedicine;
  const ResultScreen(
      {super.key,
      required this.text,
      required this.isMedicine,
      required this.image});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String result = "Loading...";
  void _getMedicine() async {
    result =await GeminiService().expiryFinder(widget.image);
    TTS().speak(text: result);
  }

  Future<String> _getCurrency() async {
    result =await GeminiService().currencyFinder(widget.image);
    return result;
  }

  @override
  void initState() {
    super.initState();
    if (widget.isMedicine) {
      _getMedicine();
    } else {
      _getCurrency().then((value) => setState(() {
            result = value;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result Screen'),
        ),
        body: SafeArea(
          child: Center(
            child: Text(result,
                style: const TextStyle(fontSize: 30, color: Colors.white)),
          ),
        ));
  }
}
