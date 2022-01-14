import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_game/home_view.dart';
import 'package:word_game/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServiceLocator();
  await dictionary().ready;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey.shade300,
        fontFamily: GoogleFonts.dmSans().fontFamily,
        dividerColor: Colors.grey.shade400,
      ),
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
