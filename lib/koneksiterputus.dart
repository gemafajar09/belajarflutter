import 'package:flutter/material.dart';

class Koneksiterputus extends StatefulWidget {
  Koneksiterputus({
    Key key,
  }) : super(key: key);
  @override
  _KoneksiterputusState createState() => _KoneksiterputusState();
}

class _KoneksiterputusState extends State<Koneksiterputus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, 215.0),
            child:
                // Adobe XD layer: 'nointernet' (shape)
                Container(
              width: 414.0,
              height: 307.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/nointernet.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(142.0, 45.0),
            child: Text(
              'Oopss…..',
              style: TextStyle(
                fontFamily: 'opensans',
                fontSize: 33,
                color: const Color(0xff707070),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(38.4, 112.0),
            child: SizedBox(
              width: 319.0,
              child: Text(
                'Mohon Periksa Sambungan\nInternet anda!',
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontSize: 22,
                  color: const Color(0xff707070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(91.0, 565.0),
            child: Container(
              width: 215.0,
              height: 55.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0x7d62e8f2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x14000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(135.0, 578.0),
            child: SizedBox(
              width: 144.0,
              child: Text(
                'Coba Lagi...',
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontSize: 22,
                  color: const Color(0x9c707070),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
