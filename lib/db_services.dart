import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_app/historyClass.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'userClass.dart';
import 'watchlistClass.dart';
import 'coincountClass.dart';

//1 collection 1 variable
var userCollection = FirebaseFirestore.instance.collection("user");
var watchlistCollection = FirebaseFirestore.instance.collection("watchlist");
var coincountCollection = FirebaseFirestore.instance.collection("coincount");
var historyCollection = FirebaseFirestore.instance.collection("history");

class Database {
  static Stream<QuerySnapshot> getAllUser() {
    return userCollection.snapshots();
  }

  static Future<void> addUser({required dataUser newUser}) async {
    DocumentReference docRef = userCollection.doc(newUser.username);

    await docRef
        .set(newUser.toJson())
        .whenComplete(() => print("New user successfully added!"))
        .catchError((e) => print(e));
  }

  static Future<String> getUser(username) async {
    var str = "";

    var querySnapshot = await userCollection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['username'] == username) {
        str = data['username'];
      }
    }

    return str;
  }

  static Future<String> getPassword(username) async {
    var str = "";

    var querySnapshot = await userCollection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['password'] == username) {
        str = data['password'];
      }
    }

    return str;
  }

  static Future<List<String>> getWatchList(username) async {
    List<String> watchlist = [];

    var querySnapshot = await watchlistCollection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['username'] == username) {
        watchlist.add(data['name']);
      }
    }

    return watchlist;
  }

  static Future<void> addWatchList({required dataWatchList newCoin}) async {
    DocumentReference docRef =
        watchlistCollection.doc(newCoin.username + ' | ' + newCoin.name);

    await docRef
        .set(newCoin.toJson())
        .whenComplete(() => print("New coin successfully added!"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteWatchList(
      {required dataWatchList removeCoin}) async {
    DocumentReference docRef =
        watchlistCollection.doc(removeCoin.username + ' | ' + removeCoin.name);

    await docRef
        .delete()
        .whenComplete(() => print("${removeCoin.name} succesfully deleted!"))
        .catchError((e) => print(e));
  }

  static Future<List<String>> getCoinCountList(username) async {
    List<String> coinlist = [];

    var querySnapshot = await coincountCollection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['username'] == username) {
        coinlist.add(data["symnamebol"].toString());
      }
    }

    return coinlist;
  }

  static Future<List<String>> getCoinCount(username) async {
    List<String> coinlist = [];

    var querySnapshot = await coincountCollection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['username'] == username) {
        coinlist.add(data["coincount"]);
      }
    }

    return coinlist;
  }

  static Future<void> setCoinCount({required dataCoinCount newCoin}) async {
    DocumentReference docRef =
        coincountCollection.doc(newCoin.username + ' | ' + newCoin.name);

    await docRef
        .set(newCoin.toJson())
        .whenComplete(
            () => print("${newCoin.name} coin count successfully updated!"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteCoinCount(
      {required dataCoinCount removeCoin}) async {
    DocumentReference docRef =
        coincountCollection.doc(removeCoin.username + ' | ' + removeCoin.name);

    await docRef
        .delete()
        .whenComplete(() =>
            print("${removeCoin.name} succesfully deleted from coin count!"))
        .catchError((e) => print(e));
  }

  static Future<void> addHistory({required dataHistory newHistory}) async {
    DocumentReference docRef = historyCollection.doc();

    await docRef
        .set(newHistory.toJson())
        .whenComplete(() => print(
            "${newHistory.name} ${newHistory.count} succesfully added to history!"))
        .catchError((e) => print(e));
  }

  static Future<List<dataHistory>> getCoinHistory(username) async {
    List<dataHistory> coinhistory = [];

    var querySnapshot =
        await historyCollection.orderBy('date', descending: true).get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['username'] == username) {
        final temphistory = dataHistory(
            username: data['username'],
            name: data['name'],
            count: data['count'],
            date: data['date']);
        coinhistory.add(temphistory);
      }
    }

    return coinhistory;
  }
}
