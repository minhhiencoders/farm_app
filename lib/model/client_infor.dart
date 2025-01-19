import 'package:equatable/equatable.dart';

class ClientInfor extends Equatable {
  ClientInfor({
    required this.compositeSectors,
    required this.normalSectors,
    required this.sectorScheds,
    required this.sensorDevices,
  });

  final List<Sector> compositeSectors;
  final List<Sector> normalSectors;
  final Map<String, List<dynamic>> sectorScheds;
  final List<SensorDevice> sensorDevices;

  factory ClientInfor.fromJson(Map<String, dynamic> json) {
    return ClientInfor(
      compositeSectors: json["compositeSectors"] == null
          ? []
          : List<Sector>.from(
              json["compositeSectors"]!.map((x) => Sector.fromJson(x))),
      normalSectors: json["normalSectors"] == null
          ? []
          : List<Sector>.from(
              json["normalSectors"]!.map((x) => Sector.fromJson(x))),
      sectorScheds: Map.from(json["sectorScheds"]).map((k, v) =>
          MapEntry<String, List<dynamic>>(
              k, v == null ? [] : List<dynamic>.from(v!.map((x) => x)))),
      sensorDevices: json["sensorDevices"] == null
          ? []
          : List<SensorDevice>.from(
              json["sensorDevices"]!.map((x) => SensorDevice.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "compositeSectors": compositeSectors.map((x) => x?.toJson()).toList(),
        "normalSectors": normalSectors.map((x) => x?.toJson()).toList(),
        "sectorScheds": Map.from(sectorScheds).map(
            (k, v) => MapEntry<String, dynamic>(k, v.map((x) => x).toList())),
        "sensorDevices": sensorDevices.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$compositeSectors, $normalSectors, $sectorScheds, $sensorDevices, ";
  }

  @override
  List<Object?> get props => [
        compositeSectors,
        normalSectors,
        sectorScheds,
        sensorDevices,
      ];
}

class Sector extends Equatable {
  Sector({
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

  final double? area;
  final List<double> center;
  final List<List<double>> coords;
  final List<dynamic> dailyscheds;
  final String? descr;
  final dynamic fertmeta;
  final Flowmeta? flowmeta;
  final int? id;
  final int? mode;
  final String? name;
  final String? project;
  final List<int> seqids;
  final Spmeta? spmeta;
  final Spparams? spparams;
  final int? zoom;

  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(
      area: json["area"],
      center: json["center"] == null
          ? []
          : List<double>.from(json["center"]!.map((x) => x)),
      coords: json["coords"] == null
          ? []
          : List<List<double>>.from(json["coords"]!.map(
              (x) => x == null ? [] : List<double>.from(x!.map((x) => x)))),
      dailyscheds: json["dailyscheds"] == null
          ? []
          : List<dynamic>.from(json["dailyscheds"]!.map((x) => x)),
      descr: json["descr"],
      fertmeta: json["fertmeta"],
      flowmeta:
          json["flowmeta"] == null ? null : Flowmeta.fromJson(json["flowmeta"]),
      id: json["id"],
      mode: json["mode"],
      name: json["name"],
      project: json["project"],
      seqids: json["seqids"] == null
          ? []
          : List<int>.from(json["seqids"]!.map((x) => x)),
      spmeta: json["spmeta"] == null ? null : Spmeta.fromJson(json["spmeta"]),
      spparams:
          json["spparams"] == null ? null : Spparams.fromJson(json["spparams"]),
      zoom: json["zoom"],
    );
  }

  Map<String, dynamic> toJson() => {
        "area": area,
        "center": center.map((x) => x).toList(),
        "coords": coords.map((x) => x.map((x) => x).toList()).toList(),
        "dailyscheds": dailyscheds.map((x) => x).toList(),
        "descr": descr,
        "fertmeta": fertmeta,
        "flowmeta": flowmeta?.toJson(),
        "id": id,
        "mode": mode,
        "name": name,
        "project": project,
        "seqids": seqids.map((x) => x).toList(),
        "spmeta": spmeta?.toJson(),
        "spparams": spparams?.toJson(),
        "zoom": zoom,
      };

  @override
  String toString() {
    return "$area, $center, $coords, $dailyscheds, $descr, $fertmeta, $flowmeta, $id, $mode, $name, $project, $seqids, $spmeta, $spparams, $zoom, ";
  }

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
}

class Flowmeta extends Equatable {
  Flowmeta({
    required this.deviceId,
    required this.mode,
    required this.pin,
    required this.rate,
  });

  final int? deviceId;
  final int? mode;
  final int? pin;
  final double? rate;

  factory Flowmeta.fromJson(Map<String, dynamic> json) {
    return Flowmeta(
      deviceId: json["deviceId"],
      mode: json["mode"],
      pin: json["pin"],
      rate: json["rate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "mode": mode,
        "pin": pin,
        "rate": rate,
      };

  @override
  String toString() {
    return "$deviceId, $mode, $pin, $rate, ";
  }

  @override
  List<Object?> get props => [
        deviceId,
        mode,
        pin,
        rate,
      ];
}

class Spmeta extends Equatable {
  Spmeta({
    required this.lastUpdate,
    required this.rhPin,
    required this.sensorDeviceId,
    required this.tempPin,
    required this.timesActivatedToday,
  });

  final String? lastUpdate;
  final int? rhPin;
  final int? sensorDeviceId;
  final int? tempPin;
  final int? timesActivatedToday;

  factory Spmeta.fromJson(Map<String, dynamic> json) {
    return Spmeta(
      lastUpdate: json["lastUpdate"].toString(),
      rhPin: json["rhPin"],
      sensorDeviceId: json["sensorDeviceId"],
      tempPin: json["tempPin"],
      timesActivatedToday: json["timesActivatedToday"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lastUpdate": lastUpdate,
        "rhPin": rhPin,
        "sensorDeviceId": sensorDeviceId,
        "tempPin": tempPin,
        "timesActivatedToday": timesActivatedToday,
      };

  @override
  String toString() {
    return "$lastUpdate, $rhPin, $sensorDeviceId, $tempPin, $timesActivatedToday, ";
  }

  @override
  List<Object?> get props => [
        lastUpdate,
        rhPin,
        sensorDeviceId,
        tempPin,
        timesActivatedToday,
      ];
}

class Spparams extends Equatable {
  Spparams({
    required this.duration,
    required this.maxPerDay,
    required this.maxTemp,
    required this.minRh,
  });

  final dynamic duration;
  final dynamic maxPerDay;
  final dynamic maxTemp;
  final dynamic minRh;

  factory Spparams.fromJson(Map<String, dynamic> json) {
    return Spparams(
      duration: json["duration"],
      maxPerDay: json["maxPerDay"],
      maxTemp: json["maxTemp"],
      minRh: json["minRH"],
    );
  }

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "maxPerDay": maxPerDay,
        "maxTemp": maxTemp,
        "minRH": minRh,
      };

  @override
  String toString() {
    return "$duration, $maxPerDay, $maxTemp, $minRh, ";
  }

  @override
  List<Object?> get props => [
        duration,
        maxPerDay,
        maxTemp,
        minRh,
      ];
}

class SensorDevice extends Equatable {
  SensorDevice({
    required this.coord,
    required this.description,
    required this.email,
    required this.frclientpins,
    required this.freq,
    required this.frfake,
    required this.frmeta,
    required this.frtrans,
    required this.id,
    required this.lastboot,
    required this.lastseen,
    required this.model,
    required this.project,
    required this.server,
    required this.version,
  });

  final List<double> coord;
  final String? description;
  final bool? email;
  final List<int> frclientpins;
  final double? freq;
  final dynamic frfake;
  final List<Frmeta> frmeta;
  final List<List<double>> frtrans;
  final int? id;
  final dynamic lastboot;
  final int? lastseen;
  final String? model;
  final String? project;
  final String? server;
  final int? version;

  factory SensorDevice.fromJson(Map<String, dynamic> json) {
    return SensorDevice(
      coord: json["coord"] == null
          ? []
          : List<double>.from(json["coord"]!.map((x) => x)),
      description: json["description"],
      email: json["email"],
      frclientpins: json["frclientpins"] == null
          ? []
          : List<int>.from(json["frclientpins"]!.map((x) => x)),
      freq: json["freq"],
      frfake: json["frfake"],
      frmeta: json["frmeta"] == null
          ? []
          : List<Frmeta>.from(json["frmeta"]!.map((x) => Frmeta.fromJson(x))),
      frtrans: json["frtrans"] == null || json is! List<List<double>>
          ? []
          : List<List<double>>.from(json["frtrans"]!.map(
              (x) => x == null
              ? []
              : List<double>.from(x!.map((value) => value.toDouble())))),
      id: json["id"],
      lastboot: json["lastboot"],
      lastseen: json["lastseen"],
      model: json["model"],
      project: json["project"],
      server: json["server"],
      version: json["version"],
    );
  }

  Map<String, dynamic> toJson() => {
        "coord": coord.map((x) => x).toList(),
        "description": description,
        "email": email,
        "frclientpins": frclientpins.map((x) => x).toList(),
        "freq": freq,
        "frfake": frfake,
        "frmeta": frmeta.map((x) => x?.toJson()).toList(),
        "frtrans": frtrans.map((x) => x.map((x) => x).toList()).toList(),
        "id": id,
        "lastboot": lastboot,
        "lastseen": lastseen,
        "model": model,
        "project": project,
        "server": server,
        "version": version,
      };

  @override
  String toString() {
    return "$coord, $description, $email, $frclientpins, $freq, $frfake, $frmeta, $frtrans, $id, $lastboot, $lastseen, $model, $project, $server, $version, ";
  }

  @override
  List<Object?> get props => [
        coord,
        description,
        email,
        frclientpins,
        freq,
        frfake,
        frmeta,
        frtrans,
        id,
        lastboot,
        lastseen,
        model,
        project,
        server,
        version,
      ];
}

class Frmeta extends Equatable {
  Frmeta({
    required this.header,
    required this.ylabel,
  });

  final List<String> header;
  final String? ylabel;

  factory Frmeta.fromJson(Map<String, dynamic> json) {
    return Frmeta(
      header: json["header"] == null
          ? []
          : List<String>.from(json["header"]!.map((x) => x)),
      ylabel: json["ylabel"],
    );
  }

  Map<String, dynamic> toJson() => {
        "header": header.map((x) => x).toList(),
        "ylabel": ylabel,
      };

  @override
  String toString() {
    return "$header, $ylabel, ";
  }

  @override
  List<Object?> get props => [
        header,
        ylabel,
      ];
}
