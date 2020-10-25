import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:klinkmediatama/src/model/dokter_model.dart';
import 'package:klinkmediatama/api.dart';

class Dokter extends StatefulWidget {
  @override
  _DokterState createState() => _DokterState();
}

class _DokterState extends State<Dokter> {
  String baners = '';
  Future<List> _getBanner() async {
    final response = await http.get(Api.BannerDoc);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      String baner = json['banner'];
      print(baner);
      setState(() {
        baners = baner;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getBanner();
  }

  Future<List<Docter>> _getDokter() async {
    List<Docter> listDokter = [];
    final response = await http.get(Api.Dokters);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseDokter responseDokter = ResponseDokter.fromJson(json);
      responseDokter.docter.forEach((x) {
        listDokter.add(x);
      });

      return listDokter;
    } else {
      return [];
    }
  }

  Widget ListDocters(Docter model) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 16,
            margin: EdgeInsets.only(top: 10),
            child: RaisedButton(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(40),
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(model.foto), fit: BoxFit.fill)),
                  ),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * .6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(model.nama,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontFamily: "opensans")),
                        Divider(),
                        Text(
                          model.spesialis,
                          style: TextStyle(
                              color: Colors.grey, fontFamily: "opensans"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/DetailPage", arguments: model);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(baners), fit: BoxFit.fill),
              ),
            ),
            Divider(),
            Text(
              "List Dokter",
              style: TextStyle(
                fontSize: 19,
                color: Colors.black54,
                fontFamily: "opensans",
              ),
              textAlign: TextAlign.left,
            ),
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
                    children: listDocter.map((e) {
                      return ListDocters(e);
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
