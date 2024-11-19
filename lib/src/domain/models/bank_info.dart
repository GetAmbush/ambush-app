import 'package:ambush_app/src/domain/models/bank.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bank_info.g.dart';

@JsonSerializable()
class BankInfo {
  final String beneficiaryName;
  final Bank main;
  final Bank? intermediary;

  BankInfo(
    this.beneficiaryName,
    this.main,
    this.intermediary,
  );

  factory BankInfo.fromJson(Map<String, dynamic> json) =>
      _$BankInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BankInfoToJson(this);
}
