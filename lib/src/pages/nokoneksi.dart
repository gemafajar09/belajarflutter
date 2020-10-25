import 'package:flutter/material.dart';

class CekKoneksi extends StatefulWidget {
  @override
  _CekKoneksiState createState() => _CekKoneksiState();
}

class _CekKoneksiState extends State<CekKoneksi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/rs.jpg"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
