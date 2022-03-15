// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_time_nickname.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletTimeNicknameAdapter extends TypeAdapter<WalletTimeNickname> {
  @override
  final int typeId = 1;

  @override
  WalletTimeNickname read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletTimeNickname(
      chatId: fields[0] as String,
      wallet: fields[1] as String,
      time: fields[2] as DateTime,
      nickname: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WalletTimeNickname obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.chatId)
      ..writeByte(1)
      ..write(obj.wallet)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.nickname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletTimeNicknameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
