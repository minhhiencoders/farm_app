import 'package:equatable/equatable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'client_infor.dart';
import 'daily_timer.dart';

class Area extends Equatable {
  final List<List<Position>> positions;
  final String nameSector;
  final Position center;
  final double? acreage;
  final Spmeta? spmeta;
  final int? sectorId;
  final List<DailyTimer> listDailyTimer;
  const Area(
      {required this.positions,
      required this.nameSector,
      required this.center,
      required this.acreage,
      required this.spmeta,
      required this.sectorId,
      required this.listDailyTimer});

  @override
  List<Object?> get props => [positions, nameSector, center, acreage, spmeta, sectorId, listDailyTimer];
}
