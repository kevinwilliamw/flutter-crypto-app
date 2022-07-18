import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../db_services.dart';
import '../globals.dart' as globals;

import '../cryptoClass.dart';

class NetWorth extends StatefulWidget {
  const NetWorth({Key? key}) : super(key: key);

  @override
  _NetWorthState createState() => _NetWorthState();
}

class _NetWorthState extends State<NetWorth> {
  var CoinList;
  var CoinCount;
  List<String> coinWorth = [];

  Future<List<Crypto>> getCryptoList() async {
    cryptoList = [];

    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=idr&order=market_cap_desc&per_page=100&page=1'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      //get user's coincount
      CoinList = await Database.getCoinCountList(globals.username);

      if (values.isNotEmpty && CoinList.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          for (int j = 0; j < CoinList.length; j++) {
            if (values[i] != null &&
                values[i]['name'].toString().toLowerCase() ==
                    CoinList[j].toLowerCase()) {
              Map<String, dynamic> map = values[i];
              cryptoList.add(Crypto.fromJson(map));
            }
          }
        }

        if (mounted) {
          setState(() {
            cryptoList;
            CountCoinWorth();
          });
        }
      }
      return cryptoList;
    } else {
      throw Exception('404 Not Found');
    }
  }

  Future<List<String>> CountCoinWorth() async {
    CoinCount = await Database.getCoinCount(globals.username);
    for (int i = 0; i < cryptoList.length; i++) {
      for (int j = 0; j < CoinList.length; j++) {
        if (cryptoList[i].name.toString().toLowerCase() ==
            CoinList[j].toLowerCase()) {
          coinWorth.add((double.parse(CoinCount[j].toString()) *
                  double.parse(cryptoList[i].price.toString()))
              .toString());
        }
      }
    }
    if (mounted) {
      setState(() {
        coinWorth;
      });
    }
    return coinWorth;
  }

  @override
  void initState() {
    getCryptoList();
    CountCoinWorth();
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
            'Net Worth',
            style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: cryptoList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 50,
                                  width: 50,
                                  child:
                                      Image.network(cryptoList[index].imageUrl))
                            ],
                          ),
                          Column(
                            children: const [
                              SizedBox(
                                width: 16,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    cryptoList[index].name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'IDR ' + cryptoList[index].price.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      'Net = IDR ' +
                                          coinWorth[index].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white))
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: const [
                              SizedBox(
                                width: 16,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    CoinCount[index].toString(),
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
