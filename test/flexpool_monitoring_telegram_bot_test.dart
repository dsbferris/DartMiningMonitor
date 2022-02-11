import 'package:flexpool_monitoring_telegram_bot/models/workers_response.dart';
import 'package:test/test.dart';
import 'package:flexpool_monitoring_telegram_bot/flexpool_monitoring_telegram_bot.dart';
import 'package:flexpool_monitoring_telegram_bot/flexpool_api.dart' as api;

void main(){
  apiTests();
  workerPlusOperatorTests();
}


void workerPlusOperatorTests(){
  group("Worker + Operator", () {
    test("Adding two null workers", (){
      Worker w1 = Worker(
        averageEffectiveHashrate: null,
        currentEffectiveHashrate: null,
        reportedHashrate: null,
        invalidShares: null,
        staleShares: null,
        validShares: null,
        name: "test",
        lastSeen: null,
        isOnline: null,
        count: null,
      );
      Worker w2 = w1 + w1;
      expect(w2.name, equals("test"));
      for(var s in [w2.validShares, w2.staleShares, w2.invalidShares,
        w2.averageEffectiveHashrate, w2.currentEffectiveHashrate, w2.reportedHashrate,
        w2.isOnline, w2.lastSeen, w2.count]){
          expect(s, isNull);
      }
    });
    test("Adding null worker with valid worker", () {
      Worker w1 = Worker(
        averageEffectiveHashrate: null,
        currentEffectiveHashrate: null,
        reportedHashrate: null,
        invalidShares: null,
        staleShares: null,
        validShares: null,
        name: "test",
        lastSeen: null,
        isOnline: null,
        count: null,
      );
      Worker w2 = Worker.fromJson(w1.toJson()); //using to trick to clone
      w2
        ..validShares = 1
        ..staleShares = 2
        ..invalidShares = 3
        ..name = "test2";
      Worker w3 = w1 + w2;
      expect(w3.name, equals("test2"));
      expect(w3.validShares, 1);
      expect(w3.staleShares, 2);
      expect(w3.invalidShares, 3);

      for(var s in [w3.averageEffectiveHashrate, w3.currentEffectiveHashrate, w3.reportedHashrate,
        w3.isOnline, w3.lastSeen, w3.count]){
        expect(s, isNull);
      }
    });
    test("Adding valid worker to null worker", (){
      Worker w1 = Worker(
        averageEffectiveHashrate: null,
        currentEffectiveHashrate: null,
        reportedHashrate: null,
        invalidShares: null,
        staleShares: null,
        validShares: null,
        name: "test",
        lastSeen: null,
        isOnline: null,
        count: null,
      );
      Worker w2 = Worker.fromJson(w1.toJson()); //using to trick to clone
      w2
        ..validShares = 1
        ..staleShares = 2
        ..invalidShares = 3
        ..name = "test2";
      Worker w3 = w2 + w1;
      expect(w3.name, equals("test"));
      expect(w3.validShares, 1);
      expect(w3.staleShares, 2);
      expect(w3.invalidShares, 3);

      for(var s in [w3.averageEffectiveHashrate, w3.currentEffectiveHashrate, w3.reportedHashrate,
        w3.isOnline, w3.lastSeen, w3.count]){
        expect(s, isNull);
      }
    });
    test("Adding valid worker to zero worker", () {
      Worker w1 = Worker(
        averageEffectiveHashrate: null,
        currentEffectiveHashrate: null,
        reportedHashrate: null,
        validShares: 1,
        staleShares: 2,
        invalidShares: 3,
        name: "test",
        lastSeen: null,
        isOnline: null,
        count: null,
      );
      Worker w2 = Worker.fromJson(w1.toJson()); //using to trick to clone
      w2
        ..validShares = 0
        ..staleShares = 0
        ..invalidShares = 0
        ..name = "test2";
      Worker w3 = w1 + w2;
      expect(w3.name, equals("test2"));
      expect(w3.validShares, 1);
      expect(w3.staleShares, 2);
      expect(w3.invalidShares, 3);

      for(var s in [w3.averageEffectiveHashrate, w3.currentEffectiveHashrate, w3.reportedHashrate,
        w3.isOnline, w3.lastSeen, w3.count]){
        expect(s, isNull);
      }
    });
    test("Adding zero worker to valid worker", () {
      Worker w1 = Worker(
        averageEffectiveHashrate: null,
        currentEffectiveHashrate: null,
        reportedHashrate: null,
        validShares: 1,
        staleShares: 2,
        invalidShares: 3,
        name: "test",
        lastSeen: null,
        isOnline: null,
        count: null,
      );
      Worker w2 = Worker.fromJson(w1.toJson()); //using to trick to clone
      w2
        ..validShares = 0
        ..staleShares = 0
        ..invalidShares = 0
        ..name = "test2";
      Worker w3 = w1 + w2;
      expect(w3.name, equals("test2"));
      expect(w3.validShares, 1);
      expect(w3.staleShares, 2);
      expect(w3.invalidShares, 3);

      for(var s in [w3.averageEffectiveHashrate, w3.currentEffectiveHashrate, w3.reportedHashrate,
        w3.isOnline, w3.lastSeen, w3.count]){
        expect(s, isNull);
      }
    });
    test("Adding valid worker to valid worker", () {
      Worker w1 = Worker(
        averageEffectiveHashrate: null,
        currentEffectiveHashrate: null,
        reportedHashrate: null,
        validShares: 0,
        staleShares: 0,
        invalidShares: 0,
        name: "test",
        lastSeen: null,
        isOnline: null,
        count: null,
      );
      Worker w2 = Worker.fromJson(w1.toJson()); //using to trick to clone
      w2
        ..validShares = 1
        ..staleShares = 2
        ..invalidShares = 3
        ..name = "test2";
      Worker w3 = w1 + w2;
      expect(w3.name, equals("test2"));
      expect(w3.validShares, 1);
      expect(w3.staleShares, 2);
      expect(w3.invalidShares, 3);

      for(var s in [w3.averageEffectiveHashrate, w3.currentEffectiveHashrate, w3.reportedHashrate,
        w3.isOnline, w3.lastSeen, w3.count]){
        expect(s, isNull);
      }
    });
  });
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
