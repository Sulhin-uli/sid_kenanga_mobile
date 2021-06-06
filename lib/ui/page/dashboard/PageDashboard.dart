import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/constants/color_constant.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/constants/style_constant.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/models/popular_model.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/models/travlog_modell.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/widgets/PageProfilDesa.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/widgets/bottom_navigation.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/models/carousels_model.dart';
import 'package:sid_kenanga_mobile/ui/page/kabar_desa/PageKabarDesa.dart';
import 'package:sid_kenanga_mobile/ui/page/login/PageSignIn.dart';
import 'package:sid_kenanga_mobile/ui/page/pengaduan/PagePengaduan.dart';
import 'package:sid_kenanga_mobile/ui/page/profile/PageProfile1.dart';
import 'package:sid_kenanga_mobile/ui/page/surat/PageSurat.dart';
import 'package:sid_kenanga_mobile/model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDashboard extends StatefulWidget {
  @override
  _PageDashboardState createState() => _PageDashboardState();
}

class _PageDashboardState extends State<PageDashboard> {
  String nik = "";
  String nama = "";
  int _current = 0;
  User user = null;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    getSession();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Setting up AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mBackgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
          ],
        ),
        elevation: 0,
      ),

      // Setting up Background Color
      backgroundColor: mBackgroundColor,

      // Setting Up Custom Bottom Navigation Bar
      // bottomNavigationBar: BottomNavigationSID(),

      // Body
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            // Landing Page
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 24),
              child: Text(
                (user != null) ? "Selamat Datang, " + user.name : "Memuat ...",
                style: mTitleStyle,
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 190,
                    child: Swiper(
                      onIndexChanged: (index) {
                        setState(() {
                          _current = index;
                        });
                      },
                      autoplay: true,
                      layout: SwiperLayout.DEFAULT,
                      itemCount: carousels.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: AssetImage(
                                    carousels[index].image,
                                  ),
                                  fit: BoxFit.cover)),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: map<Widget>(carousels, (index, image) {
                              return Container(
                                alignment: Alignment.center,
                                height: 6,
                                width: 6,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? mBlueColor
                                        : mGreyColor),
                              );
                            }),
                          )
                        ],
                      ),

                      // More
                      Text(
                        'Geser ...',
                        style: mMoreDiscountStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),

            // Service Section
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                'Menu ',
                style: mTitleStyle,
              ),
            ),
            Container(
              height: 144,
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageKabarDesa()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: mFillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mBorderColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.my_library_books,
                                  color: Colors.redAccent,
                                  size: 35,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Kabar Desa',
                                          style: mServiceTitleStyle),
                                      Text(
                                        'Lihat kabar desa terbaru',
                                        style: mServiceSubtitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PagePengaduan()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: mFillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mBorderColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.sms,
                                  color: Colors.blueAccent,
                                  size: 35,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Pengaduan',
                                          style: mServiceTitleStyle),
                                      Text(
                                        'Pengaduan Masyarakat',
                                        style: mServiceSubtitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageSurat()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: mFillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mBorderColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.email,
                                  color: Colors.yellow,
                                  size: 35,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Surat', style: mServiceTitleStyle),
                                      Text(
                                        'Permintaan pembuatan Surat',
                                        style: mServiceSubtitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageProfile()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: mFillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mBorderColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: Colors.green,
                                  size: 35,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Profil', style: mServiceTitleStyle),
                                      Text(
                                        'Profil',
                                        style: mServiceSubtitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Travlog Section
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 5),
              child: Text(
                'Profil Desa ',
                style: mTitleStyle,
              ),
            ),

            Container(
              height: 70,
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageProfiDesa()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: mFillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mBorderColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.account_balance,
                                  color: Colors.greenAccent,
                                  size: 35,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Profil Desa',
                                          style: mServiceTitleStyle),
                                      Text(
                                        'Alamat, Visi, dan Misi',
                                        style: mServiceSubtitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //
                    ],
                  ),
                ],
              ),
            ),

            // Container(
            //   height: 181,
            //   child: ListView.builder(
            //     padding: EdgeInsets.only(left: 10),
            //     itemCount: travlogs.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         margin: EdgeInsets.only(right: 16),
            //         width: 220,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Stack(
            //               children: <Widget>[
            //                 Container(
            //                   height: 104,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(8),
            //                     image: DecorationImage(
            //                         image: AssetImage(travlogs[index].image),
            //                         fit: BoxFit.cover),
            //                   ),
            //                 ),
            //                 // Positioned(
            //                 //   child: Image.asset(
            //                 //       'assets/images/sample-gambar.jpg'),
            //                 //   right: 0,
            //                 //   width: 20,
            //                 //   height: 20,
            //                 // ),
            //                 // Positioned(
            //                 //   child: Image.asset(
            //                 //       'assets/images/sample-gambar.jpg'),
            //                 //   right: 8,
            //                 //   top: 8,
            //                 //   width: 20,
            //                 //   height: 20,
            //                 // ),
            //                 // Positioned(
            //                 //   child: Image.asset(
            //                 //       'assets/images/sample-gambar.jpg'),
            //                 //   bottom: 0,
            //                 //   width: 20,
            //                 //   height: 20,
            //                 // ),
            //               ],
            //             ),
            //             SizedBox(
            //               height: 8,
            //             ),
            //             Text(
            //               travlogs[index].content,
            //               maxLines: 3,
            //               style: mTravLogContentStyle,
            //             ),
            //             SizedBox(
            //               height: 8,
            //             ),
            //             Text(
            //               travlogs[index].place,
            //               maxLines: 3,
            //               style: mTravLogPlaceStyle,
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),

            // Popular Destination Section
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 5),
              child: Text(
                'Sosial Media',
                style: mTitleStyle,
              ),
            ),

            Container(
              height: 250,
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _instagramURL();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: mFillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mBorderColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/instagram.png',
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Instagram',
                                          style: mServiceTitleStyle),
                                      Text(
                                        '@desa kenanga_official',
                                        style: mServiceSubtitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageSurat()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: mFillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mBorderColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/gmail.png',
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Gmail', style: mServiceTitleStyle),
                                      Text(
                                        'pemdeskenanga@gmail.com',
                                        style: mServiceSubtitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageSurat()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                              color: mFillColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: mBorderColor, width: 1),
                            ),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/whatsapp.png',
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('Whatsapp',
                                          style: mServiceTitleStyle),
                                      Text(
                                        '08',
                                        style: mServiceSubtitleStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ), //
                    ],
                  )
                ],
              ),
            ),

            // Container(
            //   height: 148,
            //   child: ListView.builder(
            //     itemCount: populars.length,
            //     padding: EdgeInsets.only(left: 16, right: 16),
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         elevation: 0,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         child: Container(
            //           height: 140,
            //           width: 140,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(12),
            //               border: Border.all(color: mBorderColor, width: 1)),
            //           child: Padding(
            //             padding: const EdgeInsets.only(top: 8.0, bottom: 16),
            //             child: Column(
            //               children: <Widget>[
            //                 Image.asset(
            //                   populars[index].image,
            //                   height: 74,
            //                 ),
            //                 Text(
            //                   populars[index].name,
            //                   style: mPopularDestinationStyle,
            //                 ),
            //                 Text(
            //                   populars[index].country,
            //                   style: mPopularDestinationSubtitleStyle,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // user
    setState(() {
      nik = pref.get("nik");
      User.connectToAPI(nik).then((value) {
        user = value;
      });
    });
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("nik");
    Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (_) => false);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Batal"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ya"),
      onPressed: () {
        logout();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Apakah Yakin akan Logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _instagramURL() async {
    const url = 'https://www.instagram.com/desakenanga_official/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
