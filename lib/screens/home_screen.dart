import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Héroes del silencio', votes: 3),
    Band(id: '4', name: 'Bon Jovi', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Band Names', style: TextStyle( color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
        body: ListView.builder(
          itemCount: bands.length,
          itemBuilder:(context, index) => _bandTile( bands[index] )
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 1,
          onPressed: addNewBand,
          child: const Icon( Icons.add )
        ),
      );
  }

  Widget _bandTile( Band band ) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('Id: ${band.id}');
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band', style: TextStyle( color: Colors.white),)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:  Colors.blue[100],
          child: Text( band.name.substring(0, 2)),
        ),
        title: Text( band.name ),
        trailing: Text( '${band.votes}', style: const TextStyle( fontSize: 20),),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {

    final TextEditingController textController = TextEditingController();

    if ( Platform.isAndroid ){
      showDialog(
        context: context,
        builder: (BuildContext context) {  
          return AlertDialog(
            title: const Text('New Band Name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList( textController.text ),
                child: const Text('Add')
              )
            ],
          );
      });
    }

    else {
      showCupertinoDialog(
        context: context, 
        builder: ( _ ){
          return CupertinoAlertDialog(
            title: const Text('New Band Name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Add'),
                onPressed: () => addBandToList( textController.text )
              ),
              CupertinoDialogAction(
                child: const Text('Dismiss'),
                onPressed: () => Navigator.pop(context)
              ),
            ],
          );
        }
     );
    }
  }

  void addBandToList( String name ) {

    print( name );
    if ( name.length > 1 ){
      bands.add( Band(id: DateTime.now().toString(), name: name, votes: 0,));
      setState(() {});
    }

    Navigator.pop(context);
  }
}