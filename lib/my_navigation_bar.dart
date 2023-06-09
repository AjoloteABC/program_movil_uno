import 'package:flutter/material.dart';
import 'my_welcome.dart';
import 'my_calculator.dart';
import 'my_data_entry.dart';
import 'my_coordinate.dart';
import 'my_map.dart';
import 'my_counter.dart';
import 'my_calendar.dart';
import 'my_nfc.dart';
import 'my_chart.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  // Lista de Widgets desplegados
  // Los elementos de la lista es constante en tiempo de compilación
  static const List<Widget> _widgetOptions = <Widget>[
    MyWelcome(),
    MyCalculator(),
    MyDataEntry(),
    MyCoordinate(),
    MyMap(),
    MyCalendar(),
    MyCounter(),
    MyNFC(),
    MyChart(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        // Permite agregar más de tres BottomNavigationBarItem
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_rounded),
            label: 'Calcular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Ingresar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_location),
            label: 'Ubicación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Contador',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nfc),
            label: 'NFC',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
