import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' ;

class MyChart extends StatefulWidget {
  const MyChart({Key? key}) : super(key: key);

  @override
  State<MyChart> createState() => _MyChartState();
}
var valores ;
Future<void> _datos() async {
  // Lets the user pick one file; files with any file extension can be selected
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  //Uint8list? file;
  String? uploadfile = result?.files.single.path;

  if(result != null) {
    PlatformFile file = result.files.single;
    print(uploadfile);
  } else {
    // El usuario canceló la selección
  }
}



class _MyChartState extends State<MyChart> {
  @override
  initState() {
    super.initState();
    _datos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Graficos',
        ),
      ),
    floatingActionButton: FloatingActionButton(
        onPressed: () => _sacarDatos(context),
        tooltip: "mostrar datos",
        child: const Icon(Icons.event_sharp),
      ),
      body: Text(
          "soap",
          //'$uploadfile'
    ),

    );
  }
}
Future<void> _sacarDatos(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('uploadfile'),

      );
    },
  );
}