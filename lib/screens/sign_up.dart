import 'package:flutter/material.dart';
import 'package:image_auth/screens/sign_up_password.dart';
import 'package:image_auth/services/authentication_service.dart';
import 'package:image_auth/widgets/custom_button.dart';
import 'package:image_auth/widgets/text_box.dart';
import 'package:provider/provider.dart';

import '../widgets/divider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                InkWell(
                  onTap: () => context.read<AuthenticationService>().signOut(),
                  child: const FlutterLogo(
                    size: 50,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                textBox("Email", controllerEmail!),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                    title: "Verify",
                    icon: Icons.verified,
                    onTap: () async {
                      await context
                          .read<AuthenticationService>()
                          .createUser(controllerEmail?.text);
                      debugPrint(controllerEmail?.text);
                    }),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                    title: "Next",
                    icon: Icons.navigate_next,
                    onTap: () async {
                      var emailVerified = await context
                          .read<AuthenticationService>()
                          .isVerified();
                      if (emailVerified) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpPassword()));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Email Not Verified!"),
                                  content: const Text(
                                      "Please verify your email to proceed."),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Okay"))
                                  ],
                                ));
                      }
                      debugPrint(controllerEmail?.text);
                    }),
                divider(),
                CustomButton(
                    title: "Sign In",
                    icon: Icons.add,
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
