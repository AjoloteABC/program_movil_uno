
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MyDataBase extends StatefulWidget {
  const MyDataBase({Key? key}) : super(key: key);



  @override
  State<MyDataBase> createState() => _MyDataBaseState();
}

class _MyDataBaseState extends State<MyDataBase> {
  int _counter = 0;

  @override
  initState(){
    super.initState();
    db.collection("Contador").doc('Variable').get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // Accede al campo "Incremento" y conviértelo a entero
        int incremento = int.parse(docSnapshot.data()!['Incremento'].toString());
        setState(() {
          _counter = incremento;
        });
      }
    });
  }
  FirebaseFirestore db = FirebaseFirestore.instance;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      'Incremento': _counter
    };


// Add a new document with a generated ID
    db.collection("Contador").doc('Variable').set(user);





  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: const Text(
        'Contador',
    ),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Haz presionado el boton:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incremento',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

