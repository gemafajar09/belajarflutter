import 'package:klinkmediatama/src/pages/page/dokter.dart';
import 'package:klinkmediatama/src/pages/page/history.dart';
import 'package:klinkmediatama/src/pages/page/home.dart';
import 'package:klinkmediatama/src/pages/page/profil.dart';
import 'package:flutter/material.dart';

import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:klinkmediatama/src/theme/extention.dart';
import 'package:klinkmediatama/src/theme/light_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  String nama = '';
  String foto = '';

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

  final List<Widget> screens = [
    Homes(),
    Dokter(),
    History(),
    Profil(),
  ];

  Widget currentScreen = Homes();

  final PageStorageBucket bucket = PageStorageBucket();

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: Icon(
        Icons.short_text,
        size: 30,
        color: Colors.black,
      ),
      actions: <Widget>[
        Icon(
          Icons.notifications_none,
          size: 30,
          color: LightColor.grey,
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          child: Container(
            // height: 40,
            // width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Image.network(foto, fit: BoxFit.fill),
          ),
        ).p(8),
      ],
    );
  }

  Widget _button() {
    return bmnav.BottomNav(
      labelStyle: bmnav.LabelStyle(visible: true, showOnSelect: true),
      onTap: (i) {
        setState(() {
          _page = i;
          currentScreen = screens[i];
        });
      },
      items: [
        bmnav.BottomNavItem(Icons.home, label: "Home"),
        bmnav.BottomNavItem(Icons.supervised_user_circle, label: "Dokter"),
        bmnav.BottomNavItem(Icons.notifications_active, label: "Histori"),
        bmnav.BottomNavItem(Icons.person_outline, label: "User"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageStorage(child: currentScreen, bucket: bucket),
      bottomNavigationBar: _button(),
      resizeToAvoidBottomPadding: false,
    );
  }
}
