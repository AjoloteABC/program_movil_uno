import 'package:flutter/material.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String _numeroTemporal = '';
  bool _operandoUnoListo = false;

  double _operandoUno = 0;
  String _operador = '';
  double _operandoDos = 0;

  String _historial = '';
  String _impresion = '';

  void _numero(String numero) {
    // Evita agregar números y punto al resultado
    if ((numero != '.' ||
            numero == '.' && _numeroTemporal.contains('.') == false) &&
        (_operandoUnoListo == false ||
            _operandoUnoListo == true && _operador.isNotEmpty)) {
      _numeroTemporal += numero;

      setState(() {
        _impresion += numero;
      });
    }
  }

  void _operacion(String operador) {
    // Evita el operador al inicio y repetir el operador
    if (_impresion.isNotEmpty && _operador.isEmpty) {
      _operador = operador;

      _operandoUno = double.tryParse(_numeroTemporal)!;
      _operandoUnoListo = true;
      _numeroTemporal = '';

      setState(() {
        _impresion += operador;
      });
    }
  }

  void _igual() {
    // Asegura el 1er operando, el operador y un valor para el 2do operando
    // para poder calcular un resultado
    if (_operandoUnoListo == true &&
        _operador.isNotEmpty &&
        _numeroTemporal.isNotEmpty) {
      _operandoDos = double.tryParse(_numeroTemporal)!;

      switch (_operador) {
        case ' x ':
          _operandoUno = _operandoUno * _operandoDos;
          break;
        case ' - ':
          _operandoUno = _operandoUno - _operandoDos;
          break;
        case ' + ':
          _operandoUno = _operandoUno + _operandoDos;
          break;
        case ' / ':
          if (_operandoDos == 0) {
            _numeroTemporal = '';
            setState(() {
              _historial = 'Math Error';
              _impresion = _operandoUno.toString() + _operador;
            });
            return;
            /*
            Es necesario un return para no ejecutar lo que sigue después
            del switch, ya que implicaría una operación válida.

            Tampoco se ejecutará el setState inferior, por lo tanto,
            es necesario el setState superior para actualizar _historial,
            de lo contrario nunca se refrescará el valor en pantalla
            (aunque sí de forma interna) y se mostrará el valor inicial de
            _historial que es un String vacío.
             */
          }
          _operandoUno = _operandoUno / _operandoDos;
          break;
      }

      setState(() {
        _historial = _impresion;
        _impresion = _operandoUno.toString();
      });

      _operador = '';
      _numeroTemporal = _operandoUno.toString();
      // numTemporal debe olvidar el valor de operandoDos debido al método _operacion()
    }
  }

  void _limpiar() {
    _numeroTemporal = '';
    _operandoUnoListo = false;

    _operandoUno = 0;
    _operador = '';
    _operandoDos = 0;

    setState(() {
      _historial = '';
      _impresion = '';
    });
  }

  Widget _boton(Function() funcionBttn, Color colorBttn, String textoBttn) {
    return ElevatedButton(
      onPressed: () {
        funcionBttn();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(70, 70),
        backgroundColor: colorBttn,
        shape: const CircleBorder(),
      ),
      child: Text(
        textoBttn,
        style: const TextStyle(fontSize: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora',
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              // Usemos FileImage en lugar de AssetImage
              image: AssetImage('assets/imagenes/02.jpg'),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Text(
                      '\n$_historial\n$_impresion\n.........................\n',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 40,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Solid text as fill.
                    Text(
                      '\n$_historial\n$_impresion\n.........................\n',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 40,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _boton(() => _numero('1'), Colors.amber, '1'),
                    _boton(() => _numero('2'), Colors.amber, '2'),
                    _boton(() => _numero('3'), Colors.amber, '3'),
                    _boton(() => _operacion(' x '), Colors.deepPurple, 'x'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _boton(() => _numero('4'), Colors.amber, '4'),
                    _boton(() => _numero('5'), Colors.amber, '5'),
                    _boton(() => _numero('6'), Colors.amber, '6'),
                    _boton(() => _operacion(' - '), Colors.deepPurple, '-'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _boton(() => _numero('7'), Colors.amber, '7'),
                    _boton(() => _numero('8'), Colors.amber, '8'),
                    _boton(() => _numero('9'), Colors.amber, '9'),
                    _boton(() => _operacion(' + '), Colors.deepPurple, '+'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _boton(() => _operacion(' / '), Colors.deepPurple, '/'),
                    _boton(() => _numero('0'), Colors.amber, '0'),
                    _boton(() => _numero('.'), Colors.amber, '.'),
                    _boton(() => _igual(), Colors.blue, '='),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      _limpiar();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(145, 50),
                    ),
                    child: const Text(
                      'Clean',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
