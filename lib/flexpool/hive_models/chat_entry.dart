import 'package:hive/hive.dart';

part 'chat_entry.g.dart';

@HiveType(typeId: 1)
class ChatEntry extends HiveObject{
  ChatEntry({required this.chatId, required this.wallet, required this.requestTime, required this.nickname, required this.notifyTime});

  @HiveField(0)
  final String chatId;

  @HiveField(1)
  final String wallet;

  @HiveField(2)
  DateTime requestTime;

  @HiveField(3)
  DateTime notifyTime;

  @HiveField(4)
  String nickname;
}
