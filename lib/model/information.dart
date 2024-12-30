import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'information.g.dart'; // Tạo file này bằng lệnh build_runner

@HiveType(typeId: 0)
class Information extends Equatable {
  @HiveField(0)
  final String? authToken;

  @HiveField(1)
  final List<Client> clients;

  @HiveField(2)
  final User? user;

  const Information({
    required this.authToken,
    required this.clients,
    required this.user,
  });

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      authToken: json["authToken"],
      clients: json["clients"] == null
          ? []
          : List<Client>.from(json["clients"]!.map((x) => Client.fromJson(x))),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "authToken": authToken,
        "clients": clients.map((x) => x.toJson()).toList(),
        "user": user?.toJson(),
      };

  @override
  String toString() {
    return "$authToken, $clients, $user, ";
  }

  @override
  List<Object?> get props => [
        authToken,
        clients,
        user,
      ];
}

@HiveType(typeId: 1)
class Client extends Equatable {
  @HiveField(0)
  final int? groupid;

  @HiveField(1)
  final int? id;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final Opts? opts;

  @HiveField(4)
  final List<int> sectorids;

  @HiveField(5)
  final List<int> sensordeviceids;

  const Client({
    required this.groupid,
    required this.id,
    required this.name,
    required this.opts,
    required this.sectorids,
    required this.sensordeviceids,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      groupid: json["groupid"],
      id: json["id"],
      name: json["name"],
      opts: json["opts"] == null ? null : Opts.fromJson(json["opts"]),
      sectorids: json["sectorids"] == null
          ? []
          : List<int>.from(json["sectorids"]!.map((x) => x)),
      sensordeviceids: json["sensordeviceids"] == null
          ? []
          : List<int>.from(json["sensordeviceids"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "groupid": groupid,
        "id": id,
        "name": name,
        "opts": opts?.toJson(),
        "sectorids": sectorids.map((x) => x).toList(),
        "sensordeviceids": sensordeviceids.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$groupid, $id, $name, $opts, $sectorids, $sensordeviceids, ";
  }

  @override
  List<Object?> get props => [
        groupid,
        id,
        name,
        opts,
        sectorids,
        sensordeviceids,
      ];
}

@HiveType(typeId: 2)
class Opts extends Equatable {
  @HiveField(0)
  final bool? basicSectorsDisplay;

  @HiveField(1)
  final bool? basicSectorsDisplayList;

  @HiveField(2)
  final bool? compositeSectorsDisplayMap;

  @HiveField(3)
  final int? compositeSectorsMainSectorId;

  @HiveField(4)
  final bool? reportsDisplayList;

  @HiveField(5)
  final bool? sensorsDisplayMap;

  @HiveField(6)
  final int? sensorsMainDeviceId;

  const Opts({
    required this.basicSectorsDisplay,
    required this.basicSectorsDisplayList,
    required this.compositeSectorsDisplayMap,
    required this.compositeSectorsMainSectorId,
    required this.reportsDisplayList,
    required this.sensorsDisplayMap,
    required this.sensorsMainDeviceId,
  });

  factory Opts.fromJson(Map<String, dynamic> json) {
    return Opts(
      basicSectorsDisplay: json["basicSectors_display"],
      basicSectorsDisplayList: json["basicSectors_displayList"],
      compositeSectorsDisplayMap: json["compositeSectors_displayMap"],
      compositeSectorsMainSectorId: json["compositeSectors_mainSectorId"],
      reportsDisplayList: json["reports_displayList"],
      sensorsDisplayMap: json["sensors_displayMap"],
      sensorsMainDeviceId: json["sensors_mainDeviceId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "basicSectors_display": basicSectorsDisplay,
        "basicSectors_displayList": basicSectorsDisplayList,
        "compositeSectors_displayMap": compositeSectorsDisplayMap,
        "compositeSectors_mainSectorId": compositeSectorsMainSectorId,
        "reports_displayList": reportsDisplayList,
        "sensors_displayMap": sensorsDisplayMap,
        "sensors_mainDeviceId": sensorsMainDeviceId,
      };

  @override
  String toString() {
    return "$basicSectorsDisplay, $basicSectorsDisplayList, $compositeSectorsDisplayMap, $compositeSectorsMainSectorId, $reportsDisplayList, $sensorsDisplayMap, $sensorsMainDeviceId, ";
  }

  @override
  List<Object?> get props => [
        basicSectorsDisplay,
        basicSectorsDisplayList,
        compositeSectorsDisplayMap,
        compositeSectorsMainSectorId,
        reportsDisplayList,
        sensorsDisplayMap,
        sensorsMainDeviceId,
      ];
}

@HiveType(typeId: 3)
class User extends Equatable {
  @HiveField(0)
  final bool? changepw;

  @HiveField(1)
  final int? createdtime;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final List<dynamic> emplgroupids;

  @HiveField(4)
  final List<int> groupids;

  @HiveField(5)
  final int? id;

  @HiveField(6)
  final String? lastapp;

  @HiveField(7)
  final String? name;

  @HiveField(8)
  final String? password;

  const User({
    required this.changepw,
    required this.createdtime,
    required this.email,
    required this.emplgroupids,
    required this.groupids,
    required this.id,
    required this.lastapp,
    required this.name,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      changepw: json["changepw"],
      createdtime: json["createdtime"],
      email: json["email"],
      emplgroupids: json["emplgroupids"] == null
          ? []
          : List<dynamic>.from(json["emplgroupids"]!.map((x) => x)),
      groupids: json["groupids"] == null
          ? []
          : List<int>.from(json["groupids"]!.map((x) => x)),
      id: json["id"],
      lastapp: json["lastapp"],
      name: json["name"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "changepw": changepw,
        "createdtime": createdtime,
        "email": email,
        "emplgroupids": emplgroupids.map((x) => x).toList(),
        "groupids": groupids.map((x) => x).toList(),
        "id": id,
        "lastapp": lastapp,
        "name": name,
        "password": password,
      };

  @override
  String toString() {
    return "$changepw, $createdtime, $email, $emplgroupids, $groupids, $id, $lastapp, $name, $password, ";
  }

  @override
  List<Object?> get props => [
        changepw,
        createdtime,
        email,
        emplgroupids,
        groupids,
        id,
        lastapp,
        name,
        password,
      ];
}
