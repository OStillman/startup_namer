import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup name generatorr',
      theme: ThemeData(
        primaryColor: Colors.green[700],
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>(); //A set is better than a list as it will not allow duplicate entries!
  final _biggerFont = const TextStyle(fontSize: 18.0);
  void _pushSaved(){
    //On the list button press we need to push a "route" (new page) to the navigators stack for the change of screen as we desire
    Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair){
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
              },
            );
            //This will add horizontal spacing between each list tile
            //With this, the final rows are contained in the divided variable, which we convert to a list with toList()
            final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();
            //The builder property will return a scaffold of the screen with an ap bar and a body containing a listview with each row
            return Scaffold(
              appBar: AppBar(
                title: Text("Saved Suggestions"),
              ),
              body: ListView(children: divided),
              );
          },
        ),
    );
  }
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
        //Add a button to the app bar, which on pressed will nav to the next screen
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();

}