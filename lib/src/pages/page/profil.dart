import 'package:klinkmediatama/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String nama = '';
  String foto = '';
  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setInt("nama", null);
      preferences.setInt("foto", null);
      preferences.setInt("id_user", null);
      preferences.commit();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Login()));
    });
  }

  Future<void> _pesanN(msg) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text(msg),
            actions: <Widget>[
              CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, 'Yes');
                  },
                  child: Text('Yes')),
              CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, 'No');
                  },
                  child: Text('No')),
            ],
          );
        })) {
      case "Yes":
        logOut();
        break;
      case "No":
        break;

      default:
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

  Widget _profileback() {
    return Stack(
      children: <Widget>[
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                // bottomRight: Radius.circular(50),
              ),
              image: DecorationImage(
                  image: AssetImage('assets/back3.jpg'), fit: BoxFit.cover)),
        ),
        Container(
          width: double.infinity,
          height: 200,
          padding: EdgeInsets.only(bottom: 0.0, right: 0.0),
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: Colors.grey,
                            offset: Offset.zero,
                            spreadRadius: 1)
                      ]),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(foto),
                  ),
                ),
              ),
              Center(
                child: Text(
                  nama,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: "opensans",
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              margin: EdgeInsets.only(top: 170, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1,
                      color: Colors.green,
                      offset: Offset.infinite)
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 16,
                    child: ListTile(
                      leading: Icon(Icons.map),
                      title: Text(
                        "Alamat",
                        style: TextStyle(
                            fontFamily: "opensans",
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Jalan Raya Lubuk Minturun",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "opensans",
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Card(
                    elevation: 16,
                    child: ListTile(
                      leading: Icon(Icons.work),
                      title: Text(
                        "Pekerjaan",
                        style: TextStyle(
                            fontFamily: "opensans",
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Wirasswasta",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "opensans",
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Card(
                    elevation: 16,
                    child: ListTile(
                      leading: Icon(Icons.email),
                      title: Text(
                        "Email",
                        style: TextStyle(
                            fontFamily: "opensans",
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("gemafajar09@gmail.com",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "opensans",
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      _pesanN('Yakin Ingin Keluar?');
                    },
                    child: Image.asset(
                      "assets/exit.png",
                      width: 80,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          _profileback(),
          SizedBox(
            height: 10.0,
          ),
        ]),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
