import 'package:equatable/equatable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'client_infor.dart';

class Area extends Equatable{


  final List<List<Position>> positions;
  final String nameSector;
  final Position center;
  final double? acreage;
  final Spmeta? spmeta;
  final
  const Area({required this.positions, required this.nameSector, required this.center, required this.acreage, required this.spmeta});

  @override
  List<Object?> get props => [positions, nameSector, center];

}