import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../newsListViewDesignClass.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List newsList = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('test.json');
    final data = await json.decode(response);
    if (mounted) {
      setState(() {
        newsList = data['data'];
      });
    }
  }

  @override
  void initState() {
    readJson();
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
              'News',
              style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              return NewsListViewDesign(
                imageUrl: newsList[index]["thumb_2x"],
                title: newsList[index]["title"],
                description: newsList[index]["description"],
                link: newsList[index]["url"],
                newsSite: newsList[index]["news_site"],
                author: newsList[index]["author"],
              );
            },
          )),
    );
  }
}
