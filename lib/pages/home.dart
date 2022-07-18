import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../cryptoClass.dart';
import '../cryptoListViewDesignClass.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Crypto>> getCryptoList() async {
    cryptoList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=idr&order=market_cap_desc&per_page=100&page=1'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            cryptoList.add(Crypto.fromJson(map));
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
    Timer.periodic(const Duration(seconds: 15), (timer) => getCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 82, 82, 82),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Flutter Crypto App',
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
            return CryptoListViewDesign(
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
