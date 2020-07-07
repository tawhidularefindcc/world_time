import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location, time, flag, url;
  bool isDaytime; // true or false if day time or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async{


    try  {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get data from properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);;

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time  = DateFormat.jm().format(now);
    }
    catch(e){
      print('Caught error: $e');
      time = 'could not find time data';
    }
  }
}

