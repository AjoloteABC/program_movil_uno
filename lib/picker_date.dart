import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PickerDate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PickerDate();
  }
}

class _PickerDate extends State<PickerDate> {
  Color mycolor = Colors.lightBlue;
  bool isChecked = false;

  TextEditingController fechaInicio = TextEditingController();
  TextEditingController fechaFin = TextEditingController();

  @override
  void initState() {
    fechaInicio.text = "";
    fechaFin.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(

        // Valida el formulario en conjunto
        // Siempre ejecuta el validator de cada TextFormField,
        // en este ejemplo, puede llegar a ser molesto visualmente:
        // autovalidateMode: AutovalidateMode.always,
        child: Column(

          mainAxisSize: MainAxisSize.max,
          children: <Widget>[ 
            Container(
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.event_note_outlined),
                  labelText: 'Nombre Evento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(75)),
                  ),
                  hintText: 'Nombre Evento',
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
              //padding: const EdgeInsets.fromLTRB(60, 0, 60, 30),
              child: TextField(
                controller: fechaInicio,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Fecha Inicio" //label text of field
                    ),

                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formatoFechaInicio =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formatoFechaInicio); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      fechaInicio.text =
                          formatoFechaInicio; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
            ),
            Container(
              //padding: const EdgeInsets.fromLTRB(60, 0, 60, 30),
              child: TextField(
                controller: fechaFin,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Fecha Fin " //label text of field
                    ),

                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formatoFechaFin =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formatoFechaFin); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      fechaFin.text =
                          formatoFechaFin; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Escoge un color'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: mycolor, //default color
                              onColorChanged: (Color color) {
                                //on color picked
                                setState(() {
                                  mycolor = color;
                                  print(mycolor);
                                });
                              },
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Listo'),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); //dismiss the color picker
                              },
                            ),
                          ],
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mycolor, // establecer el color del botón
                  // otros estilos como la altura, la forma, el padding, etc.
                ),
                child: Text("Escoge un color"),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text(
                    'Todo el dia',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
