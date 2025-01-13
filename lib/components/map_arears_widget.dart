import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:smart_farm_application/components/loading_widget.dart';
import 'package:smart_farm_application/model/area.dart';
import 'package:smart_farm_application/utilities/size_utils.dart';
import 'package:smart_farm_application/view_models/report_view_model.dart';
import '../configs/contants.dart';
import '../model/information.dart';
import '../page/home/extend/item_control_screen.dart';
import '../utilities/hive_utils.dart';

class MapAreasWidget extends ConsumerStatefulWidget {
  const MapAreasWidget({
    super.key,
    required this.listArea,
    this.isReport = false,
    this.isShowIrrigation = false
  });

  final List<Area> listArea;
  final bool isReport;
  final bool isShowIrrigation;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapAreasWidgetState();
}

class _MapAreasWidgetState extends ConsumerState<MapAreasWidget> {
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
    polygonAnnotationManager =
        await mapboxMap?.annotations.createPolygonAnnotationManager();

    if (polygonAnnotationManager == null) return;

    final options = widget.listArea.map((polygonCoordinates) {
      return PolygonAnnotationOptions(
        fillOpacity: 0.5,
        geometry: Polygon(coordinates: polygonCoordinates.positions),
        fillColor: Colors.white.value,
        fillOutlineColor: Colors.white.value,
      );
    }).toList();

    await polygonAnnotationManager
        ?.createMulti(options)
        .then((value) => _polygonAnnotations = value);

    polygonAnnotationManager?.addOnPolygonAnnotationClickListener(
      AnnotationClickListener(
        onAnnotationClick: (annotation) {
          if (_selectedPolygon != null) {
            _selectedPolygon?.fillColor = Colors.white.withOpacity(0.5).value;
            _selectedPolygon?.fillOutlineColor = Colors.white.value;
            polygonAnnotationManager?.update(_selectedPolygon!);
          }
          int index = _polygonAnnotations.indexWhere(
            (element) => element!.id.contains(annotation.id),
          );
          annotation.fillColor = Colors.green.withOpacity(0.8).value;
          polygonAnnotationManager?.update(annotation);
          _selectedPolygon = annotation;
          _flyToAnnotation(annotation.geometry.coordinates.first.first);
          widget.isReport
              ? _showBottomBoxReport(widget.listArea.elementAt(index))
              : _showBottomBoxControl(widget.listArea.elementAt(index));
        },
      ),
    );
  }

  void _setupPointAnnotations() async {
    pointAnnotationManager =
        await mapboxMap?.annotations.createPointAnnotationManager();

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
          int index = widget.listArea.indexWhere(
            (element) => element.nameSector.contains(annotation.textField!),
          );
          if (index != -1) {
            if (_selectedPolygon != null) {
              _selectedPolygon?.fillColor = Colors.white.withOpacity(0.5).value;
              _selectedPolygon?.fillOutlineColor = Colors.white.value;
              polygonAnnotationManager?.update(_selectedPolygon!);
            }
            _polygonAnnotations.elementAt(index)?.fillColor =
                Colors.green.withOpacity(0.8).value;
            polygonAnnotationManager
                ?.update(_polygonAnnotations.elementAt(index)!);
            _selectedPolygon = _polygonAnnotations.elementAt(index);
          }

          widget.isReport
              ? _showBottomBoxReport(widget.listArea.elementAt(index))
              : _showBottomBoxControl(widget.listArea.elementAt(index));
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
      constraints:
          BoxConstraints(maxHeight: SizeUtils(context).sizeHeight * 0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return ScaffoldMessenger(
          child: Builder(
            builder: (context) => Scaffold(
              backgroundColor: Colors.white,
              body: ItemControlScreenScreen(area: area!, isShowIrrigation: widget.isShowIrrigation),
            ),
          ),
        );
      },
    );
  }

  void _showBottomBoxReport(Area area) {
    _getImages(area.sectorId.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
          return Consumer(
            builder: (context, ref, child) {
              final reportState = ref.watch(reportProvider);

              if (reportState.isLoading) {
                return const Center(child: LoadingWidget());
              }

              if (reportState.value.isNotEmpty) {
                return Image.memory(
                  Uint8List.fromList(reportState.value),
                  fit: BoxFit.contain,
                );
              }

              return const Center(child: Text('No image available'));
            },
          );
        },
      );
    });
  }

  Future<void> _getImages(String sectorId) async {
    await HiveUtils.getValue<Information?>(
            Contant.INFORMATION_LIST, Contant.INFORMATION)
        .then(
      (value) {
        if (value != null) {
          ref
              .read(reportProvider.notifier)
              .getImagesReport(value.authToken.toString(), sectorId);
        }
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
        backgroundColor: Colors.white,
        onPressed: () {
          _flyToAnnotation(widget.listArea.first.center);
        },
        child: const Icon(Icons.my_location),
      ),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        cameraOptions: CameraOptions(
          center: Point(coordinates: widget.listArea.first.center),
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
