import 'package:flutter/material.dart';
import 'package:pms_app/modules/inventory/models/CountableItemsModel.dart';
import 'package:pms_app/modules/inventory/routes/CountableItemSWArguments.dart';
import 'package:pms_app/modules/inventory/screens/CountableItemSingleView.dart';
import 'package:pms_app/utils/services/CountableItemService.dart' as CountableItemService;

class CountableItems extends StatefulWidget {
  const CountableItems({Key? key}) : super(key: key);

  static const routeName = "/inventory/countable/viewAll";

  @override
  _CountableItemsState createState() => _CountableItemsState();
}

class _CountableItemsState extends State<CountableItems> {

  late Future<CountableItemsModel> futureCountableItem;
  late Future <List<CountableItemsModel>> countableItemList;


  @override
  void initState() {
    super.initState();
    futureCountableItem = CountableItemService.fetchCountableItemById("6156daa173f71c13132c33b7");
    countableItemList = CountableItemService.fetchAllCountableItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countable Items"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder<List<CountableItemsModel>>(
            future: countableItemList,
            builder: (context,snapshot){
              if(snapshot.hasData){
                List<CountableItemsModel>? data = snapshot.data;
                return ListView.builder(
                  itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, CountableItemSingleView.routeName,
                        arguments:CountableItemSWArguments(data![index].id)
                      );
                      print(data![index].id);
                      print(data![index].name);
                    },
                    title: Text(data![index].name),);
                }
                );
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
