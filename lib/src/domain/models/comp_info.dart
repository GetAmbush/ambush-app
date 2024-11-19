import 'package:json_annotation/json_annotation.dart';

part 'comp_info.g.dart';

@JsonSerializable()
class CompanyInfo {
  final String name;
  final CompanyAddress? address;
  final String email;
  final String ownerName;
  final String? cnpj;

  CompanyInfo(
    this.name,
    this.address,
    this.email,
    this.ownerName,
    this.cnpj,
  );

  CompanyInfo.withoutAddress(
    this.name,
    this.email,
    this.ownerName,
    this.cnpj,
  ) : address = null;

  CompanyInfo copyWith({
    String? name,
    CompanyAddress? address,
    String? email,
    String? ownerName,
    String? cnpj,
  }) {
    return CompanyInfo(
      name ?? this.name,
      address ?? this.address,
      email ?? this.email,
      ownerName ?? this.ownerName,
      cnpj ?? this.cnpj,
    );
  }

  factory CompanyInfo.fromJson(Map<String, dynamic> json) =>
      _$CompanyInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyInfoToJson(this);
}

@JsonSerializable()
class CompanyAddress {
  final String street;
  final String? extraInfo;
  final String neighbourhood;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  CompanyAddress(
    this.street,
    this.extraInfo,
    this.neighbourhood,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  );

  factory CompanyAddress.fromJson(Map<String, dynamic> json) =>
      _$CompanyAddressFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyAddressToJson(this);
}
