import 'package:flutter/material.dart';
import 'shared_preferences.dart';

class MyDataEntry extends StatefulWidget {
  const MyDataEntry({Key? key}) : super(key: key);

  @override
  State<MyDataEntry> createState() => _MyDataEntryState();
}

class _MyDataEntryState extends State<MyDataEntry> {
  final _formKey = GlobalKey<FormState>();
  /*
  TextFormField es una clase que se utiliza para controlar el texto en un
  widget 'TextField' o 'TextFormField'.

  1. Permite establecer un valor inicial en el campo de texto.
  2. Leer el texto actualmente ingresado en el campo de texto.
  3. Actualizar dinámicamente el texto en respuesta a eventos.
   */
  final TextEditingController _controller_01 = TextEditingController();
  final TextEditingController _controller_02 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ingreso de Datos',
        ),
      ),
      body: Center(
        child: Form(
          // Valida el formulario en conjunto
          key: _formKey,
          // Siempre ejecuta el validator de cada TextFormField,
          // en este ejemplo, puede llegar a ser molesto visualmente:
          // autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 30),
                width: 600,
                child: TextFormField(
                  controller: _controller_01,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(75)),
                    ),
                    hintText: 'Puedes usar sobrenombre',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  validator: (value) {
                    // value es de tipo String? pero nunca tomará un valor null.
                    // Creo no está de más agregar el operador null-awareness ??
                    if (value?.isEmpty ?? true) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 30),
                width: 600,
                child: TextFormField(
                  controller: _controller_02,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.travel_explore),
                    labelText: 'País',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(75)),
                    ),
                    hintText: 'No importa de donde vengas',
                    hintStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Enviando información a página principal'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    String texto_01 = _controller_01.text;
                    MySharedPreferences.saveString('nombre', texto_01);

                    String texto_02 = _controller_02.text;
                    MySharedPreferences.saveString('pais', texto_02);
                  }
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
