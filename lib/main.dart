import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:the_shavi/Pages/Home%20Page/home_page.dart';
import 'package:the_shavi/Reusable%20Value/my_reusable_value.dart';
import 'package:universal_io/io.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid){
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        getMobileNumber();
      } else {
        MyUserDetails.mobileNumber='Not Find';
      }
    });
    getMobileNumber();
    }else{
      MyUserDetails.mobileNumber='Not Find';
    }

  }
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Shavi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
=======
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello Vijay'),
>>>>>>> 1cd2f9205041ff1e39513fdd7124ea40480b238f
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            toolbarHeight: 45),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
              foregroundColor: WidgetStatePropertyAll(Colors.white)),
        ),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.green),
        cardTheme: CardTheme(
            shadowColor: Colors.black, surfaceTintColor: Colors.green[400]),
      ),
      home: HomePage(),
    );
  }


    Future<void> getMobileNumber() async {
      
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      mobileNumber=mobileNumber.substring(4);
      MyUserDetails.mobileNumber = mobileNumber;
    });
  }
   
}