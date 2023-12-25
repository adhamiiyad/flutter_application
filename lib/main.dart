import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/about.dart';
import 'package:flutter_application/login.dart';
import 'signup.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


const appBarColor = Colors.purple;
const TextStyle style1 = TextStyle(
  fontSize: 16,
  color: Colors.blue,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: drw(context),
      appBar: AppBar(
        title: const Text('mp'),
        backgroundColor: appBarColor,
      ),
      body: const Center(child: Text('datkra')),
      bottomNavigationBar: btm(context),
      // bottomNavigationBar: BottomNavigationBar(
      //   // backgroundColor: Colors.red,
      //   items: const [
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.purple,
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.purple,
      //       icon: Icon(Icons.login),
      //       label: 'Signup',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.purple,
      //       icon: Icon(Icons.account_box_sharp),
      //       label: 'Login',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.purple,
      //       icon: Icon(Icons.info),
      //       label: 'About',
      //     ),
      //   ],
      //   onTap: (value) {
      //     switch (value) {
      //       case 1:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const Signup()));
      //       case 2:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const Login()));
      //       case 3:
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => const About()));
      //     }
      //   },
      // ),
    );
  }
}


BottomNavigationBar btm(context) => BottomNavigationBar(
  backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login, color: Colors.black,),
            label: 'Signup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_sharp, color: Colors.black,),
            label: 'Login',
          ),
        ],
        onTap: (value) {
          switch (value) {
            case 0:
            Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Signup()));
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
          }
        },
      );

Drawer drw(context) => Drawer(
        elevation: 30,
        backgroundColor: Colors.white,
        width: 290,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
          children: [
            Container(
              height: 100,
              width: 10,
              child: Image.network('https://t4.ftcdn.net/jpg/00/96/11/19/360_F_96111906_YcqIuPOM4VTdWVGkc0T1UbGv5Ea8NQTl.jpg'),
            ),
            ListTile(
              title: const Text('Sign-Up'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Signup()),
                );
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
              },
            ),
            ListTile(
              title: const Text('Support'),
              onTap: () {},
            ),
          ],
        ),
      );

