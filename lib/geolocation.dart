import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyGeolocation {
  static Future<Position?> handleLocationPermission(
      BuildContext context) async {
    /*
     "Don't use 'BuildContext's across async gaps" se da porque el objeto
     BuildContext puede ser inválido o no estar actualizado cuando se
     utiliza en una tarea asíncrona, provocando comportamientos no deseados.

    La técnica "captura de texto" almacena el objeto BuildContext en
    una variable local antes de iniciar la tarea asíncrona.
     */
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('El servicio de localización está deshabilitado'),
        ),
      );
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Los permisos de localización están denegados'),
          ),
        );
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text(
              'Los permisos de localización están permanentemente denegados'),
        ),
      );
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
    );
  }
}
