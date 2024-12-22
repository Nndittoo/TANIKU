class Posting {
  final int id;
  final String name;
  final String deskripsi;
  final String dibuat;
  final String gambarPostingan;
  final int? like;

  Posting({
    required this.id,
    required this.name,
    required this.deskripsi,
    required this.dibuat,
    required this.gambarPostingan,
    this.like,
  });

  factory Posting.fromJson(Map<String, dynamic> json) {
    return Posting(
      id: json['id'],
      name: json['name'],
      deskripsi: json['deskripsi'],
      dibuat: json['dibuat'],
      gambarPostingan: json['gambar_postingan'],
      like: json['like'],
    );
  }
}
