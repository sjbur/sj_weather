import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sj_weather/Screens/Widgets/AppTabsMenu.dart';
import 'package:sj_weather/Screens/Widgets/AppTopBar.dart';

import 'package:sj_weather/Screens/Widgets/DayForecastTab.dart';
import 'package:sj_weather/Screens/Widgets/WeekForecastTab.dart';
import 'package:sj_weather/Scripts/favorites.dart';

import 'package:sj_weather/YandexPogoda.dart' as Pogoda;

import 'ScreenFavorites.dart';

class ScreenForecast extends StatefulWidget {
  @override
  _ScreenForecastState createState() => _ScreenForecastState();
}

class _ScreenForecastState extends State<ScreenForecast> {
  String state = "today";

  Pogoda.Forecast forecast;
  Position position;
  Favorites favs;

  bool basedOnLocation = true;
  bool favor = false;
  String currentURL;

  @override
  void initState() {
    super.initState();
    getForecast();
  }

  void getForecast({String cityUrl}) async {
    try {
      if (forecast == null) {
        favs = new Favorites();
        await favs.init();
        favor = false;

        if (cityUrl == null) {
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          forecast = await Pogoda.searchForecastByCoords(
              position.longitude, position.latitude);

          basedOnLocation = true;
        } else {
          forecast = await Pogoda.extract(cityUrl);
          currentURL = cityUrl;
          basedOnLocation = false;
        }

        try {
          favs.cities.forEach((element) {
            if (element.cityName == forecast.placeName) favor = true;
          });
        } catch (ex) {
          print(ex);
        }

        print("favor: " + favor.toString());

        if (mounted) setState(() {});
      }
    } catch (ex) {
      print("Error: " + ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentBody;

    switch (state) {
      case "today":
        currentBody = DayForecastTab(
          isFavor: favor,
          forecast: forecast,
        );
        break;

      case "week":
        currentBody = WeekForecastTab(
          forecast: forecast,
        );
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            forecast = null;
            getForecast(cityUrl: currentURL);
          },
          child: ListView(
            children: [
              Column(
                children: [
                  AppTopBar(
                    placeName: forecast == null ? "" : forecast.placeName,
                    isFavor: favor,
                    onFavorClicked: () async {
                      try {
                        double latitude = position.latitude;
                        double longitude = position.longitude;

                        if (basedOnLocation) {
                          await favs.add(new Pogoda.City(forecast.placeName,
                              "https://yandex.ru/pogoda/?lat=$latitude&lon=$longitude"));
                          // print("add based on location");
                        } else {
                          await favs.add(
                              new Pogoda.City(forecast.placeName, currentURL));

                          // print("add searched city");
                        }
                      } catch (ex) {
                        print(ex);
                      }

                      favor = !favor;

                      setState(() {});
                    },
                    onMenuClicked: () async {
                      final result = Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenFavorites()));

                      result.then((value) async {
                        try {
                          if (value != null) {
                            forecast = null;
                            if (value == "current_location") {
                              getForecast(cityUrl: null);
                            } else {
                              getForecast(cityUrl: value);
                            }
                          } else {
                            getForecast(cityUrl: currentURL);
                          }
                        } catch (ex) {
                          print(ex);
                        }

                        setState(() {});
                      });
                    },
                  ),
                  AppTabsMenu(
                    state: state,
                    onTodayClick: () {
                      if (state != "today")
                        setState(() {
                          state = "today";
                        });
                    },
                    onWeekClick: () {
                      if (state != "week")
                        setState(() {
                          state = "week";
                        });
                    },
                  ),
                  currentBody
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
