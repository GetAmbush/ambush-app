class Currency {
  final String name;
  final String cc;
  final String symbol;

  Currency(this.name, this.cc, this.symbol);

  //ignore: strict_top_level_inference
  static Currency fromJson(json) =>
      Currency(json['name'], json['cc'], json['symbol']);
}
