import 'dart:convert';

ResponseArtikel responseArtikelFromJson(String str) =>
    ResponseArtikel.fromJson(json.decode(str));

String responseArtikelToJson(ResponseArtikel data) =>
    json.encode(data.toJson());

class ResponseArtikel {
  ResponseArtikel({
    this.artikel,
  });

  List<Artikel> artikel;

  factory ResponseArtikel.fromJson(Map<String, dynamic> json) =>
      ResponseArtikel(
        artikel:
            List<Artikel>.from(json["artikel"].map((x) => Artikel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "artikel": List<dynamic>.from(artikel.map((x) => x.toJson())),
      };
}

class Artikel {
  Artikel({
    this.idArtikel,
    this.judulArtikel,
    this.isiArtikel,
    this.isiArtikels,
    this.fotoArtikel,
    this.tanggal,
  });

  String idArtikel;
  String judulArtikel;
  String isiArtikel;
  String isiArtikels;
  String fotoArtikel;
  DateTime tanggal;

  factory Artikel.fromJson(Map<String, dynamic> json) => Artikel(
    idArtikel: json["id_artikel"],
    judulArtikel: json["judul_artikel"],
    isiArtikel: json["isi_artikel"],
    isiArtikels: json["isi_artikels"],
    fotoArtikel: json["foto_artikel"],
    tanggal: DateTime.parse(json["tanggal"]),
  );

  Map<String, dynamic> toJson() => {
    "id_artikel": idArtikel,
    "judul_artikel": judulArtikel,
    "isi_artikel": isiArtikel,
    "isi_artikels": isiArtikels,
    "foto_artikel": fotoArtikel,
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
  };
}
