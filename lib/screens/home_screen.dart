// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, use_build_context_synchronously

import 'package:EchoVision/screens/map_screen.dart';
import 'package:EchoVision/services/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:EchoVision/screens/img_recognizer.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    TTS().speak(
        text:
            'Welcome to Blind Assist, long press on the screen to listen to available options');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blind Assist',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
            onPanUpdate: (details) async {
              // Swiping in right direction.
              // if (details.delta.dx > 0) {
              //   TTS().speak(text: 'Opening remainder screen');
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => RemainderScreen()));
              // }

              // Swiping in left direction.
              if (details.delta.dx < 0) {
                TTS().speak(text: 'Opening Map Screen');
                final status = await Permission.location.request();
                if (status.isGranted) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Location services are disabled. Please enable the services')));
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapScreen()));
              }
            },
            child: InkWell(
              onLongPress: () {
                TTS().speak(
                    text:
                        'single tap on the screen for currency identifier, , double tap on the screen for expity finder,, swipe left on the screen for map screen');
              },
              onDoubleTap: () {
                TTS().speak(
                    text: "Opening Image Recognizer for Currency Identifier");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImgRocog(isMedicine: true)));
              },
              onTap: () {
                TTS().speak(
                    text: "Opening Image Recognizer for Expiry Date Finder");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImgRocog(isMedicine: false)));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                      child: Text('Welcome to Blind Assist',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)))),
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          // Mic(
          //   isMap: false,
          // ),
        ],
      ),
    );
  }
}
