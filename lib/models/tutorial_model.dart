class Tutorial {
  final int id;
  final int idBuah;
  final int idObat;
  final String creator;
  final String photoCreator;
  final String judul;
  final String deskripsi;
  final String video;

  Tutorial({
    required this.id,
    required this.idBuah,
    required this.idObat,
    required this.creator,
    required this.photoCreator,
    required this.judul,
    required this.deskripsi,
    required this.video,
  });

  factory Tutorial.fromJson(Map<String, dynamic> json) {
    return Tutorial(
      id: json['id'] ?? 0,
      idBuah: json['id_buah'] ?? 0,
      idObat: json['id_obat'] ?? 0,
      creator: json['creator'] ?? '',
      photoCreator: json['photo_creator'] ?? '',
      judul: json['judul'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      video: json['video'] ?? '',
    );
  }
}
