import 'dart:math';
import 'dart:convert';
import 'package:klinkmediatama/koneksiterputus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klinkmediatama/src/theme/text_styles.dart';
import 'package:klinkmediatama/src/theme/theme.dart';
import 'package:klinkmediatama/src/theme/extention.dart';
import 'package:klinkmediatama/src/theme/light_color.dart';
import 'package:klinkmediatama/src/model/artikel_model.dart';
import 'package:klinkmediatama/src/model/dokter_model.dart';
import 'package:klinkmediatama/src/model/slider_model.dart';
import 'package:klinkmediatama/api.dart';

class Homes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String nama = '';
  String foto = '';

  Future<List<Artikel>> _getArtikel() async {
    List<Artikel> listArtikel = [];
    final response = await http.get(Api.Artikles);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseArtikel responseArtikel = ResponseArtikel.fromJson(json);

      responseArtikel.artikel.forEach((item) {
        listArtikel.add(item);
      });

      return listArtikel;
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Koneksiterputus()));
    }
  }

  Future<List<Docter>> _getDokter() async {
    List<Docter> listDocter = [];
    final response = await http.get(Api.Dokters);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      ResponseDokter responseDokter = ResponseDokter.fromJson(json);

      responseDokter.docter.forEach((item) {
        listDocter.add(item);
      });

      return listDocter;
    } else {
      return [];
    }
  }

  Future<List<Slide>> _getSlider() async {
    List<Slide> listSlider = [];
    final response = await http.get(Api.Sliders);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      ResponseSlider responseSlider = ResponseSlider.fromJson(json);

      responseSlider.slides.forEach((item) {
        listSlider.add(item);
      });
      return listSlider;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString("nama");
      foto = preferences.getString("foto");
    });
  }

  @override
  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello,", style: TextStyles.title.subTitleColor),
        Text(
          nama,
          style: TextStyles.h1Style,
        ),
      ],
    ).p16;
  }

  Widget _carousel() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<Slide>>(
        future: _getSlider(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ));
          } else {
            return CarouselSlider(
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
              ),
              items: snapshot.data
                  .map((e) => Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: NetworkImage(e.gambar),
                                fit: BoxFit.fill)),
                      ))
                  .toList(),
            );
          }
        },
      ),
    );
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: Icon(Icons.search, color: LightColor.purple)
                  .alignCenter
                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
      ),
    );
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Artikel",
                style: TextStyles.title.bold,
              ),
              Text(
                "Show All",
                style: TextStyles.titleNormal
                    .copyWith(color: Theme.of(context).primaryColor),
              ).p(8).ripple(() {})
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: FutureBuilder<List<Artikel>>(
            future: _getArtikel(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot?.data.length ?? null,
                  itemBuilder: (context, index) {
                    List<Artikel> listArtikel = snapshot.data;
                    return _categoryCard(
                        listArtikel[index],
                        listArtikel[index].fotoArtikel,
                        listArtikel[index].judulArtikel,
                        listArtikel[index].isiArtikel,
                        // color: randomColor(),
                        color: Colors.white70,
                        lightColor: Colors.grey);
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }

  Widget _categoryCard(
      Artikel artikel, String image, String title, String subtitle,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.black;
    TextStyle subtitleStyle = TextStyles.body.bold.black;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Flexible(
                    //   // child: Text(title, style: titleStyle).hP8,
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        title,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(
          () {
            Navigator.pushNamed(context, "/DetailArtikel", arguments: artikel);
          },
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _doctorsList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("List Docter", style: TextStyles.title.bold),
              IconButton(
                      icon: Icon(
                        Icons.sort,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {})
                  .p(12)
                  .ripple(() {},
                      borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          FutureBuilder<List<Docter>>(
            future: _getDokter(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                List<Docter> listDocter = snapshot.data;
                return Column(
                    children: listDocter.map((x) {
                  return _doctorTile(x);
                }).toList());
              }
            },
          )
        ],
      ),
    );
  }

  Widget _doctorTile(Docter model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(),
              ),
              child: Image.network(
                model.foto,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.nama, style: TextStyles.title.bold),
          subtitle: Text(
            model.spesialis,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(
        () {
          Navigator.pushNamed(context, "/DetailPage", arguments: model);
        },
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _header(),
                _searchField(),
                _carousel(),
                _category(),
              ],
            ),
          ),
          _doctorsList()
        ],
      ),
    );
  }
}
