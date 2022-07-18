// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_crypto_app/pages/home.dart';
import 'package:flutter_crypto_app/pages/news.dart';
import 'package:flutter_crypto_app/pages/watchlist.dart';
import 'package:flutter_crypto_app/pages/coincount.dart';
import 'package:flutter_crypto_app/pages/networth.dart';
import 'package:flutter_crypto_app/pages/profile.dart';
import 'package:oktoast/oktoast.dart';

import 'firebase_options.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OKToast(
      child: MaterialApp(
        // Hide the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Flutter Crypto App',
        home: MyLogin(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": const Home(), "title": "Home"},
    {"screen": const WatchList(), "title": "Watch List"},
    {"screen": const NewsPage(), "title": "News"},
    {"screen": const CoinCount(), "title": "Coin Count"},
    {"screen": const NetWorth(), "title": "Net Worth"},
    {"screen": const Profile(), "title": "Profile"}
  ];

  void selectScreen(int index) {
    if (mounted) {
      setState(() {
        _selectedScreenIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: selectScreen,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "Watch List",
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: "News",
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: "Coin Count",
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: "Net Worth",
              backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.lightBlue)
        ],
      ),
    );
  }
}
