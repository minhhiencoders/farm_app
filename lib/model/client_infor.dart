import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'client_infor.g.dart'; // File này sẽ được tạo tự động.

@HiveType(typeId: 4)
class ClientInfor extends Equatable {
  @HiveField(0)
  final List<Sector> compositeSectors;

  @HiveField(1)
  final List<Sector> normalSectors;

  @HiveField(2)
  final Map<String, List<dynamic>> sectorScheds;

  @HiveField(3)
  final List<SensorDevice> sensorDevices;

  const ClientInfor({
    required this.compositeSectors,
    required this.normalSectors,
    required this.sectorScheds,
    required this.sensorDevices,
  });

  factory ClientInfor.fromJson(Map<String, dynamic> json) {
    return ClientInfor(
      compositeSectors: (json["compositeSectors"] as List<dynamic>?)
              ?.map((x) => Sector.fromJson(x))
              .toList() ??
          [],
      normalSectors: (json["normalSectors"] as List<dynamic>?)
              ?.map((x) => Sector.fromJson(x))
              .toList() ??
          [],
      sectorScheds: (json["sectorScheds"] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, List<dynamic>.from(value)),
          ) ??
          {},
      sensorDevices: (json["sensorDevices"] as List<dynamic>?)
              ?.map((x) => SensorDevice.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        "compositeSectors":
            compositeSectors.map((sector) => sector.toJson()).toList(),
        "normalSectors":
            normalSectors.map((sector) => sector.toJson()).toList(),
        "sectorScheds": sectorScheds.map(
          (key, value) => MapEntry(key, value.toList()),
        ),
        "sensorDevices":
            sensorDevices.map((device) => device.toJson()).toList(),
      };

  @override
  List<Object?> get props =>
      [compositeSectors, normalSectors, sectorScheds, sensorDevices];

  @override
  String toString() =>
      "ClientInfor(compositeSectors: $compositeSectors, normalSectors: $normalSectors, sectorScheds: $sectorScheds, sensorDevices: $sensorDevices)";
}

@HiveType(typeId: 5)
class Sector extends Equatable {
  @HiveField(0)
  final double? area;

  @HiveField(1)
  final List<double> center;

  @HiveField(2)
  final List<List<double>> coords;

  @HiveField(3)
  final List<dynamic> dailyscheds;

  @HiveField(4)
  final String? descr;

  @HiveField(5)
  final dynamic fertmeta;

  @HiveField(6)
  final Flowmeta? flowmeta;

  @HiveField(7)
  final int? id;

  @HiveField(8)
  final int? mode;

  @HiveField(9)
  final String? name;

  @HiveField(10)
  final String? project;

  @HiveField(11)
  final List<int> seqids;

  @HiveField(12)
  final Spmeta? spmeta;

  @HiveField(13)
  final Spparams? spparams;

  @HiveField(14)
  final int? zoom;

  const Sector({
    required this.area,
    required this.center,
    required this.coords,
    required this.dailyscheds,
    required this.descr,
    required this.fertmeta,
    required this.flowmeta,
    required this.id,
    required this.mode,
    required this.name,
    required this.project,
    required this.seqids,
    required this.spmeta,
    required this.spparams,
    required this.zoom,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      area: json["area"],
      center: (json["center"] as List<dynamic>?)?.cast<double>() ?? [],
      coords: (json["coords"] as List<dynamic>?)
              ?.map((x) => (x as List<dynamic>).cast<double>())
              .toList() ??
          [],
      dailyscheds: (json["dailyscheds"] as List<dynamic>?) ?? [],
      descr: json["descr"],
      fertmeta: json["fertmeta"],
      flowmeta:
          json["flowmeta"] != null ? Flowmeta.fromJson(json["flowmeta"]) : null,
      id: json["id"],
      mode: json["mode"],
      name: json["name"],
      project: json["project"],
      seqids: (json["seqids"] as List<dynamic>?)?.cast<int>() ?? [],
      spmeta: json["spmeta"] != null ? Spmeta.fromJson(json["spmeta"]) : null,
      spparams:
          json["spparams"] != null ? Spparams.fromJson(json["spparams"]) : null,
      zoom: json["zoom"],
    );
  }

