import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/model/client_infor.dart';
import 'package:smart_farm_application/page/home/extend/item_control_screen.dart';

import '../../model/area.dart';
import '../../utilities/size_utils.dart';

class IrrigationAlternatelyScreen extends ConsumerStatefulWidget {
  const IrrigationAlternatelyScreen({super.key});

  @override
  ConsumerState createState() => _IrrigationAlternatelyScreenState();
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

class _IrrigationAlternatelyScreenState
    extends ConsumerState<IrrigationAlternatelyScreen> {
  MapboxMap? mapboxMap;
  PolygonAnnotationManager? polygonAnnotationManager;
  PointAnnotationManager? pointAnnotationManager;
  PolygonAnnotation? polygonAnnotation;
  PolygonAnnotation? _selectedPolygon;
  void _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;

    mapboxMap.style;
    mapboxMap.attribution.updateSettings(AttributionSettings(enabled: false));
    mapboxMap.logo.updateSettings(
      LogoSettings(
        position: OrnamentPosition.BOTTOM_LEFT,
        marginBottom: 10,
        marginLeft: 10,
        marginTop: 30,
        marginRight: 30,
      ),
    );

    mapboxMap.annotations.createPolygonAnnotationManager().then((value) {
      polygonAnnotationManager = value;
      createOneAnnotation();
      // var options = <PolygonAnnotationOptions>[];
      // for (var i = 0; i < 1; i++) {
      //   options.add(PolygonAnnotationOptions(
      //       geometry: Polygon(coordinates: [
      //         [
      //           Position(108.26842, 12.691489),
      //           Position(108.2693, 12.691626),
      //           Position(108.26931, 12.691157),
      //           Position(108.268364, 12.691025)
      //         ]
      //       ]),
      //       fillColor: Colors.yellow.value));
      // }
      // polygonAnnotationManager?.createMulti(options);
      polygonAnnotationManager?.addOnPolygonAnnotationClickListener(
        AnnotationClickListener(
          onAnnotationClick: (annotation) {
            annotation.fillColor = Colors.green.withOpacity(0.8).value;
            annotation.fillOutlineColor = Colors.white.value;
            polygonAnnotationManager?.update(annotation);
            _showBottomBox();
          },
        ),
      );
    });
  }

  void _showBottomBox() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      constraints: BoxConstraints(
          maxHeight: SizeUtils(context).sizeHeight * 0.8,
          minHeight: SizeUtils(context).sizeHeight * 0.5,
          minWidth: SizeUtils(context).sizeWidth),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ItemControlScreenScreen(
              area: Area(
                  positions: [
                    [Position(0.0, 0.0)]
                  ],
                  nameSector: 'alt A',
                  center: Position(0.0, 0.0),
                  acreage: 4164.8,
                  spmeta: Spmeta(
                      lastUpdate: 1,
                      rhPin: 1,
                      sensorDeviceId: 1,
                      tempPin: 1,
                      timesActivatedToday: 1),
                  sectorId: 1),
              isShowIrrigation: true),
        );
      },
    );
  }

  void createOneAnnotation() {
    polygonAnnotationManager
        ?.create(PolygonAnnotationOptions(
            geometry: Polygon(coordinates: [
              [
                Position(106.90311, 11.622516),
                Position(106.9037, 11.622728),
                Position(106.90386, 11.622214),
                Position(106.90333, 11.621962)
              ]
            ]),
            fillColor: Colors.white.withOpacity(0.8).value,
            fillOutlineColor: Colors.white.value))
        .then((value) {
      polygonAnnotation = value;
      addLabelToPolygon(polygonAnnotation!);
    });
  }

  void addLabelToPolygon(PolygonAnnotation polygonAnnotation) {
    final coordinates = polygonAnnotation.geometry.coordinates.first;

    // Simple centroid calculation (can be replaced with a more accurate method)
    double avgLng = 0.0;
    double avgLat = 0.0;

    for (var position in coordinates) {
      avgLng += position.lng;
      avgLat += position.lat;
    }

    avgLng /= coordinates.length;
    avgLat /= coordinates.length;

    mapboxMap?.annotations.createPointAnnotationManager().then((symbolManager) {
      symbolManager.create(PointAnnotationOptions(
        geometry: Point(coordinates: Position(avgLng, avgLat)),
        textField: 'alt A', // The label text
        textSize: 14.0,
        textColor: Colors.red.value,
      ));
    });
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _flyToAnnotation(Position(106.90311, 11.622516));
        },
        child: const Icon(Icons.my_location),
      ),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        cameraOptions: CameraOptions(
          center: Point(coordinates: Position(106.90311, 11.622516)),
          zoom: 15.0,
        ),
        styleUri: MapboxStyles.SATELLITE_STREETS,
        textureView: true,
        onMapCreated: _onMapCreated,
        // onStyleLoadedListener: (_) {
        //   _setupPolygonAnnotations();
        //   _setupPointAnnotations();
        // },
      ),
    );
  }
}
