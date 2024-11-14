import 'package:hive/hive.dart';
import 'package:ambush_app/src/domain/models/bank.dart';
import 'package:ambush_app/src/domain/models/bank_info.dart';

part 'hive_bank_info.g.dart';

const _keyBenefitiaryName = 'benefitiary_name';
const _keyIban = 'iban';
const _keySwift = 'swift';
const _keyBankName = 'bank_name';
const _keyBankAddress = 'bank_address';
const _keyIntermediaryIban = 'intermediary_iban';
const _keyIntermediarySwift = 'intermediary_swift';
const _keyIntermediaryBankName = 'intermediary_bank_name';
const _keyIntermediaryBankAddress = 'intermediary_bank_address';

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

  Map<String, dynamic> toJson() => {
        _keyBenefitiaryName: beneficiaryName,
        _keyIban: iban,
        _keySwift: swift,
        _keyBankName: bankName,
        _keyBankAddress: bankAddress,
        _keyIntermediaryIban: intermediaryIban,
        _keyIntermediarySwift: intermediarySwift,
        _keyIntermediaryBankAddress: intermediaryBankAddress,
        _keyIntermediaryBankName: intermediaryBankName
      };

  factory HiveBankInfo.fromJson(Map<String, dynamic> json) => HiveBankInfo(
      json[_keyBenefitiaryName].toString(),
      json[_keyIban].toString(),
      json[_keySwift].toString(),
      json[_keyBankName].toString(),
      json[_keyBankAddress].toString(),
      (json[_keyIntermediaryIban] != null)
          ? json[_keyIntermediaryIban].toString()
          : null,
      (json[_keyIntermediarySwift] != null)
          ? json[_keyIntermediarySwift].toString()
          : null,
      (json[_keyIntermediaryBankName] != null)
          ? json[_keyIntermediaryBankName].toString()
          : null,
      (json[_keyIntermediaryBankAddress] != null)
          ? json[_keyIntermediaryBankAddress].toString()
          : null);
}
