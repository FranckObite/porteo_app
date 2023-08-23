import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite/sqflite.dart';



import 'controllers/database_helper.dart';
import 'views/pricipale_page.dart';

// Here we are using a global variable. You can use something like
// get_it in a production app.


Future<void> main() async {
   initializeDateFormatting('fr_FR', null);
   WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  Database database = await SQLHelper.db();

  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  
  runApp( MyApp(database));
}

class MyApp extends StatelessWidget {
  const MyApp(Database database, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PrincipalPage(),
    );
  }

}

