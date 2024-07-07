import 'package:flutter/material.dart';

import 'package:flutter_masterclass/screens/create/create.dart';
import 'package:flutter_masterclass/screens/profile/profile.dart';
import 'package:flutter_masterclass/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'screens/home/home.dart';
import 'services/character_store.dart';

//Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => CharacterStore(),
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      getPages: [
        GetPage(name: '/create', page: () => const Creates()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/profile', page: () => Profile(char: Get.arguments)),
      ],
      home: const Home(),
    ),
  ));
}

// sandbox
class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
        backgroundColor: Colors.grey,
      ),
      body: const Text('sandbox'),
    );
  }
}
