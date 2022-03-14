// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workers_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkerAdapter extends TypeAdapter<Worker> {
  @override
  final int typeId = 0;

  @override
  Worker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Worker(
      name: fields[0] as String?,
      isOnline: fields[4] as bool?,
      count: fields[5] as num?,
      reportedHashrate: fields[6] as num?,
      currentEffectiveHashrate: fields[7] as num?,
      averageEffectiveHashrate: fields[8] as num?,
      validShares: fields[1] as num?,
      staleShares: fields[2] as num?,
      invalidShares: fields[3] as num?,
      lastSeen: fields[9] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, Worker obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.validShares)
      ..writeByte(2)
      ..write(obj.staleShares)
      ..writeByte(3)
      ..write(obj.invalidShares)
      ..writeByte(4)
      ..write(obj.isOnline)
      ..writeByte(5)
      ..write(obj.count)
      ..writeByte(6)
      ..write(obj.reportedHashrate)
      ..writeByte(7)
      ..write(obj.currentEffectiveHashrate)
      ..writeByte(8)
      ..write(obj.averageEffectiveHashrate)
      ..writeByte(9)
      ..write(obj.lastSeen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
