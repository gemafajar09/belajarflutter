import 'dart:convert';

ResponseSlider responseSliderFromJson(String str) =>
    ResponseSlider.fromJson(json.decode(str));

String responseSliderToJson(ResponseSlider data) => json.encode(data.toJson());

class ResponseSlider {
  ResponseSlider({
    this.slides,
  });

  List<Slide> slides;

  factory ResponseSlider.fromJson(Map<String, dynamic> json) => ResponseSlider(
        slides: List<Slide>.from(json["slides"].map((x) => Slide.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slides": List<dynamic>.from(slides.map((x) => x.toJson())),
      };
}

class Slide {
  Slide({
    this.gambar,
  });

  String gambar;

  factory Slide.fromJson(Map<String, dynamic> json) => Slide(
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "gambar": gambar,
      };
}
