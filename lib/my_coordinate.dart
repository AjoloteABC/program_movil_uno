import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'shared_preferences.dart';

import 'geolocation.dart';

class MyCoordinate extends StatefulWidget {
  const MyCoordinate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyCoordinateState();
}

class _MyCoordinateState extends State<MyCoordinate> {
  Position? _currentPosition;

  Future<void> _loadLocation() async {
    Position? currentPosition =
        await MyGeolocation.handleLocationPermission(context);

    /*
    if (currentPosition != null) {
      MySharedPreferences.saveDouble('latitud', currentPosition.altitude);
      MySharedPreferences.saveDouble('longitud', currentPosition.longitude);
    }
     */

    setState(() {
      _currentPosition = currentPosition;
    });
  }

  // Solo los campos static pueden ser declarados como const
  static const TextStyle optionStyle01 = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle optionStyle02 = TextStyle(
    fontSize: 25,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Geolocalización',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Latitud',
              style: optionStyle01,
              textAlign: TextAlign.center,
            ),
            Text(
              '${_currentPosition?.latitude ?? 'aún sin solicitar'}',
              style: optionStyle02,
              textAlign: TextAlign.center,
            ),
            const Text(
              '\nLongitud',
              style: optionStyle01,
              textAlign: TextAlign.center,
            ),
            Text(
              '${_currentPosition?.longitude ?? 'aún sin solicitar'}',
              style: optionStyle02,
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.only(top: 25), // ElevatedButton
              child: ElevatedButton(
                child: const Text('Geolocalizar'),
                onPressed: () {
                  _loadLocation();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
