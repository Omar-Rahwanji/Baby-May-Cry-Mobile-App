

import 'package:baby_may_cry/pages/booking.dart';
import 'package:baby_may_cry/pages/offices.dart';
import 'package:baby_may_cry/pages/services.dart';
import 'package:baby_may_cry/services/auth.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  List<Widget> navPages = [
    BookingPage(),
    ServicesPage(),
    OfficesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, Object?> userData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userData['userName'].toString()),
              accountEmail: Text(userData['userEmail'].toString()),
              currentAccountPicture: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile".tr()),
              onTap: () {
                Navigator.pushNamed(context, "/profile", arguments: {
                  'userName': userData['userName'],
                  'userEmail': userData['userEmail'],
                  'userPhoneNumber': userData['userPhoneNumber']
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.airport_shuttle),
              title: Text("Bookings history".tr()),
              onTap: () {
                Navigator.pushNamed(context, "/bookings-history");
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Language settings".tr()),
              onTap: () {
                Navigator.pushNamed(context, "/language-settings");
              },
            ),
            Divider(
              thickness: 3,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out".tr()),
              onTap: () {
                AuthService.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/login",
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: '',
            );
          },
        ),
        title: Text("ABS Booking"),
        centerTitle: true,
        elevation: 16,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, "/about-us");
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CustomColors.primary,
        currentIndex: this.currentPageIndex,
        elevation: 16,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        onTap: (newPageIndex) {
          setState(() {
            this.currentPageIndex = newPageIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airport_shuttle),
            label: "Services".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: "Offices".tr(),
          ),
        ],
      ),
      body: this.navPages[this.currentPageIndex],
    );
  }
}
