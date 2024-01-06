import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/Pages/status_page.dart';
import 'Pages/home_page.dart';
import 'services/socket_services.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
      ],
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control Casa Automatizada', 
      initialRoute: 'status',
      routes: {
        'home'    :  ((context) => HomePage()),
        'status'  :  ((context) => StatusPage()),

      },
      // home: MyHomePage(),
      // darkTheme: ThemeData.dark(), 
      // home: MenuPage()
    );
  }
}
