import 'package:klinkmediatama/src/model/artikel_model.dart';
import 'package:flutter/material.dart';

class DetailArtikel extends StatefulWidget {
  DetailArtikel({Key key, this.artikel}) : super(key: key);
  final Artikel artikel;
  @override
  _DetailArtikelState createState() => _DetailArtikelState();
}

class _DetailArtikelState extends State<DetailArtikel> {
  Artikel artikel;

  @override
  void initState() {
    artikel = widget.artikel;
    super.initState();
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Colors.white),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: NetworkImage(artikel.fotoArtikel),
                            fit: BoxFit.fill)),
                  ),
                  _appbar(),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        artikel.judulArtikel,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 19.0,
                            fontFamily: "opensans"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      child: Text(
                        artikel.isiArtikels,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: "opensans"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
