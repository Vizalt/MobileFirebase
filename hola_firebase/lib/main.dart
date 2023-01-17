import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hola_firebase/screen/comic_saved_list_screen.dart';
import 'package:hola_firebase/screen/comics_grid_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'Marvel Comics',
      initialRoute: '/',
      routes: {
        '/': (_) => const ComicGridScreen(),
        '/saved-list': (_) => const ComicListScreen(),
        //'/selected-comic': (_) => ComicSelectedScreen(),
      },
    );
  }
}
