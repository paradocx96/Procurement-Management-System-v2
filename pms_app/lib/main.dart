import 'package:flutter/material.dart';
import 'package:pms_app/modules/inventory/screens/CountableItemSingleView.dart';
import 'package:pms_app/modules/inventory/screens/CountableItems.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Procurement Management App'),
      routes: {
        CountableItems.routeName: (context) => const CountableItems(),
        CountableItemSingleView.routeName: (context) => const CountableItemSingleView(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, CountableItems.routeName,
                );
              },
              child: Container(
                height: 50,
                width: 300,
                child: Card(
                  color: Colors.teal,
                    child: Center(child: Text("Countable Items",
                      style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, CountableItems.routeName,
                );
              },
              child: Container(
                height: 50,
                width: 300,
                child: Card(
                    color: Colors.green,
                    child: Center(child: Text("Uncountable Items",
                      style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, CountableItems.routeName,
                );
              },
              child: Container(
                height: 50,
                width: 300,
                child: Card(
                    color: Colors.amber,
                    child: Center(child: Text("Orders",
                      style: TextStyle(fontSize: 20, color: Colors.black),))),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
