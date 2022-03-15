import 'package:hive/hive.dart';

part 'wallet_entry.g.dart';

@HiveType(typeId: 2)
class WalletEntry extends HiveObject{
  WalletEntry();

  @HiveField(0)
  final String wallet;

  @HiveField

}
