// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatEntryAdapter extends TypeAdapter<ChatEntry> {
  @override
  final int typeId = 1;

  @override
  ChatEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatEntry(
      chatId: fields[0] as String,
      wallet: fields[1] as String,
      requestTime: fields[2] as DateTime,
      nickname: fields[4] as String,
      notifyTime: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ChatEntry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.chatId)
      ..writeByte(1)
      ..write(obj.wallet)
      ..writeByte(2)
      ..write(obj.requestTime)
      ..writeByte(3)
      ..write(obj.notifyTime)
      ..writeByte(4)
      ..write(obj.nickname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
