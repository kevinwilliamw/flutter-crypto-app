import 'dart:html';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class NewsListViewDesign extends StatelessWidget {
  NewsListViewDesign(
      {this.imageUrl,
      this.title,
      this.description,
      this.link,
      this.newsSite,
      this.author});

  var imageUrl, title, description, link, newsSite, author;

  Future<void> UrlLauncher(Uri url) async {
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      showToast("Failed to Load Site",
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.black.withOpacity(0.8),
          radius: 25.0,
          textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
          textPadding: const EdgeInsets.all(15));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        //height: 150,
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 241, 241),
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
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 163, 163, 163),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Image.network(imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "News From " + newsSite,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 34, 34, 34),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      " ",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 34, 34, 34),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 27, 27, 27),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      " ",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 34, 34, 34),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(
                    //   description,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: const TextStyle(
                    //     fontSize: 20,
                    //     color: Color.fromARGB(255, 19, 19, 19),
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    ElevatedButton(
                      onPressed: () {
                        UrlLauncher(Uri.parse(link));
                      },
                      child: Text(
                        link,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 51, 102, 187),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(0, 1, 1, 1)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
