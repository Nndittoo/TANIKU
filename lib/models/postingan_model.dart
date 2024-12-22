class Postingan {
  final int id;
  final int idUser;
  final String deskripsi;
  final String displayname;
  final String photoUserUrl;
  final String dibuat;
  final String gambarPostingan;
  final int? like;

  Postingan({
    required this.id,
    required this.idUser,
    required this.deskripsi,
    required this.displayname,
    required this.photoUserUrl,
    required this.dibuat,
    required this.gambarPostingan,
    this.like,
  });

  factory Postingan.fromJson(Map<String, dynamic> json) {
    return Postingan(
      id: json['id'],
      idUser: json['id_user'],
      deskripsi: json['deskripsi'],
      displayname: json['displayname'],
      photoUserUrl: json['photo_user_url'],
      dibuat: json['dibuat'],
      gambarPostingan: json['gambar_postingan'],
      like: json['like'],
    );
  }
}
