import 'dart:convert';
import 'dart:io';

import 'package:assignment/modals/college.dart';
import 'package:http/http.dart' as http;
import 'package:assignment/Cache/AutoCompletionData.dart';

class ApiForAutoCompletingLocationField{

     static void loadTheEntriesForAutoCompletion()async{
        var client= http.Client();
        final response = await client.get(Uri.parse("http://universities.hipolabs.com/search?name=middle"
            ));
        print("Got The Response");
        if(response.statusCode == 200){

            final json = jsonDecode(response.body);
            for(var college in json){
                var entry = College.fromJson(college);
                print(entry.name);
                li.add(entry);
            }


        }

  }
}