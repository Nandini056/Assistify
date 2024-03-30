//what we are actually doing from speech to text therw will be an interface from where chatgpt come which will ask whether u want to use chatgpt or dall-e (for image)
import 'dart:convert';

import 'package:assistify/secrets.dart';
import 'package:http/http.dart' as http;
class OpenAIService{
  Future<String> isArtPromptAPI(String prompt) async{
    try {//all this from open ai site refrence key
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body:jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [{
            'role': 'user',
            'content': 'Does this message want to generate an AI picture,image, art or anything similiar? $prompt.Simply answer with ayes or no.',}
          ],
        }),
      );
      print(res.body);
      if(res.statusCode==200){
        print('yay');
      }
     return 'AI';

    }catch(e){
      return e.toString();
    }
  }// first chatgpt
  Future<String> chatGPTAPI(String prompt) async{
    return 'CHATGPT';
  }
  Future<String> dallEAPI(String prompt) async{
    return 'DALL-E';
  }

}