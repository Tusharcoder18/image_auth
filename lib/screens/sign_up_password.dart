import 'package:flutter/material.dart';
import 'package:image_auth/models/image_database.dart';
import 'package:image_auth/services/authentication_service.dart';
import 'package:image_auth/services/image_fetcher_service.dart';
import 'package:provider/provider.dart';

class SignUpPassword extends StatefulWidget {
  const SignUpPassword({Key? key}) : super(key: key);

  @override
  State<SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  List<String?> images = [];
  bool imagesFetched = false;
  bool isLoading = false;
  List<String?> passwords = [];
  List<bool> tileSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

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
                const Text("Select 5 unique images"),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await context
                        .read<ImageFetcherService>()
                        .fetchRandomImages(context);
                    images = context.read<ImageDatabase>().getRandomImages();
                    setState(() {});
                  },
                  child: const Text("Refresh"),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () async {
                      for (int i = 0; i < tileSelected.length; i++) {
                        if (tileSelected[i] == true) {
                          passwords.add(images[i]);
                        }
                      }
                      await context
                          .read<AuthenticationService>()
                          .signUp(passwords);
                      debugPrint("Signed Up successfully");
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Scaffold(
                          body: Container(
                            color: Colors.lightGreen,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(),
                                const Text(
                                  "Sign up successful",
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
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    },
                                    child: const Text("Sign In")),
                              ],
                            ),
                          ),
                        );
                      }));
                    },
                    child: const Text("Next")),
              ],
            ),
          )),
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
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            tileSelected[index] = !tileSelected[index];
                          });
                          debugPrint(index.toString());
                        },
                        child: Card(
                          color: Colors.blue,
                          child: Image.network(
                            images[index]!,
                            colorBlendMode: BlendMode.modulate,
                            color: tileSelected[index]
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
                        await context
                            .read<ImageFetcherService>()
                            .fetchRandomImages(context);
                        images =
                            context.read<ImageDatabase>().getRandomImages();
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
          ))
        ],
      ),
    );
  }
}
