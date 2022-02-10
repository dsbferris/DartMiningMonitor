import 'package:test/test.dart';
import 'package:flexpool_monitoring_telegram_bot/flexpool_monitoring_telegram_bot.dart';
import 'package:flexpool_monitoring_telegram_bot/flexpool_api.dart' as api;

void main(){
  test('calculate', () {
    expect(calculate(), 42);
  });

  apiTests();
}

void apiTests(){
  group("API", () {
    test("getPayments should return valid values", () async {
      var value = await api.getPayments();
      var result = value.result;
      expect(result, isNotNull);
      if(result != null){
        for(var s in [result.countervalue, result.totalItems, result.totalPages]){
          expect(s, allOf(isNotNull, isNonNegative));
        }
        var data = result.data;
        expect(data, isNotNull);
        if(data != null){
          for(var payout in data){
            expect(payout.hash, allOf(isNotNull, isNotEmpty));
            expect(payout.confirmed, isNotNull);
            for(var s in [
              payout.value,
              payout.fee,
              payout.feePercent,
              payout.timestamp,
              payout.duration,
              payout.confirmedTimestamp]){
              expect(s, allOf([
                isNotNull,
                isNonNegative
              ]));
            }
          }
        }
      }
    });

    test("getWorkers should return valid values", () async {
      var value = await api.getWorkers();
      var result = value.result;
      expect(result, isNotNull);
      if(result != null){
        for(var worker in result){
          expect(worker.isOnline, isNotNull);
          expect(worker.name, allOf(isNotNull, isNotEmpty));
          for(var s in [
            worker.validShares,
            worker.staleShares,
            worker.invalidShares,
            worker.reportedHashrate,
            worker.currentEffectiveHashrate,
            worker.averageEffectiveHashrate])
          {
            expect(s, allOf([
              isNotNull,
              isNonNegative
            ]));
          }

        }
      }
    });

    test("getDailyRewardPerGigahashSec should return valid values", () async {
      var value = await api.getDailyRewardPerGigahashSec();
      //14260797478567902
      var result = value.result;
      expect(result, allOf([
        isNotNull,
        isNonZero,
        isPositive
        //I would not give any more limitation, as this value is not foreseeable
      ]));
    });

    test("getMinerStats should return valid values", () async {
      var value = await api.getMinerStats();
      var result = value.result;
      expect(result, isNotNull);
      if(result != null){
        expect(result.averageEffectiveHashrate, allOf([
          isNotNull,
          isPositive
        ]));
      }
    });

    test("getBalance should return valid values", () async {
      var value = await api.getBalance();
      //    "balance": 35937586098366776,
      //    "balanceCountervalue": 102.43,
      //    "price": 2850.26
      var result = value.result;
      expect(result, isNotNull);
      if(result != null){
        expect(result.balance, allOf([
          isNotNull,
          isNonZero, //yeah i can be zero, but you gotta have god like time luck to achieve this
          isPositive
        ]));
        expect(result.balanceCountervalue, allOf([
          isNotNull,
          isNonZero,
          isPositive
        ]));
        expect(result.price, allOf([
          isNotNull,
          isNonZero,
          isPositive
        ]));
      }
    });
  });
}
