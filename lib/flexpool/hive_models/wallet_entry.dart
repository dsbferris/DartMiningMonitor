import 'package:dart_mining_monitor/flexpool/api_models/workers_response.dart';
import 'package:hive/hive.dart';

part 'wallet_entry.g.dart';

@HiveType(typeId: 2)
class WalletEntry extends HiveObject{
  WalletEntry({required this.wallet, required this.workers});

  @HiveField(0)
  final String wallet;

  @HiveField(1)
  final List<WorkersResponse> workers;


}
