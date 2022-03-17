import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Image Authentication")),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [Login()],
      ),
    );
  }
}

class Login extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      child: _formLogin(),
    );
  }
}

Widget _formLogin() {
  return Center(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
        ),
        Container(
          width: 500.0,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter email or Phone number',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: 500,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              // counterText: 'Forgot password?',
              suffixIcon: Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: TextButton(
              child: Text(
                'Forget password?',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {},
            )),
        Container(
          width: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign In"))),
            onPressed: () => print("it's pressed"),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              height: 50,
            ),
          ),
        ]),
      ],
    ),
  );
}
