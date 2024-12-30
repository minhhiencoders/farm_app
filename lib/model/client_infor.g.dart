// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_infor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientInforAdapter extends TypeAdapter<ClientInfor> {
  @override
  final int typeId = 4;

  @override
  ClientInfor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientInfor(
      compositeSectors: (fields[0] as List).cast<Sector>(),
      normalSectors: (fields[1] as List).cast<Sector>(),
      sectorScheds: (fields[2] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<dynamic>())),
      sensorDevices: (fields[3] as List).cast<SensorDevice>(),
    );
  }

  @override
  void write(BinaryWriter writer, ClientInfor obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.compositeSectors)
      ..writeByte(1)
      ..write(obj.normalSectors)
      ..writeByte(2)
      ..write(obj.sectorScheds)
      ..writeByte(3)
      ..write(obj.sensorDevices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientInforAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SectorAdapter extends TypeAdapter<Sector> {
  @override
  final int typeId = 5;

  @override
  Sector read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sector(
      area: fields[0] as double?,
      center: (fields[1] as List).cast<double>(),
      coords: (fields[2] as List)
          .map((dynamic e) => (e as List).cast<double>())
          .toList(),
      dailyscheds: (fields[3] as List).cast<dynamic>(),
      descr: fields[4] as String?,
      fertmeta: fields[5] as dynamic,
      flowmeta: fields[6] as Flowmeta?,
      id: fields[7] as int?,
      mode: fields[8] as int?,
      name: fields[9] as String?,
      project: fields[10] as String?,
      seqids: (fields[11] as List).cast<int>(),
      spmeta: fields[12] as Spmeta?,
      spparams: fields[13] as Spparams?,
      zoom: fields[14] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Sector obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.area)
      ..writeByte(1)
      ..write(obj.center)
      ..writeByte(2)
      ..write(obj.coords)
      ..writeByte(3)
      ..write(obj.dailyscheds)
      ..writeByte(4)
      ..write(obj.descr)
      ..writeByte(5)
      ..write(obj.fertmeta)
      ..writeByte(6)
      ..write(obj.flowmeta)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.mode)
      ..writeByte(9)
      ..write(obj.name)
      ..writeByte(10)
      ..write(obj.project)
      ..writeByte(11)
      ..write(obj.seqids)
      ..writeByte(12)
      ..write(obj.spmeta)
      ..writeByte(13)
      ..write(obj.spparams)
      ..writeByte(14)
      ..write(obj.zoom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FlowmetaAdapter extends TypeAdapter<Flowmeta> {
  @override
  final int typeId = 6;

  @override
  Flowmeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Flowmeta(
      minflow: fields[0] as double?,
      maxflow: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Flowmeta obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.minflow)
      ..writeByte(1)
      ..write(obj.maxflow);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlowmetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpmetaAdapter extends TypeAdapter<Spmeta> {
  @override
  final int typeId = 7;

  @override
  Spmeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spmeta(
      type: fields[0] as String?,
      parameters: (fields[1] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Spmeta obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.parameters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpmetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpparamsAdapter extends TypeAdapter<Spparams> {
  @override
  final int typeId = 8;

  @override
  Spparams read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spparams(
      param1: fields[0] as double?,
      param2: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Spparams obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.param1)
      ..writeByte(1)
      ..write(obj.param2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpparamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SensorDeviceAdapter extends TypeAdapter<SensorDevice> {
  @override
  final int typeId = 9;

  @override
  SensorDevice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SensorDevice(
      id: fields[0] as int?,
      type: fields[1] as String?,
      data: (fields[2] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, SensorDevice obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SensorDeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FertmetaAdapter extends TypeAdapter<Fertmeta> {
  @override
  final int typeId = 10;

  @override
  Fertmeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fertmeta(
      fertilizerType: fields[0] as String?,
      quantity: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Fertmeta obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.fertilizerType)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FertmetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
