import 'package:hive/hive.dart';

part 'wallet_time_nickname.g.dart';

@HiveType(typeId: 1)
class WalletTimeNickname extends HiveObject{
  WalletTimeNickname({required this.chatId, required this.wallet, required this.time, required this.nickname});

  @HiveField(0)
  String chatId;

  @HiveField(1)
  String wallet;

  @HiveField(2)
  DateTime time;

  @HiveField(3)
  String? nickname;
}
