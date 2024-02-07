import 'dart:io';

import 'package:google_gemini/google_gemini.dart';

class GeminiService {
  final gemini =
      GoogleGemini(apiKey: "AIzaSyBJJ7RNqGxaUzXmoiXVIbUVw0HFKhjgK0s");

  Future<String> currencyFinder(File image) async {
    late String res;
    await gemini
        .generateFromTextAndImages(
            query:
                "What is the denomination of currency? The response format should be: This is a [denomination] rupee note, if there is no currency fount the response should be: No currencies found",
            image: image)
        .then((value) => res = value.text)
        .catchError((e) => res = e.toString());
    return res;
  }

  Future<String> expiryFinder(File image) async {
    late String res;
    await gemini
        .generateFromTextAndImages(
            query:
                "What is the expiry date mentioned in the image? give the response in words, if there is no epiry date found in the image the response should be: No expiry date found",
            image: image)
        .then((value) => res = value.text)
        .catchError((e) => res = e.toString());
    return res;
  }
}
