import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable()
class Bank {
  final String iban;
  final String swift;
  final String bankName;
  final String bankAddress;

  Bank(
    this.iban,
    this.swift,
    this.bankName,
    this.bankAddress,
  );

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
  Map<String, dynamic> toJson() => _$BankToJson(this);
}
