import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup name generatorr',
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>(); //A set is better than a list as it will not allow duplicate entries!
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        /*
        This is called on each random word pair, it will place each suggestion onto a ListTile row, with even rows simply adding the word pairing
        Odd rows will add a divider to visually seperate the entities
        */
        if(i.isOdd) return Divider(); //This adds a one pixel high divider widget before each row in the list

        final index = i ~/2;  //THis divides i by 0 and returns an integer to calculate the actual number of words on in the list view minus the dividers
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10)); //Once at the end of the word pairings, we need to generate 10 more and add them to the suggestions list
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }
  Widget _buildRow(WordPair pair){
    final bool alreadySaved = _saved.contains(pair); //Check the word pairing has not already been added to favourites
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      //Add the icons to the end of each row, with a filled heart for selected ones and unfilled for an awaiting selection one
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null
      ),
      onTap: (){
        //Calling set state will trigger a call to build, triggering a UI refresh
        //This allows a tap to add/remove from the _saved set set for the UI to then refresh and display this change
        setState(() {
         if(alreadySaved){
           _saved.remove(pair);
         } 
         else{
           _saved.add(pair);
         }
        });
      },
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();

}