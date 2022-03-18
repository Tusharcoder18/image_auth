import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_auth/services/authentication_service.dart';
import 'package:provider/provider.dart';

import '../models/image_database.dart';
import '../services/image_fetcher_service.dart';

class SignInPassword extends StatefulWidget {
  const SignInPassword({Key? key}) : super(key: key);

  @override
  State<SignInPassword> createState() => _SignInPasswordState();
}

class _SignInPasswordState extends State<SignInPassword> {
  List<List<String?>> roundsImages = [];
  List<String?> password = [];
  int roundCount = 0;
  int? tileSelected;
  bool isLoading = false;
  bool imagesFetched = false;
  User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Select the correct image from given set of images.(Round ${roundCount + 1})"),
                  const SizedBox(height: 12),
                  ElevatedButton(
                      onPressed: () async {
                        if (roundCount < 4) {
                          password.add(roundsImages[roundCount][tileSelected!]);
                          setState(() {
                            tileSelected = null;
                            roundCount++;
                          });
                        } else {
                          password.add(roundsImages[roundCount][tileSelected!]);
                          for (String? url in password) {
                            debugPrint(url);
                          }
                          currentUser = FirebaseAuth.instance.currentUser;
                          var email = currentUser?.email;
                          await context
                              .read<AuthenticationService>()
                              .signIn(email, password);
                          if (context
                              .read<AuthenticationService>()
                              .isSignedIn()) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Scaffold(
                                body: Container(
                                  color: Colors.lightBlue,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(),
                                      const Text(
                                        "Sign in successful",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await context
                                                .read<AuthenticationService>()
                                                .signOut();
                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          },
                                          child: const Text("Sign Out")),
                                    ],
                                  ),
                                ),
                              );
                            }));
                          }
                        }
                      },
                      child: const Text("Next")),
                ],
              ),
            ),
          ),
          Expanded(
              child: Card(
            elevation: 10,
            child: imagesFetched
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3),
                    itemCount: roundsImages[0].length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            tileSelected = index;
                          });
                          debugPrint(index.toString());
                        },
                        child: Card(
                          color: Colors.blue,
                          child: Image.network(
                            roundsImages[roundCount][index]!,
                            colorBlendMode: BlendMode.modulate,
                            color: tileSelected == index
                                ? Colors.white.withOpacity(0.1)
                                : null,
                          ),
                        ),
                      );
                    })
                : Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        isLoading = true;
                        currentUser = FirebaseAuth.instance.currentUser;
                        var email = currentUser?.email;
                        await context
                            .read<ImageFetcherService>()
                            .fetchImagesForSignIn(context, email);
                        roundsImages =
                            context.read<ImageDatabase>().getRoundsImages();
                        setState(() {
                          imagesFetched = true;
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Fetch Images"),
                    ),
                  ),
          )),
        ],
      ),
    );
  }
}
