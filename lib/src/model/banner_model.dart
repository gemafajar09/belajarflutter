import 'dart:convert';

ResponseBanner responseBannerFromJson(String str) =>
    ResponseBanner.fromJson(json.decode(str));

String responseBannerToJson(ResponseBanner data) => json.encode(data.toJson());

class ResponseBanner {
  ResponseBanner({
    this.slidedokter,
  });

  List<Slidedokter> slidedokter;

  factory ResponseBanner.fromJson(Map<String, dynamic> json) => ResponseBanner(
        slidedokter: List<Slidedokter>.from(
            json["slidedokter"].map((x) => Slidedokter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slidedokter": List<dynamic>.from(slidedokter.map((x) => x.toJson())),
      };
}

class Slidedokter {
  Slidedokter({
    this.bannerDepan,
  });

  String bannerDepan;

  factory Slidedokter.fromJson(Map<String, dynamic> json) => Slidedokter(
        bannerDepan: json["banner_depan"] == null ? null : json['banner_depan'],
      );

  Map<String, dynamic> toJson() => {
        "banner_depan": bannerDepan == null ? null : bannerDepan,
      };
}
