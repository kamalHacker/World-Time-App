import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  late String time;
  String flag;
  String url;
  late bool isDayTime;

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async{
    try{
      //make the request
      String uriString = 'http://worldtimeapi.org/api/timezone/${this.url}';
      Uri url = Uri.parse(uriString);
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(
              hours: int.parse(offset.substring(1,3)),
              minutes: int.parse(offset.substring(4,6))
          )
      );
      print(now.hour);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time = 'Error -404, could not get time';
    }
  }

}