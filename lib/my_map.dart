import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  // final o MapController
  MapController controller = MapController(
    initMapWithUserPosition: false,
    initPosition:
        GeoPoint(latitude: 19.433613508203734, longitude: -99.13307993787618),
    areaLimit: const BoundingBox.world(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Geolocalización en Mapa',
        ),
      ),
      body: Stack(
        children: <Widget>[
          OSMFlutter(
            controller: controller,
            trackMyPosition: false,
            initZoom: 12,
            minZoomLevel: 3,
            maxZoomLevel: 19,
            stepZoom: 1.0,
            // [01]
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            // [02]
            roadConfiguration: const RoadOption(
              roadColor: Colors.yellowAccent,
            ),
            // [03]
            markerOption: MarkerOption(
              defaultMarker: const MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
            right: 50.0,
            child: FloatingActionButton(
              onPressed: () async {
                await controller.currentLocation();
                await controller.setZoom(zoomLevel:19);
              },
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
