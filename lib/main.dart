import 'package:flutter/material.dart';

void main() => runApp(MyApp()); //Boiler plate to run the main widget builder

class MyApp extends StatelessWidget{
  //Create our main Widget for the app, it's stateless so it can't be changed
  @override
  //Create the main build method
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Testing 1,2",
      home: RandomWords(),
      );
  }
}

//Stateful widget, allowing us to change aspects
class RandomWords extends StatefulWidget{
  @override
  //Here we set the state controller
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{
  //This will control the state of the stateful widget
  final _word = "Cheese";
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _buildCheese(){
    return ListView.builder(
      //Helper method to create the listview
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i){
           if (i.isOdd) return Divider(); //Divider is a helper to create a divider!
           return _buildRow(_word); //We only have one word so once the odd/even is decided we want return our word
        },
    );
  }
  //Take the built listview element, output it to a listtile
  Widget _buildRow(String word){
    return ListTile(
      title: Text(
        word,
        style: _biggerFont,
      )
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          //Add our app bar title...
          title: Text("Cheese Outputer"),
        ),
        body: _buildCheese(),
    );
  }
}

