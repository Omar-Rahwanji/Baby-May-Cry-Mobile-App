import 'admin_dashbaord.dart';
import 'crying_analytics.dart';
import 'crying_history.dart';
import 'profile.dart';
import 'parent_dashboard.dart';
import 'package:baby_may_cry/services/auth.dart';
import 'package:baby_may_cry/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String userRole = "";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final Map<String, Object?> userData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: CustomColors.secondary,
              ),
              accountName: Text(userData['fullName'].toString()),
              accountEmail: Text(userData['email'].toString()),
              currentAccountPicture: const Hero(
                tag: "logo",
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text("Profile".tr()),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();

                Navigator.pushNamed(context, "/profile", arguments: {
                  'email': prefs.getString('email'),
                  'fullName': prefs.getString('fullName')
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text("Language settings".tr()),
              onTap: () {
                Navigator.pushNamed(context, "/language-settings");
              },
            ),
            const Divider(
              thickness: 3,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
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
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: Colors.grey,
              icon: Image.asset("assets/images/menu.png",
                  width: screenWidth * 0.08, color: Colors.grey),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: '',
            );
          },
        ),
        elevation: 8,
        title: Container(
          margin: EdgeInsets.only(top: screenHeight * 0.01),
          child: Hero(
            tag: "logo",
            child: Image.asset(
              "assets/images/logo.png",
              width: screenWidth * 0.255,
            ),
          ),
        ),
        centerTitle: true,
        toolbarHeight: screenHeight * 0.12,
        actions: [
          IconButton(
            iconSize: screenWidth * 0.08,
            color: Colors.grey,
            padding: EdgeInsets.only(right: screenWidth * 0.005),
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, "/about-us");
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: CustomColors.primary,
        currentIndex: currentPageIndex,
        elevation: 16,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        onTap: (newPageIndex) {
          setState(() {
            currentPageIndex = newPageIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "",
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: [
          HomePage.userRole == "admin"
              ? const AdminDashboard()
              : const ParentDashboard(),
          HomePage.userRole == "admin"
              ? const CryingAnalyticsPage()
              : const CryingHistoryPage(),
          const ProfilePage(),
        ],
      ),
    );
  }
}
