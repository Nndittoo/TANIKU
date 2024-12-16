class MarketPrice {
  final int id;
  final String namaBuah;
  final String potoBuah;
  final List<Kilo> kilos;

  MarketPrice({
    required this.id,
    required this.namaBuah,
    required this.potoBuah,
    required this.kilos,
  });

  factory MarketPrice.fromJson(Map<String, dynamic> json) {
    return MarketPrice(
      id: json['id'],
      namaBuah: json['nama_buah'],
      potoBuah: json['poto_buah'],
      kilos: (json['kilos'] as List).map((i) => Kilo.fromJson(i)).toList(),
    );
  }
}

class Kilo {
  final int id;
  final int idPajak;
  final String hp;
  final Pajak pajak;

  Kilo({
    required this.id,
    required this.idPajak,
    required this.hp,
    required this.pajak,
  });

  factory Kilo.fromJson(Map<String, dynamic> json) {
    return Kilo(
      id: json['id'],
      idPajak: json['id_pajak'],
      hp: json['hp'],
      pajak: Pajak.fromJson(json['pajak']),
    );
  }
}

class Pajak {
  final String pajak;
  final String alamat;

  Pajak({
    required this.pajak,
    required this.alamat,
  });

  factory Pajak.fromJson(Map<String, dynamic> json) {
    return Pajak(
      pajak: json['pajak'],
      alamat: json['alamat'],
    );
  }
}
