import 'dart:convert';

import 'package:klinkmediatama/api.dart';
import 'package:klinkmediatama/src/model/dokter_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:klinkmediatama/src/model/booking_model.dart';
import 'package:klinkmediatama/src/theme/light_color.dart';
import 'package:klinkmediatama/src/theme/text_styles.dart';
import 'package:klinkmediatama/src/theme/theme.dart';
import 'package:klinkmediatama/src/theme/extention.dart';
import 'package:klinkmediatama/src/widgets/progress_widget.dart';
import 'package:klinkmediatama/src/widgets/rating_start.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.model}) : super(key: key);
  final Docter model;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Docter model;
  String id = '';
  String tanggal = '';
  TextEditingController tanggalSekarang = TextEditingController();

  static var today = new DateTime.now();
  var tanggals = new DateFormat('yyyy-MM-dd').format(today);
  var bulans = new DateFormat.MMM().format(today);
  var haris = new DateFormat.d().format(today);
  var tahun = new DateFormat.y().format(today);

  Future<List<Booking>> _getBooking() async {
    List<Booking> listBooking = [];
    tanggal = tanggals.toString();
    id = model.idDokter;
    final response = await http
        .post(Api.Bookings, body: {'tanggal': tanggal, 'id_dokter': id});
    print("tgl : " + tanggal);
    print("id : " + id);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseBooking responseBooking = ResponseBooking.fromJson(json);
      responseBooking.booking.forEach((item) {
        listBooking.add(item);
      });
      return listBooking;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    // print(model.idDokter.toString());
    model = widget.model;
    _getBooking();
    this.setState(() {});
    super.initState();
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Theme.of(context).primaryColor),
        IconButton(
            icon: Icon(
              model.favorit ? Icons.favorite : Icons.favorite_border,
              color: model.favorit ? Colors.red : LightColor.grey,
            ),
            onPressed: () {
              setState(() {
                model.favorit = !model.favorit;
              });
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.network(model.foto),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 16), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                model.nama,
                                style: titleStyle,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.check_circle,
                                  size: 18,
                                  color: Theme.of(context).primaryColor),
                              Spacer(),
                              RatingStar(
                                rating: model.raiting,
                              )
                            ],
                          ),
                          subtitle: Text(
                            model.spesialis,
                            style: TextStyles.bodySm.subTitleColor.bold,
                          ),
                        ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Row(
                          children: <Widget>[
                            ProgressWidget(
                                value: model.review,
                                totalValue: 100,
                                activeColor: LightColor.purpleExtraLight,
                                backgroundColor:
                                    LightColor.grey.withOpacity(.3),
                                title: "Review",
                                durationTime: 500),
                            ProgressWidget(
                                value: model.score,
                                totalValue: 100,
                                activeColor: LightColor.purpleLight,
                                backgroundColor:
                                    LightColor.grey.withOpacity(.3),
                                title: "Total Score",
                                durationTime: 300),
                            ProgressWidget(
                                value: model.statistic,
                                totalValue: 100,
                                activeColor: LightColor.purple,
                                backgroundColor:
                                    LightColor.grey.withOpacity(.3),
                                title: "Statistik",
                                durationTime: 800),
                          ],
                        ),
                        Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text("Tentang", style: titleStyle).vP16,
                        Text(
                          model.deskripsi,
                          style: TextStyles.body.subTitleColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: LightColor.grey.withAlpha(150)),
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: LightColor.grey.withAlpha(150)),
                              child: Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // SizedBox(
                            //   width: 160,
                            // ),
                            // FlatButton(
                            //   color: Theme.of(context).primaryColor,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10)),
                            //   onPressed: () {
                            //     Navigator.pushNamed(context, '/BookingJadwal',
                            //         arguments: model);
                            //   },
                            //   child: Text(
                            //     "Lihat Jadwal",
                            //     style: TextStyles.titleNormal.white,
                            //   ).p(10),
                            // ),
                          ],
                        ).vP16,
                        Text("Jadwal $haris - $bulans - $tahun",
                                style: titleStyle)
                            .vP16,
                        Column(
                          children: <Widget>[
                            Container(
                              width: 375.0,
                              height: 120.0,
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    height: 105.0,
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30.0),
                                        bottomLeft: Radius.circular(30.0),
                                      ),
                                      color: const Color(0xff83a4e6),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            DateTimePickerFormField(
                              controller: tanggalSekarang,
                              inputType: InputType.date,
                              format: DateFormat("yyyy-MM-dd"),
                              initialDate: new DateTime.now(),
                              initialValue: new DateTime.now(),
                              editable: false,
                              decoration: InputDecoration(
                                  labelText: 'Date',
                                  hasFloatingPlaceholder: false),
                              onChanged: (dt) {
                                setState(() => tanggal = dt.toString());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
