import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_auth/firebase_options.dart';
import 'package:image_auth/models/image_database.dart';
import 'package:image_auth/screens/sign_up_password.dart';
import 'package:image_auth/screens/sign_in.dart';
import 'package:image_auth/services/authentication_service.dart';
import 'package:image_auth/services/image_fetcher_service.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationService()),
        Provider(create: (context) => ImageDatabase()),
        Provider(create: (context) => ImageFetcherService()),
        Provider(create: (context) => ImageDatabase()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SignIn(),
      ),
    );
  }
}
