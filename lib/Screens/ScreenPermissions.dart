import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:sj_weather/Screens/ScreenForecastToday.dart';

class ScreenPermissions extends StatefulWidget {
  @override
  _ScreenPermissionsState createState() => _ScreenPermissionsState();
}

class _ScreenPermissionsState extends State<ScreenPermissions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Misty"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Text(
              "Разрешите доступ к сервисам геолокации, чтобы показывать прогноз для Вашего актуального расположения.",
              textAlign: TextAlign.center,
            ),
          ),
          OutlineButton(
            onPressed: () async {
              LocationPermission permission =
                  await Geolocator.requestPermission();

              if (permission == LocationPermission.always ||
                  permission == LocationPermission.whileInUse) {
                print("Permission granted");
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => ScreenForecastToday()));
              } else {
                print("No permission granted");

                return showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Вы не дали согласие.'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                                'Если Вы хотите пользоваться приложением, то Вам нужно зайти в системные настройки и дать необходимое разрешение.'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('ОК.'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text("Разрешаю узнать, где нахожусь"),
          )
        ]),
      ),
    );
  }
}
