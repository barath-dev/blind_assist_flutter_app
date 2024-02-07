// ignore_for_file: unused_field, unused_element, dead_code, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, no_logic_in_create_state, avoid_unnecessary_containers

import 'dart:io';

import 'package:EchoVision/resources/storagemethods.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:EchoVision/screens/result_screen.dart';
import 'package:EchoVision/services/tts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ImgRocog extends StatefulWidget {
  final bool isMedicine;
  const ImgRocog({super.key, required this.isMedicine});

  @override
  State<ImgRocog> createState() {
    return _ImgRocogState();
  }
}

class _ImgRocogState extends State<ImgRocog> with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;

  final _textRecognizer = TextRecognizer();

  Future<void> _requestCameraPermission() async {
    TTS().speak(
        text:
            "Camera permission have been requested please allow for proceeding for the feature");
    final status = await Permission.camera.request();
    _isPermissionGranted = status.isGranted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    _cameraController?.dispose();
    _cameraController = null;
  }

  void _initCameraContrller(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    //select the back camera
    CameraDescription? camera;

    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }
    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  late final String PATH;
  void setPath(path) {
    PATH = path;
  }

  String getPath() {
    return PATH;
  }

  Future<void> _scanImage() async {
    if (_cameraController == null) return;
    final navigator = Navigator.of(context);

    try {
      _cameraController?.setFlashMode(FlashMode.off);
      _cameraController?.setFocusMode(FocusMode.auto);
      final pictureFile = await _cameraController!.takePicture();
      // pictureFile.saveTo("/storage/emulated/temp/");

      final file = File(pictureFile.path);
      final url =
          await StorageMethods().uploadImagetoStorage(file.readAsBytesSync());

      await navigator.push(MaterialPageRoute(builder: (context) {
        return ResultScreen(
            text: url, isMedicine: widget.isMedicine, image: file);
      }));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
    );

    await _cameraController?.initialize();
    TTS().speak(text: "Press the green button to take a picture");

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopCamera();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (_cameraController != null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Stack(
            children: [
              //show the camera feed behind everything
              if (_isPermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                  future: availableCameras(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _initCameraContrller(snapshot.data!);

                      return Column(
                        children: [
                          Container(
                            color: Colors.blue,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: CameraPreview(_cameraController!),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              Scaffold(
                  appBar: AppBar(
                    title: Text(widget.isMedicine
                        ? 'Medicine Expiry Date'
                        : 'Currency Recognition'),
                  ),
                  backgroundColor:
                      _isPermissionGranted ? Colors.transparent : null,
                  body: _isPermissionGranted
                      ? Column(
                          children: [
                            Expanded(child: Container()),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.175,
                                padding: const EdgeInsets.only(bottom: 15),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(49, 123, 34, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    _scanImage();
                                  },
                                  child: const Text(
                                    'Take Picture',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                          ],
                        )
                      : Center(
                          child: Container(
                            child: const Text(
                              'Please grant camera permission to use this app',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ))
            ],
          );
        });
  }
}
