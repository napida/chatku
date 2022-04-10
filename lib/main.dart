import 'package:chatku/login/email_login.dart';
import 'package:chatku/addFriend/addfriend.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'addFriend/contact.dart';
// Import the generated file
import 'addFriend/friendlist.dart';
import 'firebase_options.dart';
import 'chat/chat.dart';
import 'navbar.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // flutter binding ensure initialized okay


  await Firebase.initializeApp(   options: DefaultFirebaseOptions.currentPlatform,   );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  // const MyApp({Key? key)} : super(key: key);

  final _initialization = Firebase.initializeApp();   // don't want to restart entire widget of it

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // in case this is not yet done initializing in case firebase
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          // home: EmailLogin(),
          initialRoute: '/',
          routes: {
            '/addfriend': (context) => MyHomePage(),
            '/friend': (context) => SecondPage(),
            '/chat': (context) => ChatPage(),
            '/': (context) => EmailLogin(),
          },
        );
      }
    );
  }
}



