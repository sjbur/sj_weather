import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:Misty/Screens/ScreenFavorites.dart';
// import 'package:Misty/Screens/ScreenForecastToday.dart';
import 'package:Misty/Screens/ScreenPermissions.dart';
import 'package:Misty/Screens/ScreenForecast.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool debug = false;
  bool permissionGranted = false;

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  void checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      print("Permission granted");
      setState(() {
        permissionGranted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Misty',
        home: permissionGranted ? ScreenForecast() : ScreenPermissions(),
        debugShowCheckedModeBanner: debug,
        theme: ThemeData(
          brightness: Brightness.dark,
          // primaryColor: Colors.white,
          accentColor: Colors.grey,
        ));
  }
}
