import 'package:http/http.dart' as http;
import 'dart:convert';
class RequestAssistant
{

  static Future<dynamic> getRequest(Uri url) async
  {

    http.Response response = await http.get(url);

    try
        {
          if(response.statusCode == 200)
          {
            String jsconData = response.body;
            var decodeData = jsonDecode(jsconData);
            return decodeData;
          }
          else
          {
            return "failed";
          }
        }
        catch(exp)
        {
          return "failed";
        }
  }
}