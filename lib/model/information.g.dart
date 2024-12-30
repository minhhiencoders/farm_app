// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InformationAdapter extends TypeAdapter<Information> {
  @override
  final int typeId = 0;

  @override
  Information read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Information(
      authToken: fields[0] as String?,
      clients: (fields[1] as List).cast<Client>(),
      user: fields[2] as User?,
    );
  }

  @override
  void write(BinaryWriter writer, Information obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.authToken)
      ..writeByte(1)
      ..write(obj.clients)
      ..writeByte(2)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InformationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClientAdapter extends TypeAdapter<Client> {
  @override
  final int typeId = 1;

  @override
  Client read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Client(
      groupid: fields[0] as int?,
      id: fields[1] as int?,
      name: fields[2] as String?,
      opts: fields[3] as Opts?,
      sectorids: (fields[4] as List).cast<int>(),
      sensordeviceids: (fields[5] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Client obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.groupid)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.opts)
      ..writeByte(4)
      ..write(obj.sectorids)
      ..writeByte(5)
      ..write(obj.sensordeviceids);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OptsAdapter extends TypeAdapter<Opts> {
  @override
  final int typeId = 2;

  @override
  Opts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Opts(
      basicSectorsDisplay: fields[0] as bool?,
      basicSectorsDisplayList: fields[1] as bool?,
      compositeSectorsDisplayMap: fields[2] as bool?,
      compositeSectorsMainSectorId: fields[3] as int?,
      reportsDisplayList: fields[4] as bool?,
      sensorsDisplayMap: fields[5] as bool?,
      sensorsMainDeviceId: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Opts obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.basicSectorsDisplay)
      ..writeByte(1)
      ..write(obj.basicSectorsDisplayList)
      ..writeByte(2)
      ..write(obj.compositeSectorsDisplayMap)
      ..writeByte(3)
      ..write(obj.compositeSectorsMainSectorId)
      ..writeByte(4)
      ..write(obj.reportsDisplayList)
      ..writeByte(5)
      ..write(obj.sensorsDisplayMap)
      ..writeByte(6)
      ..write(obj.sensorsMainDeviceId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      changepw: fields[0] as bool?,
      createdtime: fields[1] as int?,
      email: fields[2] as String?,
      emplgroupids: (fields[3] as List).cast<dynamic>(),
      groupids: (fields[4] as List).cast<int>(),
      id: fields[5] as int?,
      lastapp: fields[6] as String?,
      name: fields[7] as String?,
      password: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.changepw)
      ..writeByte(1)
      ..write(obj.createdtime)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.emplgroupids)
      ..writeByte(4)
      ..write(obj.groupids)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.lastapp)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
