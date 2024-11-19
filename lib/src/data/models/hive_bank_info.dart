import 'package:hive/hive.dart';
import 'package:ambush_app/src/domain/models/bank.dart';
import 'package:ambush_app/src/domain/models/bank_info.dart';

part 'hive_bank_info.g.dart';

@HiveType(typeId: 2)
class HiveBankInfo extends HiveObject {
  @HiveField(0)
  String beneficiaryName;

  @HiveField(1)
  String iban;

  @HiveField(2)
  String swift;

  @HiveField(3)
  String bankName;

  @HiveField(4)
  String bankAddress;

  //Optional intermediary bank
  @HiveField(5)
  String? intermediaryIban;

  @HiveField(6)
  String? intermediarySwift;

  @HiveField(7)
  String? intermediaryBankName;

  @HiveField(8)
  String? intermediaryBankAddress;

  HiveBankInfo(
    this.beneficiaryName,
    this.iban,
    this.swift,
    this.bankName,
    this.bankAddress,
    this.intermediaryIban,
    this.intermediarySwift,
    this.intermediaryBankName,
    this.intermediaryBankAddress,
  );

  factory HiveBankInfo.fromDataModel(BankInfo data) => HiveBankInfo(
        data.beneficiaryName,
        data.main.iban,
        data.main.swift,
        data.main.bankName,
        data.main.bankAddress,
        data.intermediary?.iban,
        data.intermediary?.swift,
        data.intermediary?.bankName,
        data.intermediary?.bankAddress,
      );

  BankInfo toDataModel() {
    var mainBank = Bank(
      iban,
      swift,
      bankName,
      bankAddress,
    );

    Bank? intermediaryBank;

    if (intermediaryIban != null &&
        intermediarySwift != null &&
        intermediaryBankName != null &&
        intermediaryBankAddress != null) {
      intermediaryBank = Bank(
        intermediaryIban!,
        intermediarySwift!,
        intermediaryBankName!,
        intermediaryBankAddress!,
      );
    }

    return BankInfo(beneficiaryName, mainBank, intermediaryBank);
  }
}
