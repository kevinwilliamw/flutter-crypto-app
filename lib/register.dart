import 'package:flutter/material.dart';
import 'package:flutter_crypto_app/userClass.dart';
import 'package:flutter_crypto_app/db_services.dart';
import 'package:oktoast/oktoast.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();

  String username = "";
  String password = "";
  String confirmpassword = "";

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    UsernameController.addListener(() {
      GetUsername();
    });
    PasswordController.addListener(() {
      GetPassword();
    });
    ConfirmPasswordController.addListener(() {
      GetConfirmPassword();
    });
  }

  void GetUsername() {
    username = UsernameController.text;
  }

  void GetPassword() {
    password = PasswordController.text;
  }

  void GetConfirmPassword() {
    confirmpassword = ConfirmPasswordController.text;
  }

  void _togglePassword() {
    if (mounted) {
      setState(() {
        _obscureTextPassword = !_obscureTextPassword;
      });
    }
  }

  void _toggleConfirmPassword() {
    if (mounted) {
      setState(() {
        _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
      });
    }
  }

  void RegisterButton() async {
    //register user to database
    //check for empty fields
    if (username.isNotEmpty &&
        password.isNotEmpty &&
        confirmpassword.isNotEmpty) {
      //check username on database
      var existingUser = await Database.getUser(username);

      if (username.toLowerCase() == existingUser.toString().toLowerCase()) {
        showToast("User existed, please enter a new username",
            duration: const Duration(seconds: 2),
            position: ToastPosition.bottom,
            backgroundColor: Colors.black.withOpacity(0.8),
            radius: 25.0,
            textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
            textPadding: const EdgeInsets.all(15));
      } else {
        //check if password == confirm password
        if (password == confirmpassword) {
          final newUser = dataUser(username: username, password: password);

          await Database.addUser(newUser: newUser);
          showToast("New user successfully registered!",
              duration: const Duration(seconds: 2),
              position: ToastPosition.bottom,
              backgroundColor: Colors.black.withOpacity(0.8),
              radius: 25.0,
              textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
              textPadding: const EdgeInsets.all(15));
          //back to login page after success register
          Navigator.pop(context);
        } else {
          showToast("Password does not match!",
              duration: const Duration(seconds: 2),
              position: ToastPosition.bottom,
              backgroundColor: Colors.black.withOpacity(0.8),
              radius: 25.0,
              textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
              textPadding: const EdgeInsets.all(15));
        }
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
      title: "Register",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Register Page"),
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
                obscureText: _obscureTextPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text("Password",
                      style:
                          TextStyle(color: Color.fromARGB(255, 228, 228, 228))),
                  suffixIcon: IconButton(
                    onPressed: _togglePassword,
                    icon: Icon(
                      _obscureTextPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                controller: PasswordController,
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
                obscureText: _obscureTextConfirmPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text("Confirm Password",
                      style:
                          TextStyle(color: Color.fromARGB(255, 228, 228, 228))),
                  suffixIcon: IconButton(
                    onPressed: _toggleConfirmPassword,
                    icon: Icon(
                      _obscureTextConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                controller: ConfirmPasswordController,
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
                      RegisterButton();
                    },
                    child: const Text("Register")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
