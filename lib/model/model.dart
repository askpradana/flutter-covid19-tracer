class Model {
  final String negara;
  final int konfirmasi;
  final int sembuh;
  final int kritis;
  final int meninggal;
  final String lastUpdate;

  Model({
    required this.negara,
    required this.konfirmasi,
    required this.sembuh,
    required this.kritis,
    required this.meninggal,
    required this.lastUpdate,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      negara: json['country'],
      konfirmasi: json['confirmed'],
      sembuh: json['recovered'],
      kritis: json['critical'],
      meninggal: json['deaths'],
      lastUpdate: json['lastUpdate'],
    );
  }
}
