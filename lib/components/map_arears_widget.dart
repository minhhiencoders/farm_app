import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/model/area.dart';
import 'package:smart_farm_application/utilities/size_utils.dart';
import '../page/home/extend/item_control_screen.dart';

class MapAreasWidget extends StatefulWidget {
  const MapAreasWidget({
    super.key,
 required this.listArea,  this.isReport = false,
  });

  final List<Area> listArea;
  final bool isReport;
  @override
  State createState() => _MapAreasWidgetState();
}

class _MapAreasWidgetState extends State<MapAreasWidget> {
  MapboxMap? mapboxMap;
  PolygonAnnotationManager? polygonAnnotationManager;
  PointAnnotationManager? pointAnnotationManager;
  List<PolygonAnnotation?> _polygonAnnotations = [];
  PolygonAnnotation? _selectedPolygon;

  @override
  void initState() {
    super.initState();
  }

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

  void _setupPolygonAnnotations() async {
    polygonAnnotationManager = await mapboxMap?.annotations.createPolygonAnnotationManager();

    if (polygonAnnotationManager == null) return;

    final options = widget.listArea.map((polygonCoordinates) {
      return PolygonAnnotationOptions(
        fillOpacity: 0.5,
        geometry: Polygon(coordinates: polygonCoordinates.positions),
        fillColor: Colors.white.value,
        fillOutlineColor: Colors.white.value,
      );
    }).toList();

    await polygonAnnotationManager?.createMulti(options).then((value) => _polygonAnnotations = value);

    polygonAnnotationManager?.addOnPolygonAnnotationClickListener(
      AnnotationClickListener(
        onAnnotationClick: (annotation) {
          if(_selectedPolygon != null){
            _selectedPolygon?.fillColor = Colors.white.withOpacity(0.5).value;
            _selectedPolygon?.fillOutlineColor = Colors.white.value;
            polygonAnnotationManager?.update(_selectedPolygon!);
          }
          int index = _polygonAnnotations.indexWhere((element) => element!.id.contains(annotation.id),);
          annotation.fillColor = Colors.green.withOpacity(0.8).value;
          polygonAnnotationManager?.update(annotation);
          _selectedPolygon = annotation;
          _flyToAnnotation(annotation.geometry.coordinates.first.first);
          widget.isReport ? _showBottomBoxReport() : _showBottomBoxControl(widget.listArea.elementAt(index));
        },
      ),
    );
  }

  void _setupPointAnnotations() async {
    pointAnnotationManager = await mapboxMap?.annotations.createPointAnnotationManager();

    if (pointAnnotationManager == null) return;

    for (var area in widget.listArea) {
      await pointAnnotationManager?.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: area.center),
          textField: area.nameSector,
          textSize: 20,
          textColor: Colors.red.value,
        ),
      );
    }

    pointAnnotationManager?.addOnPointAnnotationClickListener(
      PointAnnotationClickListener(
        onAnnotationClick: (annotation) {
          _flyToAnnotation(annotation.geometry.coordinates);
          int index = widget.listArea.indexWhere((element) => element.nameSector.contains(annotation.textField!),);
          if (index != -1) {
            if(_selectedPolygon != null){
              _selectedPolygon?.fillColor = Colors.white.withOpacity(0.5).value;
              _selectedPolygon?.fillOutlineColor = Colors.white.value;
              polygonAnnotationManager?.update(_selectedPolygon!);
            }
            _polygonAnnotations.elementAt(index)?.fillColor = Colors.green.withOpacity(0.8).value;
            polygonAnnotationManager?.update(_polygonAnnotations.elementAt(index)!);
            _selectedPolygon = _polygonAnnotations.elementAt(index);
          }

          widget.isReport ? _showBottomBoxReport() : _showBottomBoxControl(widget.listArea.elementAt(index));
        },
      ),
    );
  }


  void _showBottomBoxControl(Area? area) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      constraints: BoxConstraints(maxHeight: SizeUtils(context).sizeHeight * 0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ItemControlScreenScreen(area: area!, isShowIrrigation: false),
        );
      },
    );
  }

  void _showBottomBoxReport(){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      constraints: BoxConstraints(maxHeight: SizeUtils(context).sizeHeight * 0.8, minHeight: SizeUtils(context).sizeHeight * 0.5, minWidth: SizeUtils(context).sizeWidth),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(child: Text('Hello'),),
        );
      },
    );
  }


  @override
  void didUpdateWidget(covariant MapAreasWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.listArea != widget.listArea) {
      _setupPolygonAnnotations();
      _setupPointAnnotations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _flyToAnnotation(Position(106.90417, 11.621546));
        },
        child: const Icon(Icons.my_location),
      ),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        cameraOptions: CameraOptions(
          center: Point(coordinates: Position(108.26842, 12.691489)),
          zoom: 15.0,
        ),
        styleUri: MapboxStyles.SATELLITE_STREETS,
        textureView: true,
        onMapCreated: _onMapCreated,
        onStyleLoadedListener: (_) {
          _setupPolygonAnnotations();
          _setupPointAnnotations();
        },
      ),
    );
  }
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

class PointAnnotationClickListener extends OnPointAnnotationClickListener {
  PointAnnotationClickListener({
    required this.onAnnotationClick,
  });

  final void Function(PointAnnotation annotation) onAnnotationClick;

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onAnnotationClick(annotation);
  }
}
