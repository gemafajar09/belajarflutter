import 'dart:convert';

ResponseBooking responseBookingFromJson(String str) =>
    ResponseBooking.fromJson(json.decode(str));

String responseBookingToJson(ResponseBooking data) =>
    json.encode(data.toJson());

class ResponseBooking {
  ResponseBooking({
    this.booking,
  });

  List<Booking> booking;

  factory ResponseBooking.fromJson(Map<String, dynamic> json) =>
      ResponseBooking(
        booking:
            List<Booking>.from(json["booking"].map((x) => Booking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booking": List<dynamic>.from(booking.map((x) => x.toJson())),
      };
}

class Booking {
  Booking({
    this.idBooking,
    this.jam,
    this.tanggal,
    this.namaDokter,
    this.namaUser,
  });

  String idBooking;
  String jam;
  DateTime tanggal;
  String namaDokter;
  String namaUser;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        idBooking: json["id_booking"],
        jam: json["jam"],
        tanggal: DateTime.parse(json["tanggal"]),
        namaDokter: json["nama_dokter"],
        namaUser: json["nama_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_booking": idBooking,
        "jam": jam,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "nama_dokter": namaDokter,
        "nama_user": namaUser,
      };
}
