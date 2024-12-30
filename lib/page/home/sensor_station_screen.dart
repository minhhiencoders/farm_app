import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/utilities/string-utils.dart';
import 'package:smart_farm_application/view_models/client_infor_view_model.dart';

import '../../model/client_infor.dart';
class SensorStationScreen extends ConsumerStatefulWidget {
  const SensorStationScreen({super.key});

  @override
  ConsumerState createState() => _SensorStationScreenState();
}

class AnnotationClickListener extends OnCircleAnnotationClickListener {
  AnnotationClickListener({
    required this.onAnnotationClick,
  });

  final void Function(CircleAnnotation annotation) onAnnotationClick;

  @override
  void onCircleAnnotationClick(CircleAnnotation annotation) {
    onAnnotationClick(annotation);
  }
}

class _SensorStationScreenState extends ConsumerState<SensorStationScreen> {

  MapboxMap? mapboxMap;
  CircleAnnotation? circleAnnotation;
  CircleAnnotationManager? circleAnnotationManager;
  PointAnnotationManager? pointAnnotationManager;
  int styleIndex = 1;

  _onMapCreated(MapboxMap mapboxMap, List<SensorDevice> sensors) {
    this.mapboxMap = mapboxMap;
    // mapboxMap.setCamera(CameraOptions(
    //     center: Point(coordinates: Position(0, 0)), zoom: 1, pitch: 0));

    // Create both circle and point annotation managers
    Future.wait([
      mapboxMap.annotations.createCircleAnnotationManager(),
      mapboxMap.annotations.createPointAnnotationManager(),
    ]).then((managers) {
      circleAnnotationManager = managers[0] as CircleAnnotationManager;
      pointAnnotationManager = managers[1] as PointAnnotationManager;
      createOneAnnotation(StringUtils.centerToPositions(sensors.first.coord), sensors.first.id.toString());

      circleAnnotationManager?.addOnCircleAnnotationClickListener(
        AnnotationClickListener(
          onAnnotationClick: (annotation) => circleAnnotation = annotation,
        ),
      );
    });
  }


  void createOneAnnotation(Position position, String id) {
    // final position = Position.named(lng: 130.058, lat: 6.687337);

    // Create circle annotation
    circleAnnotationManager
        ?.create(CircleAnnotationOptions(
      geometry: Point(coordinates: position),
      circleColor: Colors.white.hashCode,
      circleBlur: 0.5,
      circleRadius: 16.0,
      circleStrokeColor: Colors.white.value,
      circleStrokeWidth: 2.0,
      circleOpacity: 0.8,
    ))
        .then((value) => circleAnnotation = value);

    // Create text annotation using PointAnnotation
    pointAnnotationManager?.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: position),
        textField: id,
        textSize: 10.0,
        textColor: Colors.red.value,
        textOffset: [0, -0.5], // Slightly adjust text position above the circle
        iconSize: 0.0, // Hide the default point marker
        textAnchor: TextAnchor.CENTER,
        textHaloColor: Colors.black.value,
        textHaloWidth: 1.0,
      ),
    );
  }

  void _flyToAnnotation(Position position) {
    mapboxMap?.flyTo(
      CameraOptions(
        center: Point(coordinates: position),
        anchor: ScreenCoordinate(x: 0, y: 0),
        zoom: 17,
        pitch: 20,
      ),
      MapAnimationOptions(duration: 2000, startDelay: 0),
    );
  }


  @override
  Widget build(BuildContext context) {
    final sensors = ref.watch(clientInforProvider).value?.sensorDevices;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _flyToAnnotation(StringUtils.centerToPositions(sensors!.first.coord));
        },
        child: const Icon(Icons.my_location),
      ),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        cameraOptions: CameraOptions(
          center: Point(coordinates: StringUtils.centerToPositions(sensors!.first.coord)),
          zoom: 15.0,
        ),
        styleUri: MapboxStyles.SATELLITE,
        textureView: true,
        onMapCreated: (controller) => _onMapCreated(controller,sensors),
        // onStyleLoadedListener: (_) {
        //   _setupPolygonAnnotations();
        //   _setupPointAnnotations();
        // },
      ),
    );
  }
}
