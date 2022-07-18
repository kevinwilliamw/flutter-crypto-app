import 'package:flutter/material.dart';

class coinDetail extends StatelessWidget {
  coinDetail(
      {this.imageUrl,
      this.name,
      this.symbol,
      this.price,
      this.change,
      this.changePercentage,
      this.username});

  var imageUrl, name, symbol, price, change, changePercentage, username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 82, 82, 82),
      ),
      title: "Coin Detail",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Coin Detail"),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: ElevatedButton(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: const Color.fromARGB(108, 0, 0, 0)),
              ),
            ),
            Container(
              height: 150,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                child: Image.network(imageUrl),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 32, 4),
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(200, 255, 255, 255)),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 32, 4),
                    child: Text(
                      "IDR " + price.toDouble().toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(200, 255, 255, 255)),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 32, 4),
                    child: Text(
                      changePercentage.toDouble() < 0
                          ? changePercentage.toDouble().toString() + '%'
                          : '+' + changePercentage.toDouble().toString() + '%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: changePercentage.toDouble() < 0
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 32, 4),
                    child: Text(
                      change.toDouble() < 0
                          ? change.toDouble().toString()
                          : '+' + change.toDouble().toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: change.toDouble() < 0
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
