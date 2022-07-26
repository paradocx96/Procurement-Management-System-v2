import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:pms_app/modules/inventory/models/CountableItemsModel.dart';
import 'package:pms_app/modules/inventory/routes/CountableItemSWArguments.dart';
import 'package:pms_app/utils/services/CountableItemService.dart' as CountableItemService;

class CountableItemSingleView extends StatefulWidget {
  const CountableItemSingleView({Key? key}) : super(key: key);

  static const routeName = "/inventory/countable/singleView";

  @override
  _CountableItemSingleViewState createState() => _CountableItemSingleViewState();
}

class _CountableItemSingleViewState extends State<CountableItemSingleView> {

  late Future<CountableItemsModel> futureCountableItem;



  @override
  void initState() {
    super.initState();
    //initiateFuture();
    //final args = ModalRoute.of(context)!.settings.arguments as CountableItemSWArguments;
    //futureCountableItem = CountableItemService.fetchCountableItemById(args.id);
  }

  void initiateFuture(){
    final args = ModalRoute.of(context)!.settings.arguments as CountableItemSWArguments;

    futureCountableItem = CountableItemService.fetchCountableItemById(args.id);

    /*setState(() {
      futureCountableItem = CountableItemService.fetchCountableItemById(args.id);
    });*/

  }

  Future<void> showConsumed(){
    return showDialog<void>(context: context,
        builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Item updated"),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget> [
              Text("Items has been consumed"),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          },
              child: const Text("OK")
          )
        ],
      );
        }
    );
  }


  Future<void> showReplenished(){
    return showDialog<void>(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Item updated"),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget> [
                  Text("Items has been replenished"),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  child: const Text("OK")
              )
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {

    final _text = TextEditingController();
    late Future<String> resultConsume;
    late Future<String> resultReplenish;

    final args = ModalRoute.of(context)!.settings.arguments as CountableItemSWArguments;
    futureCountableItem = CountableItemService.fetchCountableItemById(args.id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Countable Item Single View"),
      ),
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: FutureBuilder<CountableItemsModel>(
                future: futureCountableItem,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return Container(
                      height: 700,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text("Id",style: TextStyle(fontSize: 25),),
                              Text(snapshot.data!.id,style: TextStyle(fontSize: 20),),
                              Spacer(),
                              Text("Name",style: TextStyle(fontSize: 25),),
                              Text(snapshot.data!.name,style: TextStyle(fontSize: 20),),
                              Spacer(),
                              Text("Type",style: TextStyle(fontSize: 25),),
                              Text(snapshot.data!.type,style: TextStyle(fontSize: 20),),
                              Spacer(),
                              Text("Quantity",style: TextStyle(fontSize: 25),),
                              Text(snapshot.data!.quantity.toString(),style: TextStyle(fontSize: 20),),
                              Spacer(),
                              Text("Minimum Quantity",style: TextStyle(fontSize: 25),),
                              Text(snapshot.data!.minimumQuantity.toString(),style: TextStyle(fontSize: 20),),
                              Spacer(),
                              Text("Site Id",style: TextStyle(fontSize: 25),),
                              Text(snapshot.data!.siteid,style: TextStyle(fontSize: 20),),
                              Spacer(),
                              Text("Site Name",style: TextStyle(fontSize: 25),),
                              Text(snapshot.data!.sitename,style: TextStyle(fontSize: 20),),
                              Spacer(),

                              TextField(

                                controller: _text,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Quantity',
                                  hintText: 'Enter quantity',
                                  //errorText: isValid? null : 'This cannot be empty'
                                ),

                              ),

                              ElevatedButton(onPressed: (){
                                resultConsume =
                                CountableItemService.consumeCountableItem(snapshot.data!.id,
                                    int.parse(_text.text))
                                .then( (e){
                                  print("received value: "+e);
                                  if(e == "success"){
                                    showConsumed();
                                  }
                                  return e;
                                });

                                /*if(resultConsume.toString().isNotEmpty){
                                  print(resultConsume.toString());
                                  print("consume result is true");
                                  showConsumed();
                                }*/
                              }, child: Text("Consume")),

                              ElevatedButton(onPressed: (){
                                resultReplenish = CountableItemService.replenishCountableItem(snapshot.data!.id,
                                    int.parse(_text.text))
                                    .then( (e){
                                  print("received value: "+e);
                                  if(e == "success"){
                                    showReplenished();
                                  }
                                  return e;
                                });


                              }, child: Text("Replenish")),

                              //resultConsume ==  "success" ?Text("data") : Container()
                            ],
                          ),
                        ),
                      ),

                    );
                  }
                  else if(snapshot.hasError){
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),

          ),
        ),
      ),
    );
  }
}
