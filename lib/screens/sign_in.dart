import 'package:flutter/material.dart';
import 'package:image_auth/services/authentication_service.dart';
import 'package:image_auth/widgets/custom_button.dart';
import 'package:image_auth/widgets/text_box.dart';
import 'package:provider/provider.dart';

import '../widgets/divider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController? controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: screenWidth * 0.3,
            height: screenWidth * 0.3,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FlutterLogo(
                  size: 50,
                ),
                const SizedBox(
                  height: 12,
                ),
                textBox("Email", controllerEmail!),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                    title: "Next",
                    icon: Icons.navigate_next,
                    onTap: () async {
                      await context
                          .read<AuthenticationService>()
                          .createUser(controllerEmail?.text);
                      debugPrint(controllerEmail?.text);
                    }),
                divider(),
                CustomButton(title: "Sign Up", icon: Icons.add, onTap: () {}),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
