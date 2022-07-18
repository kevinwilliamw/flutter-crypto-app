import 'package:flutter/material.dart';
import 'package:flutter_crypto_app/coinDetail.dart';
import 'package:flutter_crypto_app/pages/watchlist.dart';
import 'package:oktoast/oktoast.dart';
import 'db_services.dart';
import 'globals.dart' as globals;
import 'watchlistClass.dart';

class WatchListListViewDesign extends StatelessWidget {
  WatchListListViewDesign(
      {this.imageUrl,
      this.name,
      this.symbol,
      this.price,
      this.change,
      this.changePercentage});

  var imageUrl, name, symbol, price, change, changePercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 172, 172, 172),
              offset: Offset(3, 3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255),
              offset: Offset(-3, -3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 70,
                width: 70,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => coinDetail(
                                    imageUrl: imageUrl,
                                    name: name,
                                    symbol: symbol,
                                    price: price,
                                    change: change,
                                    changePercentage: changePercentage,
                                    username: globals.username,
                                  )));
                    },
                    child: Image.network(imageUrl),
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(108, 0, 0, 0),
                        shape: const StadiumBorder()),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 27, 27, 27),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      symbol.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 19, 19, 19),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "IDR " + price.toDouble().toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 34, 34, 34),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'IDR ' +
                        (change.toDouble() < 0
                            ? change.toDouble().toString()
                            : '+' + change.toDouble().toString()),
                    style: TextStyle(
                      fontSize: 17.5,
                      color: change.toDouble() < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    changePercentage.toDouble() < 0
                        ? changePercentage.toDouble().toString() + '%'
                        : '+' + changePercentage.toDouble().toString() + '%',
                    style: TextStyle(
                      fontSize: 17.5,
                      color: changePercentage.toDouble() < 0
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 16, 4),
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () async {
                        //remove coin to watch list FIREBASE
                        final removeCoin = dataWatchList(
                            username: globals.username, name: name);
                        await Database.deleteWatchList(removeCoin: removeCoin);
                        showToast("$name successfully removed from Watch List",
                            duration: const Duration(seconds: 2),
                            position: ToastPosition.bottom,
                            backgroundColor: Colors.black.withOpacity(0.8),
                            radius: 25.0,
                            textStyle: const TextStyle(
                                fontSize: 15.0, color: Colors.white),
                            textPadding: const EdgeInsets.all(15));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const WatchList()));
                      },
                      child: const Icon(
                        Icons.delete_outline_outlined,
                        size: 35,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(108, 0, 0, 0),
                          shape: const StadiumBorder()),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
