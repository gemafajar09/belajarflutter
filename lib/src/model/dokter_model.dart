import 'dart:convert';

ResponseDokter responseDokterFromJson(String str) =>
    ResponseDokter.fromJson(json.decode(str));

String responseDokterToJson(ResponseDokter data) => json.encode(data.toJson());

class ResponseDokter {
  ResponseDokter({
    this.docter,
  });

  List<Docter> docter;

  factory ResponseDokter.fromJson(Map<String, dynamic> json) => ResponseDokter(
        docter:
            List<Docter>.from(json["docter"].map((x) => Docter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "docter": List<dynamic>.from(docter.map((x) => x.toJson())),
      };
}

class Docter {
  Docter({
    this.idDokter,
    this.nama,
    this.spesialis,
    this.raiting,
    this.review,
    this.score,
    this.statistic,
    this.favorit,
    this.foto,
    this.deskripsi,
  });

  String idDokter;
  String nama;
  String spesialis;
  double raiting;
  double review;
  double score;
  double statistic;
  bool favorit;
  String foto;
  String deskripsi;

  Docter copyWith({
    String idDokter,
    String nama,
    String spesialis,
    double raiting,
    double review,
    double score,
    double statistic,
    bool favorit,
    String foto,
    String deskripsi,
  }) =>
      Docter(
        idDokter: idDokter ?? this.idDokter,
        nama: nama ?? this.nama,
        spesialis: spesialis ?? this.spesialis,
        raiting: raiting ?? this.raiting,
        review: review ?? this.review,
        score: score ?? this.score,
        statistic: statistic ?? this.statistic,
        favorit: favorit ?? this.favorit,
        foto: foto ?? this.foto,
        deskripsi: deskripsi ?? this.deskripsi,
      );

  factory Docter.fromJson(Map<String, dynamic> json) => Docter(
        idDokter: json["id_dokter"] == null ? null : json["id_dokter"],
        nama: json["nama"] == null ? null : json["nama"],
        spesialis: json["spesialis"] == null ? null : json["spesialis"],
        raiting: json["raiting"].toDouble() == null
            ? null
            : json["raiting"].toDouble(),
        review: json["review"].toDouble() == null
            ? null
            : json["review"].toDouble(),
        score:
            json["score"].toDouble() == null ? null : json["score"].toDouble(),
        statistic: json["statistic"].toDouble() == null
            ? null
            : json["statistic"].toDouble(),
        favorit: json["favorit"] == null ? null : json["favorit"],
        foto: json["foto"] == null ? null : json["foto"],
        deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id_dokter": idDokter == null ? null : idDokter,
        "nama": nama == null ? null : nama,
        "spesialis": spesialis == null ? null : spesialis,
        "raiting": raiting == null ? null : raiting,
        "review": review == null ? null : review,
        "score": score == null ? null : score,
        "statistic": statistic == null ? null : statistic,
        "favorit": favorit == null ? null : favorit,
        "foto": foto == null ? null : foto,
        "deskripsi": deskripsi == null ? null : deskripsi,
      };
}
