import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  const MyCounter({Key? key}) : super(key: key);

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _counter = 0;

  @override
  initState() {
    super.initState();
    _loadCounter();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;




  void _loadCounter() {
    db.collection("Contador").doc('Variable').get().then((docSnapshot) {
      if (docSnapshot.exists) {
        int incremento = docSnapshot.data()!['Incremento'];
        setState(() {
          _counter = incremento;
        });
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Actualización del valor en Firebase
    final user = <String, dynamic>{'Incremento': _counter};
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
