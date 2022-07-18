import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_app/cryptoClass.dart';
import 'package:http/http.dart' as http;
import '../db_services.dart';
import '../globals.dart' as globals;
import '../watchlistListViewDesignClass.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  Future<List<Crypto>> getCryptoList() async {
    cryptoList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=idr&order=market_cap_desc&per_page=100&page=1'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      //get user's wathclist
      var userWatchList = await Database.getWatchList(globals.username);

      if (values.isNotEmpty && userWatchList.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          for (int j = 0; j < userWatchList.length; j++) {
            if (values[i] != null &&
                values[i]['name'].toString().toLowerCase() ==
                    userWatchList[j].toLowerCase()) {
              Map<String, dynamic> map = values[i];
              cryptoList.add(Crypto.fromJson(map));
            }
          }
        }
        if (mounted) {
          setState(() {
            cryptoList;
          });
        }
      }
      return cryptoList;
    } else {
      throw Exception('404 Not Found');
    }
  }

  @override
  void initState() {
    getCryptoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 82, 82, 82)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Watch List',
            style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: cryptoList.length,
          itemBuilder: (context, index) {
            return WatchListListViewDesign(
                imageUrl: cryptoList[index].imageUrl,
                name: cryptoList[index].name,
                symbol: cryptoList[index].symbol,
                price: cryptoList[index].price.toDouble(),
                change: cryptoList[index].change.toDouble(),
                changePercentage:
                    cryptoList[index].changePercentage.toDouble());
          },
        ),
      ),
    );
  }
}
