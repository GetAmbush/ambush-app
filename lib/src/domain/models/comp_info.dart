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
}

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
}
