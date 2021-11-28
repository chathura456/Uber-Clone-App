import 'package:geolocator/geolocator.dart';
import 'package:rider_app/Assistants/requestAssistant.dart';

class AssistantMethods
{
  static Future<String> searchCoordinateAddress(Position position) async
  {
    String  placeAddress = "";
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyCvKoZ_rP9ZMpIlkQMPxRfWDSMtqQJ4muE";

    var response = await RequestAssistant.getRequest(Uri.parse(url));

    if(response != "failed")
      {
        placeAddress = response["results"][0]["formatted_address"];
      }
    return placeAddress;
  }
}