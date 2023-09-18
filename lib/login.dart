import 'package:flutter/material.dart';
import 'package:flutter_application_1/taskscreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            width: 700,
            height: 180,
          ),
          const Text(
            'Task',
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Login',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40, left: 60),
            child: Row(
              children: [
                Text('Enter your login details'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text('Enter your email'),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Text('Enter your password'),
                  ),
                ),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 53, bottom: 5),
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Taskscreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                
                child: Container(
                  height: 50,
                  width: 100,
                  child: Center(child: Text('Log in'))),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign in as new user',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      decorationThickness: 2),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
