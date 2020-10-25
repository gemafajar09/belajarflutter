import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klinkmediatama/src/model/booking_model.dart';
import 'package:intl/intl.dart';
import 'package:klinkmediatama/api.dart';
import 'package:klinkmediatama/src/model/dokter_model.dart';

class BookingJadwal extends StatefulWidget {
  BookingJadwal({Key key, this.model}) : super(key: key);
  final Docter model;
  @override
  _BookingJadwalState createState() => _BookingJadwalState();
}

class _BookingJadwalState extends State<BookingJadwal> {
  Docter model;
  static var today = new DateTime.now();
  var bulans = new DateFormat.MMM().format(today);
  var haris = new DateFormat.d().format(today);
  var tanggal = new DateFormat('yyyy-MM-dd').format(today);

  Future<List<Booking>> _getBooking() async {
    List<Booking> listBooking = [];
    final response = await http.post(Api.Bookings, body: {'tanggal': tanggal});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
    }
  }

  @override
  void initState() {
    print(model);
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: 201.0,
              decoration: BoxDecoration(
                color: const Color(0xff32549a),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
            Transform.translate(
              offset: Offset(0.0, 167.0),
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 375.0,
                        height: 120.0,
                        padding:
                            EdgeInsets.only(top: 5, left: 15.0, right: 15.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 1,
                              height: 105.0,
                              padding: EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0),
                                ),
                                color: const Color(0xff83a4e6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '10.00 - 11.00 AM',
                                    style: TextStyle(
                                      fontFamily: 'opensans',
                                      fontSize: 16,
                                      color: const Color(0xfff2f1f1),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    'Gema Fajar Ramadhan',
                                    style: TextStyle(
                                      fontFamily: 'opensans',
                                      fontSize: 16,
                                      color: const Color(0xffffffff),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Divider(),
                                  Text(
                                    'Dr. sahroel',
                                    style: TextStyle(
                                      fontFamily: 'opensans',
                                      fontSize: 16,
                                      color: const Color(0xffffffff),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(41.0, 35.0),
              child: Container(
                width: 55.0,
                height: 98.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(55.0, 50.0),
              child: Text(
                '${bulans}',
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontSize: 22,
                  color: const Color(0xff121213),
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Transform.translate(
              offset: Offset(58.0, 86.0),
              child: Text(
                '${haris}',
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontSize: 22,
                  color: const Color(0xff090909),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Transform.translate(
              offset: Offset(119.0, 69.0),
              child: Text(
                'Kamis',
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontSize: 22,
                  color: const Color(0xff86b7f6),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Transform.translate(
              offset: Offset(119.0, 86.0),
              child: Text(
                'TODAY',
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontSize: 26,
                  color: const Color(0xff86b7f6),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Transform.translate(
              offset: Offset(207.0, 44.0),
              child: Container(
                width: 181.0,
                height: 136.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/icn1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            BackButton(
              color: Colors.white,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xff32549a),
        child: Icon(Icons.search),
      ),
    );
  }
}
