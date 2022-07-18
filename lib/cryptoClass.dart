import 'package:flutter/material.dart';

class Crypto {
  Crypto(
      {this.imageUrl,
      this.name,
      this.symbol,
      this.price,
      this.change,
      this.changePercentage});

  var imageUrl, name, symbol, price, change, changePercentage;

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      imageUrl: json['image'],
      name: json['name'],
      symbol: json['symbol'],
      price: json['current_price'],
      change: json['price_change_24h'],
      changePercentage: json['price_change_percentage_24h'],
    );
  }
}

List<Crypto> cryptoList = [];
List<Crypto> IhaveIt = [];
