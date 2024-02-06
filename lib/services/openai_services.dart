// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<dynamic> fetchCompletions(String text) async {
    print("fetchCompletions called");
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            'role': 'system',
            'content':
                'You are a person who identifies the expiry date of a medicine from the given text, and tell only in words',
          },
          {
            'role': 'user',
            'content':
                "$text in the above given text,identify and tell me  the expiry month and the year in the form of words.. If there is no trace of expiry date then say no expiry date.the response should only be either the exipiry date or no expiry date,",
          }
        ],
      }),
    );
    print('status code is ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      String content = data["choices"][0]["message"]["content"];
      print(content); // Output: No expiry date.
      return content;
    } else {
      return response.statusCode.toString();
    }
  }

  Future<String> getResponse(
      {required String text, required bool isMedicine}) async {
    try {
      if (isMedicine) {
        print("function called");

        String responseMap = await fetchCompletions(text);

        return responseMap;
      } else {
        return "Currency not found";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> fetchExpiry(String url) async {
    print("fetchCompletions called");
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: jsonEncode({
        "model": "gpt-4-vision-preview",
        "messages": [
          {
            'role': 'system',
            'content':
                'You are a person who identifies the expiry date of a medicine from the given image and read out to a blind person',
          },
          {
            'role': 'user',
            'content': [
              {
                'type ': 'text',
                'text':
                    'Identify the expiry date of the medicine from the given image and read out to a blind person',
              },
              {
                'type': 'image',
                'image': {'url': url}
              }
            ]
          }
        ],
        'max_tokens': 300,
      }),
    );
    print('status code is ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      String content = data["choices"][0]["message"]["content"];
      print(content); // Output: No expiry date.
      return content;
    } else {
      return response.statusCode.toString();
    }
  }
}