  Map<String, dynamic> toJson() => {
        "area": area,
        "center": center,
        "coords": coords,
        "dailyscheds": dailyscheds,
        "descr": descr,
        "fertmeta": fertmeta,
        "flowmeta": flowmeta?.toJson(),
        "id": id,
        "mode": mode,
        "name": name,
        "project": project,
        "seqids": seqids,
        "spmeta": spmeta?.toJson(),
        "spparams": spparams?.toJson(),
        "zoom": zoom,
      };

  @override
  List<Object?> get props => [
        area,
        center,
        coords,
        dailyscheds,
        descr,
        fertmeta,
        flowmeta,
        id,
        mode,
        name,
        project,
        seqids,
        spmeta,
        spparams,
        zoom,
      ];

  @override
  String toString() =>
      "Sector(area: $area, center: $center, coords: $coords, descr: $descr, ...)";
}

@HiveType(typeId: 6)
class Flowmeta extends Equatable {
  @HiveField(0)
  final double? minflow;

  @HiveField(1)
  final double? maxflow;

  const Flowmeta({
    required this.minflow,
    required this.maxflow,
  });

  factory Flowmeta.fromJson(Map<String, dynamic> json) {
    return Flowmeta(
      minflow: json["minflow"],
      maxflow: json["maxflow"],
    );
  }

  Map<String, dynamic> toJson() => {
        "minflow": minflow,
        "maxflow": maxflow,
      };

  @override
  List<Object?> get props => [minflow, maxflow];
}

@HiveType(typeId: 7)
class Spmeta extends Equatable {
  @HiveField(0)
  final String? type;

  @HiveField(1)
  final Map<String, dynamic> parameters;

  const Spmeta({
    required this.type,
    required this.parameters,
  });

  factory Spmeta.fromJson(Map<String, dynamic> json) {
    return Spmeta(
      type: json["type"],
      parameters: (json["parameters"] as Map<String, dynamic>?) ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "parameters": parameters,
      };

  @override
  List<Object?> get props => [type, parameters];
}

@HiveType(typeId: 8)
class Spparams extends Equatable {
  @HiveField(0)
  final double? param1;

  @HiveField(1)
  final int? param2;

  const Spparams({
    required this.param1,
    required this.param2,
  });

  factory Spparams.fromJson(Map<String, dynamic> json) {
    return Spparams(
      param1: json["param1"],
      param2: json["param2"],
    );
  }

  Map<String, dynamic> toJson() => {
        "param1": param1,
        "param2": param2,
      };

  @override
  List<Object?> get props => [param1, param2];
}

@HiveType(typeId: 9)
class SensorDevice extends Equatable {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? type;

  @HiveField(2)
  final Map<String, dynamic> data;

  const SensorDevice({
    required this.id,
    required this.type,
    required this.data,
  });

  factory SensorDevice.fromJson(Map<String, dynamic> json) {
    return SensorDevice(
      id: json["id"],
      type: json["type"],
      data: (json["data"] as Map<String, dynamic>?) ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "data": data,
      };

  @override
  List<Object?> get props => [id, type, data];
}

@HiveType(typeId: 10)
class Fertmeta extends Equatable {
  @HiveField(0)
  final String? fertilizerType;

  @HiveField(1)
  final double? quantity;

  const Fertmeta({
    required this.fertilizerType,
    required this.quantity,
  });

  factory Fertmeta.fromJson(Map<String, dynamic> json) {
    return Fertmeta(
      fertilizerType: json["fertilizerType"],
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fertilizerType": fertilizerType,
        "quantity": quantity,
      };

  @override
  List<Object?> get props => [fertilizerType, quantity];
}
