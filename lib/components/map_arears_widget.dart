import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/model/client_infor.dart';

class MapAreasWidget extends StatefulWidget {
  const MapAreasWidget({super.key, required this.position, required this.nameSector, required this.centers});
  final List<List<List<Position>>> position;
  final List<String> nameSector;
  final List<Position> centers;
  @override
  State createState() => MapAreasWidgetState();
}

class AnnotationClickListener extends OnPolygonAnnotationClickListener {
  AnnotationClickListener({
    required this.onAnnotationClick,
  });

  final void Function(PolygonAnnotation annotation) onAnnotationClick;
  @override
  void onPolygonAnnotationClick(PolygonAnnotation annotation) {
    onAnnotationClick(annotation);
  }
}

class MapAreasWidgetState extends State<MapAreasWidget> {
  MapboxMap? mapboxMap;
  var isLight = true;
  PolygonAnnotation? polygonAnnotation;
  PolygonAnnotationManager? polygonAnnotationManager;
  int styleIndex = 1;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.style;
    mapboxMap.attribution.updateSettings(AttributionSettings(enabled: false));
    mapboxMap.logo.updateSettings(LogoSettings(
      position: OrnamentPosition.BOTTOM_LEFT,
      marginBottom: 10,
      marginLeft: 10,
      marginTop: 30,
      marginRight: 30,
    ));
    mapboxMap.annotations.createPolygonAnnotationManager().then((value) {
      polygonAnnotationManager = value;
      // createOneAnnotation();
      var options = <PolygonAnnotationOptions>[];
      for (var i = 0; i < widget.position.length; i++) {
        options.add(PolygonAnnotationOptions(
            geometry: Polygon(coordinates: widget.position[i]),
            fillColor: Colors.red.hashCode));
      }
      polygonAnnotationManager?.createMulti(options);
      polygonAnnotationManager?.addOnPolygonAnnotationClickListener(
        AnnotationClickListener(
          onAnnotationClick: (annotation) {
            annotation.fillColor = Colors.yellow.value;
            polygonAnnotationManager?.update(annotation);
            _flyToAnnotion(annotation.geometry.coordinates.first.first);
            polygonAnnotation = annotation;
          },
        ),
      );
    });
  }

  _flyToAnnotion(Position posion) {
    mapboxMap?.flyTo(
        CameraOptions(
            center: Point(coordinates: posion),
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: 17,
            // bearing: 90,
            pitch: 20),
        MapAnimationOptions(duration: 2000, startDelay: 0));
  }

  void createOneAnnotation() {
    polygonAnnotationManager
        ?.create(PolygonAnnotationOptions(
            geometry: Polygon(coordinates: [
              [
                Position(106.90338, 11.621774),
                Position(106.90396, 11.622043),
                Position(106.90417, 11.621546),
                Position(106.90353, 11.621356)
              ]
            ]),
            fillColor: Colors.red.value,
            fillOutlineColor: Colors.purple.value))
        .then((value) => polygonAnnotation = value);
  }

  _onStyleLoadedCallback(StyleLoadedEventData data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Style loaded :), time: ${data.timeInterval}"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            mapboxMap?.flyTo(
                CameraOptions(
                    center: Point(coordinates: Position(106.90417, 11.621546)),
                    anchor: ScreenCoordinate(x: 0, y: 0),
                    zoom: 17,
                    // bearing: 90,
                    pitch: 20),
                MapAnimationOptions(duration: 2000, startDelay: 0));
          },
          child: Icon(Icons.my_location),
        ),
        body: MapWidget(
          key: ValueKey("mapWidget"),
          cameraOptions: CameraOptions(
              center: Point(coordinates: Position(108.26842, 12.691489)),
              zoom: 15.0),
          // viewport: CameraViewportState(
          //     center: Point(coordinates: Position(106.90338, 11.621774)),
          //     zoom: 15.0,
          //     pitch: 0),
          styleUri: MapboxStyles.SATELLITE_STREETS,
          textureView: true,
          onMapCreated: _onMapCreated,
          onStyleLoadedListener: _onStyleLoadedCallback,
          onLongTapListener: (coordinate) {},
        ));
  }
}

extension on CameraChangedEventData {
  String get debugInfo {
    return "timestamp ${DateTime.fromMicrosecondsSinceEpoch(timestamp)}, camera: ${cameraState.debugInfo}";
  }
}

extension on CameraState {
  String get debugInfo {
    return "lat: ${center.coordinates.lat}, lng: ${center.coordinates.lng}, zoom: ${zoom}, bearing: ${bearing}, pitch: ${pitch}";
  }
}
