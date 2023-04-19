import 'package:flutter/material.dart';
import 'dart:io';
import 'shared_preferences.dart';
import 'image_picker.dart';

class MyWelcome extends StatefulWidget {
  const MyWelcome({Key? key}) : super(key: key);

  @override
  State<MyWelcome> createState() => _MyWelcomeState();
}

class _MyWelcomeState extends State<MyWelcome> {
  @override
  void initState() {
    super.initState();
    _loadNombre();
    _loadPais();
  }

  String _nombre = '';
  String _pais = '';

  Future<void> _loadNombre() async {
    String? nombre = await MySharedPreferences.getString('nombre', 'extranjero');
    setState(() {
      _nombre = nombre!;
    });
  }

  Future<void> _loadPais() async {
    String? pais = await MySharedPreferences.getString('pais', 'ninguna parte');
    setState(() {
      _pais = pais!;
    });
  }

  File? _imagen;

  Future<void> _loadImagen() async {
    File? imagen = await MyImagePicker.pickImage();
    setState(() {
      _imagen = imagen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bienvenida',
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imagenes/01.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Hola $_nombre\nveo que eres de $_pais', // Text
                  style: const TextStyle(
                    fontFamily: 'Broken',
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'AUN ASI NO PUEDES ACCEDER',
                  style: TextStyle(
                    fontFamily: 'Punk-is-not-Dead',
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25), // Image.asset
                  child: Image.asset(
                    'imagenes/soldado.png',
                    height: 400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 25, bottom: 25), // ElevatedButton
                  child: ElevatedButton(
                    child: const Text('Cargar imagen'),
                    onPressed: () {
                      _loadImagen();
                    },
                  ),
                ),
                (_imagen == null)
                    ? const Text(
                        'No hay imagen',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Broken',
                          fontSize: 50,
                        ),
                      )
                    : const Text(
                        'Ya hay una imagen!',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Broken',
                          fontSize: 50,
                        ),
                      ),
                // : Image.file(file!)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
