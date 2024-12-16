class Obat {
  final int id;
  final String jenis;
  final List<ObatDetail> obats;

  Obat({
    required this.id,
    required this.jenis,
    required this.obats,
  });

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      id: json['id'],
      jenis: json['jenis'],
      obats:
          (json['obats'] as List).map((i) => ObatDetail.fromJson(i)).toList(),
    );
  }

  get fungsiobats => null;
}

class ObatDetail {
  final int id;
  final String namaObat;
  final String photoObat;
  final String deskripsi;
  final List<FungsiDetail> fungsiobats;

  ObatDetail({
    required this.id,
    required this.namaObat,
    required this.photoObat,
    required this.deskripsi,
    required this.fungsiobats,
  });

  factory ObatDetail.fromJson(Map<String, dynamic> json) {
    return ObatDetail(
      id: json['id'],
      namaObat: json['nama_obat'],
      photoObat: json['photo_obat'],
      deskripsi: json['deskripsi'],
      fungsiobats: (json['fungsiobats'] as List)
          .map((i) => FungsiDetail.fromJson(i))
          .toList(),
    );
  }
}

class FungsiDetail {
  final String potoFungsi;
  final String fungsi;

  FungsiDetail({
    required this.potoFungsi,
    required this.fungsi,
  });

  factory FungsiDetail.fromJson(Map<String, dynamic> json) {
    return FungsiDetail(
      potoFungsi: json['poto_fungsi'],
      fungsi: json['fungsi'],
    );
  }
}
