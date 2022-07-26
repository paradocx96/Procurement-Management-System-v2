import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pms_app/modules/inventory/models/CountableItemsModel.dart';

const BASE_URL = "http://192.168.1.7:5000/api/inventory/countable/";

Future<CountableItemsModel> fetchCountableItemById(id) async{
  final response =
  await http.get(Uri.parse
    (BASE_URL + "getCountableItemById/"+id));

  if(response.statusCode == 200){
    return CountableItemsModel.fromjson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to fetch countable item');
  }
}

Future <List<CountableItemsModel>> fetchAllCountableItems() async{
  final response =  await http.get(Uri.parse(BASE_URL + "getAllCountableItems"));

  if(response.statusCode == 200){
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => new CountableItemsModel.fromjson(e)).toList();
  }
  else{
    throw Exception('Failed to fetch all countable items');
  }
}

Future<String> consumeCountableItem(String id, int consumedQuantity) async{
  final response =  await http.put(Uri.parse(BASE_URL + "consumeItem"),
  headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
    body: jsonEncode(<String, dynamic> {
      'id' : id,
      'quantity': consumedQuantity
    })
  );

  if(response.statusCode == 200){
    return "success" ;
    //return true;
  }
  else{
    throw Exception('Failed to update quantity');
  }

}

Future<String> replenishCountableItem(String id, int replenishedQuantity) async{
  final response =  await http.put(Uri.parse(BASE_URL + "replenishItem"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic> {
        'id' : id,
        'quantity': replenishedQuantity
      })
  );

  if(response.statusCode == 200){
    //return response.body;
    return "success";
  }
  else{
    throw Exception('Failed to update quantity');
  }

}