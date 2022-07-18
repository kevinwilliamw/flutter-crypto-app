import 'package:flutter_crypto_app/login.dart';
import '../globals.dart' as globals;
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
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
            title: Row(
              children: const [
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(Icons.person)
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        size: 100,
                        color: Colors.teal,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        globals.username,
                        style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 221, 221, 221)),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 4),
                                        blurRadius: 5.0)
                                  ],
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [
                                        0.0,
                                        1.0
                                      ],
                                      colors: [
                                        Color.fromARGB(255, 50, 163, 197),
                                        Color.fromARGB(255, 31, 50, 158)
                                      ]),
                                  color: Colors.deepPurple.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: ElevatedButton(
                                onPressed: () {
                                  globals.username = "";
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) {
                                      return const MyLogin();
                                    },
                                    settings: const RouteSettings(
                                      name: 'LoginPage',
                                    ),
                                  ));
                                  Navigator.of(context).popUntil((route) {
                                    return route.settings.name == 'LoginPage';
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.power_settings_new),
                                    SizedBox(width: 10),
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    )
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(0, 24, 128, 247)),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Version : 1.0 Build Number : 1",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Copyright © Kelompok 25 Petra Christian University",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
