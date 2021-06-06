import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sid_kenanga_mobile/ui/page/dashboard/constants/color_constant.dart';

class BottomNavigationSID extends StatefulWidget {
  @override
  _BottomNavigationSIDState createState() => _BottomNavigationSIDState();
}

class _BottomNavigationSIDState extends State<BottomNavigationSID> {
  int _selectedIndex = 0;

  var bottomTextStyle =
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: mFillColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 15,
                offset: Offset(0, 5))
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(25))),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? new Icon(Icons.home)
                  : new Icon(Icons.home),
              title: Text(
                "Beranda",
                style: bottomTextStyle,
              )),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? new Icon(Icons.person)
                  : new Icon(
                      Icons.person,
                    ),
              title: Text(
                "Profil",
                style: bottomTextStyle,
              ))
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFF4511E),
        unselectedItemColor: mSubtitleColor,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        showUnselectedLabels: true,
        elevation: 0,
      ),
    );
  }
}
