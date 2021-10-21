import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LOGIN",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Login to enter our stores",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                defaultTextForm(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    prefix: Icons.email_outlined,
                    label: "Email Address",
                    validate: (String text) {
                      if (text.isEmpty) {
                        print("Email address can\'t be empty");
                      }
                    }),
                SizedBox(
                  height: 10,
                ),
                defaultTextForm(
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    prefix: Icons.lock,
                    label: "Password",
                    suffix: Icons.visibility,
                    suffixPressed: () {}),
                SizedBox(
                  height: 25,
                ),
                defaultButton(label: "LOGIN"),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [Text("Don\'t have an account?"), TextButton(onPressed: () {}, child: Text("Register Now"))],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
