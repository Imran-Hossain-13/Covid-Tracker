import 'dart:convert';
import 'dart:io';

import 'package:covid_tracker/Modal/world_state_madal.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class WorldStateService{

  Future<WorldStateModal> fetchWorldStateRecord()async{
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStateModal.fromJson(data);
    }else{
      throw Exception("An error occurred");
    }
  }

  var data;
  Future<List<dynamic>> fetchWorldName()async{
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("An error occurred");
    }
  }
}