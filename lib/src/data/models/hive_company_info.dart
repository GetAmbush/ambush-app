import 'package:hive/hive.dart';
import 'package:ambush_app/src/domain/models/comp_info.dart';

part 'hive_company_info.g.dart';

const _keyStreet = 'street';
const _keyAddress = 'address';
const _keyEmail = 'email';
const _keyOwnerName = 'owner_name';
const _keyCnpj = 'cnpj';
const _keyName = 'name';
const _keyExtraInfo = 'extra_info';
const _keyNeighbourhood = 'neighbourhood';
const _keyCity = 'city';
const _keyState = 'state';
const _keyCountry = 'country';
const _keyZipcode = 'zipcode';

@HiveType(typeId: 1)
class HiveCompanyInfo extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1, defaultValue: null)
  HiveCompanyAddress? address;

  @HiveField(2, defaultValue: '')
  String email;

  @HiveField(3, defaultValue: '')
  String ownerName;

  @HiveField(4, defaultValue: null)
  String? cnpj;

  HiveCompanyInfo(
    this.name,
    this.address,
    this.email,
    this.ownerName,
    this.cnpj,
  );

  factory HiveCompanyInfo.fromDomainModel(CompanyInfo data) => HiveCompanyInfo(
        data.name,
        data.address != null
            ? HiveCompanyAddress.fromDomainModel(data.address!)
            : null,
        data.email,
        data.ownerName,
        data.cnpj,
      );

  CompanyInfo toDomainModel() => CompanyInfo(
        name,
        address?.toDomainModel(),
        email,
        ownerName,
        cnpj,
      );

  Map<String, dynamic> toJson() => {
        _keyName: name,
        _keyAddress: address?.toJson(),
        _keyEmail: email,
        _keyOwnerName: ownerName,
        _keyCnpj: cnpj
      };

  factory HiveCompanyInfo.fromJson(
          Map<String, dynamic> json) =>
      HiveCompanyInfo(
          json[_keyName].toString(),
          HiveCompanyAddress.fromJson(
              json[_keyAddress] as Map<String, dynamic>),
          json[_keyEmail].toString(),
          json[_keyOwnerName].toString(),
          json[_keyCnpj].toString());
}

@HiveType(typeId: 7)
class HiveCompanyAddress extends HiveObject {
  @HiveField(0)
  String street;

  @HiveField(1, defaultValue: null)
  String? extraInfo;

  @HiveField(2)
  String neighbourhood;

  @HiveField(3)
  String city;

  @HiveField(4)
  String state;

  @HiveField(5)
  String country;

  @HiveField(6)
  String zipCode;

  HiveCompanyAddress(
    this.street,
    this.extraInfo,
    this.neighbourhood,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  );

  factory HiveCompanyAddress.fromDomainModel(CompanyAddress data) =>
      HiveCompanyAddress(
        data.street,
        data.extraInfo,
        data.neighbourhood,
        data.city,
        data.state,
        data.country,
        data.zipCode,
      );

  CompanyAddress toDomainModel() => CompanyAddress(
        street,
        extraInfo,
        neighbourhood,
        city,
        state,
        country,
        zipCode,
      );

  Map<String, dynamic> toJson() => {
        _keyStreet: street,
        _keyExtraInfo: extraInfo,
        _keyNeighbourhood: neighbourhood,
        _keyCity: city,
        _keyState: state,
        _keyCountry: country,
        _keyZipcode: zipCode
      };

  factory HiveCompanyAddress.fromJson(Map<String, dynamic> json) =>
      HiveCompanyAddress(
          json[_keyState].toString(),
          json[_keyExtraInfo].toString(),
          json[_keyNeighbourhood].toString(),
          json[_keyCity].toString(),
          json[_keyState].toString(),
          json[_keyCountry].toString(),
          json[_keyZipcode].toString());
}
