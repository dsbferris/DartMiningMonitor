// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletEntryAdapter extends TypeAdapter<WalletEntry> {
  @override
  final int typeId = 2;

  @override
  WalletEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletEntry(
      wallet: fields[0] as String,
      workers: (fields[1] as List).cast<WorkersResponse>(),
    );
  }

  @override
  void write(BinaryWriter writer, WalletEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.wallet)
      ..writeByte(1)
      ..write(obj.workers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
