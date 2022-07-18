import 'package:flutter/material.dart';
import 'package:flutter_crypto_app/main.dart';
import 'package:flutter_crypto_app/register.dart';
import 'package:oktoast/oktoast.dart';
import 'db_services.dart';
import 'globals.dart' as globals;

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    UsernameController.addListener(() {
      getUsername();
    });
    PasswordController.addListener(() {
      getPassword();
    });

    ////
    // username = 'admin';
    // password = 'admin';
    // LoginButton();
    ////
  }

  void getUsername() {
    username = UsernameController.text;
  }

  void getPassword() {
    password = PasswordController.text;
  }

  void LoginButton() async {
    //check if username and password is empty
    if (username.isNotEmpty && password.isNotEmpty) {
      var existingUser = await Database.getUser(username);
      var existingPassword = await Database.getPassword(username);

      //check if user existed
      //user does exist
      if (username.toLowerCase() == existingUser.toString().toLowerCase()) {
        //check password
        //password matches
        if (password == existingPassword.toString()) {
          showToast("Welcome $username!",
              duration: const Duration(seconds: 2),
              position: ToastPosition.bottom,
              backgroundColor: Colors.black.withOpacity(0.8),
              radius: 25.0,
              textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
              textPadding: const EdgeInsets.all(15));
          //set username to global variable
          globals.username = username;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyHomePage()));
        } else {
          showToast("Incorrect password, please try again",
              duration: const Duration(seconds: 2),
              position: ToastPosition.bottom,
              backgroundColor: Colors.black.withOpacity(0.8),
              radius: 25.0,
              textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
              textPadding: const EdgeInsets.all(15));
        }
        //user does not exist
      } else {
        showToast("User does not exist, please register",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 25.0,
            textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
            textPadding: const EdgeInsets.all(15));
      }
    } else {
      showToast("Please fill all fields",
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.black.withOpacity(0.7),
          radius: 25.0,
          textStyle: const TextStyle(fontSize: 15.0, color: Colors.grey),
          textPadding: const EdgeInsets.all(15));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 82, 82, 82),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
          backgroundColor: const Color.fromARGB(235, 146, 4, 182),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                obscureText: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Username",
                        style: TextStyle(
                            color: Color.fromARGB(255, 202, 202, 202)))),
                controller: UsernameController,
                style:
                    const TextStyle(color: Color.fromARGB(255, 228, 228, 228)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password",
                        style: TextStyle(
                            color: Color.fromARGB(255, 228, 228, 228)))),
                controller: PasswordController,
                style:
                    const TextStyle(color: Color.fromARGB(255, 228, 228, 228)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyRegister()));
                    },
                    child: Text("Register")),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      LoginButton();
                    },
                    child: Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
