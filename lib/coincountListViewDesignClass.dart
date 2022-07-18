import 'package:flutter/material.dart';
import 'package:flutter_crypto_app/coinDetail.dart';
import 'package:flutter_crypto_app/pages/watchlist.dart';
import 'package:oktoast/oktoast.dart';
import 'db_services.dart';
import 'globals.dart' as globals;
import 'watchlistClass.dart';

class CoinCountListViewDesign extends StatelessWidget {
  CoinCountListViewDesign(
      {this.imageUrl,
      this.name,
      this.symbol,
      this.price,
      this.change,
      this.changePercentage,
      this.count,
      this.date,
      this.updatevalue});

  var imageUrl,
      name,
      symbol,
      price,
      change,
      changePercentage,
      count,
      date,
      updatevalue;

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
                          ),
                        ),
                      );
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
                    "IDR " + updatevalue,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 34, 34, 34),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    count,
                    style: TextStyle(
                      fontSize: 17.5,
                      color: int.parse(count) < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 17.5,
                      color: int.parse(count) < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
