import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_app/coincountListViewDesignClass.dart';
import 'package:flutter_crypto_app/historyClass.dart';
import 'package:oktoast/oktoast.dart';
import '../cryptoClass.dart';
import 'package:http/http.dart' as http;
import '../db_services.dart';
import '../globals.dart' as globals;
import '../coincountClass.dart';
import '../globals.dart';
import 'package:intl/intl.dart';

class CoinCount extends StatefulWidget {
  const CoinCount({Key? key}) : super(key: key);

  @override
  _CoinCountState createState() => _CoinCountState();
}

class _CoinCountState extends State<CoinCount> {
  @override
  void initState() {
    _CoinInputcontroller.addListener(() {
      coincountText = _CoinInputcontroller.text;
    });
    getCoinHistory();
    setState(() {
      getCryptoList();
      NetworthCounter();
    });
    super.initState();
  }

  String selectedValue = "";
  String coincountText = "";

  final TextEditingController _CoinInputcontroller = TextEditingController();

  void getCoinCount() {
    coincountText = _CoinInputcontroller.text;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  //crypto list
  // var cryptolist = [];

  //networth calculation
  var watchlist = [];
  var coincount = [];

  //coin history
  var coinhistory = [];
  var updatevalue = [];

  Future<List<Crypto>> getCryptoList() async {
    cryptoList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=idr&order=market_cap_desc&per_page=100&page=1'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      //get user's wathclist
      watchlist = await Database.getWatchList(globals.username);

      if (values.isNotEmpty && coinhistory.isNotEmpty) {
        for (int i = 0; i < coinhistory.length; i++) {
          for (int j = 0; j < values.length; j++) {
            if (values[j] != null &&
                values[j]['name'].toString().toLowerCase() ==
                    coinhistory[i].name.toLowerCase()) {
              Map<String, dynamic> map = values[j];
              cryptoList.add(Crypto.fromJson(map));
            }
          }
        }
        setState(() {
          cryptoList;
        });
      }

      if (watchlist.isEmpty) {
        showToast("No coins detected, please add coins from Home Page",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 25.0,
            textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
            textPadding: const EdgeInsets.all(15));
      } else {
        selectedValue = watchlist[0];
      }

      for (int i = 0; i < coinhistory.length; i++) {
        var temp = (int.parse(coinhistory[i].count) * cryptoList[i].price);
        updatevalue.add(temp.toString());
      }

      return cryptoList;
    } else {
      throw Exception('404 Not Found');
    }
  }

  double networthCount = 0.0;

  void NetworthCounter() async {
    double nc = 0.0;
    var coinname = await Database.getCoinCountList(username);
    coincount = await Database.getCoinCount(username);
    for (int i = 0; i < cryptoList.length; i++) {
      for (int j = 0; j < coinname.length; j++) {
        if (cryptoList[i].name.toString().toLowerCase() ==
            coinname[j].toLowerCase()) {
          var tempsubtotal = double.parse(coincount[j].toString()) *
              double.parse(cryptoList[i].price.toString());
          nc += tempsubtotal;
        }
      }
    }
    networthCount = nc;
  }

  void addHistory() async {
    DateTime now = DateTime.now();
    var date = DateFormat('dd-MM-yyyy kk:mm:ss').format(now).toString();
    final newHistory = dataHistory(
        username: globals.username,
        name: selectedValue,
        count: coincountText,
        date: date);
    await Database.addHistory(newHistory: newHistory);
  }

  void setCrypto() async {
    if (selectedValue.toString().isEmpty || coincountText.toString().isEmpty) {
      showToast("Please fill all fields",
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.black.withOpacity(0.8),
          radius: 25.0,
          textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
          textPadding: const EdgeInsets.all(15));
    } else {
      if (!isNumeric(coincountText)) {
        showToast("Please input a numeric value",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 25.0,
            textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
            textPadding: const EdgeInsets.all(15));
      } else {
        var coinCountList = await Database.getCoinCountList(username);
        var coinCount = await Database.getCoinCount(username);

        if (coinCountList.isEmpty || !coinCountList.contains(selectedValue)) {
          final newCoin = dataCoinCount(
              username: globals.username,
              name: selectedValue,
              coincount: (int.parse(coincountText.toString())).toString());
          await Database.setCoinCount(newCoin: newCoin);
        } else {
          for (int i = 0; i < coinCountList.length; i++) {
            if (coinCountList[i].toString() == selectedValue) {
              var tempcoincount = 0;
              if (coinCount[i].isNotEmpty) {
                tempcoincount = int.parse(coinCount[i].toString());
              }
              final newCoin = dataCoinCount(
                  username: globals.username,
                  name: selectedValue,
                  coincount:
                      (int.parse(coincountText.toString()) + tempcoincount)
                          .toString());
              await Database.setCoinCount(newCoin: newCoin);
            }
          }
        }

        //add coin update history
        addHistory();

        showToast("$selectedValue coin count succesfully updated",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 25.0,
            textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
            textPadding: const EdgeInsets.all(15));

        //clear field after udpating
        _CoinInputcontroller.clear();

        //refresh page
        // setState(() {
        //   getCoinHistory();
        //   getCryptoList();
        //   NetworthCounter();
        // });
      }
    }
  }

  void getCoinHistory() async {
    coinhistory = await Database.getCoinHistory(globals.username);
  }

  @override
  void dispose() {
    _CoinInputcontroller.dispose();
    super.dispose();
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
            'Coin Count',
            style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 200,
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DropdownButton(
                              //iconEnabledColor: Colors.red,
                              isExpanded: true,
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                    child: Icon(
                                      Icons.list,
                                      size: 20,
                                      // color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Select Item',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              items: watchlist
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 0, 0, 0),
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                              dropdownColor: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(32),
                        child: SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _CoinInputcontroller,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              label: Text(
                                "Qty",
                                style: TextStyle(
                                    // color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          size: 16,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Update Crypto",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      setCrypto();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.show_chart,
                          size: 16,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Show My Net",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        NetworthCounter();
                      });
                    },
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "My Networth : IDR " + networthCount.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: coinhistory.length,
                itemBuilder: (context, index) {
                  return CoinCountListViewDesign(
                      imageUrl: cryptoList[index].imageUrl,
                      name: cryptoList[index].name,
                      symbol: cryptoList[index].symbol,
                      price: cryptoList[index].price.toDouble(),
                      change: cryptoList[index].change.toDouble(),
                      changePercentage:
                          cryptoList[index].changePercentage.toDouble(),
                      count: coinhistory[index].count.toString(),
                      date: coinhistory[index].date.toString(),
                      updatevalue: updatevalue[index].toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
