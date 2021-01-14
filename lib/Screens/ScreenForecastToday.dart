import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:geolocator/geolocator.dart';

import 'package:sj_weather/YandexPogoda.dart' as Pogoda;
import 'package:sj_weather/Screens/ScreenFavorites.dart';
import 'package:sj_weather/Scripts/favorites.dart';

class ScreenForecastToday extends StatefulWidget {
  @override
  _ScreenForecastTodayState createState() => _ScreenForecastTodayState();
}

var state = "day";

class _ScreenForecastTodayState extends State<ScreenForecastToday> {
  Pogoda.Forecast forecast;
  bool favor = false;
  Position position;
  Favorites favs;

  bool basedOnLocation = true;
  String currentURL;

  @override
  void initState() {
    super.initState();
    getForecast();
  }

  void getForecast({String cityUrl}) async {
    favs = new Favorites();
    await favs.init();

    if (cityUrl == null) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      forecast = await Pogoda.searchForecastByCoords(
          position.longitude, position.latitude);

      //showForecast(forecast);
      basedOnLocation = true;
    } else {
      forecast = await Pogoda.extract(cityUrl);
      currentURL = cityUrl;
      basedOnLocation = false;
    }

    favor = false;
    try {
      favs.cities.forEach((element) {
        if (element.cityName == forecast.placeName) favor = true;
      });
    } catch (ex) {
      print(ex);
    }

    setState(() {});
  }

  void showForecast(Pogoda.Forecast forecast) {
    print("Место: " + forecast.placeName);
    print("Погода: " + forecast.weatherState);
    print("Текущая температура: " + forecast.currentTemp);
    print("ощущается как: " + forecast.feelsLikeTemp);
    print("Ветер: " + forecast.wind + forecast.windMeasure + forecast.windDir);
    print("Влажность: " + forecast.humidity);
    print("Давление: " + forecast.pressure);
  }

  Image weatherStateImage(String state) {
    Image res;

    switch (state) {
      case "ясно":
        res = Image.asset(
          "assets/icons/day/01d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "малооблачно":
        res = Image.asset(
          "assets/icons/day/02d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "облачно с прояснениями":
        res = Image.asset(
          "assets/icons/day/03d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "пасмурно":
        res = Image.asset(
          "assets/icons/day/04d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );

        break;
      case "морось":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "небольшой дождь":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "дождь":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "умеренно сильный дождь":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "сильный дождь":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "длительный сильный дождь":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "ливень":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "дождь со снегом":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "небольшой снег":
        res = Image.asset(
          "assets/icons/day/13d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "снег":
        res = Image.asset(
          "assets/icons/day/13d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "снегопад":
        res = Image.asset(
          "assets/icons/day/13d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "град":
        res = Image.asset(
          "assets/icons/day/09d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "гроза":
        res = Image.asset(
          "assets/icons/day/11d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "дождь с грозой":
        res = Image.asset(
          "assets/icons/day/11d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
      case "гроза с градом":
        res = Image.asset(
          "assets/icons/day/11d.png",
          width: 228,
          height: 150,
          isAntiAlias: true,
        );
        break;
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 51, 56),
      body: state == "day"
          ? Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 20, 4, 4),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(children: [
                          IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.grid_on),
                              onPressed: () async {
                                final result = Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScreenFavorites()));

                                result.then((value) async {
                                  try {
                                    if (value != null) {
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
                              }),
                          IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                favor
                                    ? CupertinoIcons.star_fill
                                    : CupertinoIcons.star,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                try {
                                  double latitude = position.latitude;
                                  double longitude = position.longitude;

                                  if (basedOnLocation) {
                                    await favs.add(new Pogoda.City(
                                        forecast.placeName,
                                        "https://yandex.ru/pogoda/?lat=$latitude&lon=$longitude"));
                                    // print("add based on location");
                                  } else {
                                    await favs.add(new Pogoda.City(
                                        forecast.placeName, currentURL));

                                    // print("add searched city");
                                  }
                                } catch (ex) {
                                  print(ex);
                                }

                                // await favs.clearFavorites();

                                favor = !favor;

                                setState(() {});
                              }),
                        ])
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            DateFormat("dd.MM").format(DateTime.now()),
                            style: TextStyle(
                                color: Color.fromARGB(255, 137, 138, 144)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: forecast == null
                              ? Text(
                                  "Paris, FR",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  forecast.placeName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlineButton(
                        onPressed: () {
                          setState(() {
                            state = "day";
                          });
                        },
                        child: Text("Сегодня"),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 64, 130, 187))),
                    // OutlineButton(
                    //   onPressed: () {},
                    //   child: Text("Завтра"),
                    // ),
                    OutlineButton(
                        onPressed: () {
                          setState(() {
                            state = "week";
                          });
                        },
                        child: Text("Неделя"))
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: forecast == null
                      ? Text("")
                      : weatherStateImage(forecast.weatherState.toLowerCase())),
              Center(
                child: Column(
                  children: [
                    Text(
                        forecast == null
                            ? ""
                            : forecast.weatherState.toUpperCase(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        forecast != null
                            ? forecast.currentTemp.toString() + "º"
                            : "",
                        textScaleFactor: 3.0,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 8, 8),
                    child: Text(
                        forecast != null
                            ? "Ветер: " +
                                forecast.wind.toString() +
                                " " +
                                forecast.windMeasure +
                                forecast.windDir
                            : "",
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Text(
                        forecast != null
                            ? "Ощущается как " + forecast.feelsLikeTemp + "º"
                            : "",
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 8, 8),
                    child: Text(
                        forecast != null
                            ? "Влажность: " + forecast.humidity
                            : "",
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Text(forecast != null ? forecast.pressure : "",
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                  ),
                ],
              ),
              Expanded(
                  child: forecast != null
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: forecast.forecastForNext24Hours.length,
                          itemBuilder: (context, index) {
                            Widget res;
                            try {
                              if (index == 0)
                                res = Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 0, 0, 0),
                                  child: WeatherThumbnail(
                                      time: forecast
                                          .forecastForNext24Hours[index].time,
                                      degree: forecast
                                          .forecastForNext24Hours[index].degree,
                                      iconPath: forecast
                                          .forecastForNext24Hours[index]
                                          .conditionIcon),
                                );
                              else
                                res = WeatherThumbnail(
                                    time: forecast
                                        .forecastForNext24Hours[index].time,
                                    degree: forecast
                                        .forecastForNext24Hours[index].degree,
                                    iconPath: forecast
                                        .forecastForNext24Hours[index]
                                        .conditionIcon);
                            } catch (ex) {
                              print(ex);
                            }

                            if (res != null)
                              return res;
                            else
                              return Text("");
                          })
                      : Text("")
                  // ListView(
                  //   scrollDirection: Axis.horizontal,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                  //       child: WeatherThumbnail(),
                  //     ),
                  //     WeatherThumbnail(),
                  //     WeatherThumbnail(),
                  //     WeatherThumbnail(),
                  //     WeatherThumbnail(),
                  //     WeatherThumbnail(),
                  //     WeatherThumbnail(),
                  //     WeatherThumbnail(),
                  //     WeatherThumbnail()
                  //   ],
                  // ),
                  )
            ])
          : ForecastForWeek(),
    );
  }
}

class ForecastForWeek extends StatefulWidget {
  const ForecastForWeek({
    Key key,
  }) : super(key: key);

  @override
  _ForecastForWeekState createState() => _ForecastForWeekState();
}

class _ForecastForWeekState extends State<ForecastForWeek> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              dayForecast("AUE DAY", "-40", ""),
              dayForecast("AUE DAY", "-40", "")
            ],
          ),
          Column(
            children: [dayForecast("AUE DAY", "-40", "")],
          )
        ],
      ),
    );
  }
}

class WeatherThumbnail extends StatelessWidget {
  final time;
  final degree;
  final iconPath;

  const WeatherThumbnail({
    Key key,
    @required this.time,
    @required this.degree,
    @required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 10, 7, 20),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(50, 255, 255, 255),
            borderRadius: BorderRadius.circular(20)),
        width: 88,
        height: 96,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Image.asset(
                iconPath,
                isAntiAlias: true,
                width: 50,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 8, 3),
                child: Text(
                  time,
                  style: TextStyle(color: Color.fromARGB(255, 137, 138, 144)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: time.toString().split(":")[1] != "00"
                    ? const EdgeInsets.fromLTRB(14, 12, 0, 0)
                    : const EdgeInsets.fromLTRB(14, 0, 0, 0),
                child: Text(
                  degree,
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: (degree.toString().contains("1") ||
                          degree.toString().contains("2") ||
                          degree.toString().contains("3") ||
                          degree.toString().contains("4") ||
                          degree.toString().contains("5") ||
                          degree.toString().contains("6") ||
                          degree.toString().contains("7") ||
                          degree.toString().contains("8") ||
                          degree.toString().contains("9") ||
                          degree.toString().contains("0"))
                      ? 2
                      : 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget dayForecast(String day, String maxTemp, String minTemp) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(14, 30, 8, 0),
    child: Container(
      child: Column(children: [
        Text(
          day,
          style: TextStyle(fontWeight: FontWeight.bold),
          textScaleFactor: 1.2,
        ),
        // Row(
        //   children: [

        //     // Spacer(),
        //     // Text(
        //     //   "макс. ",
        //     //   style: TextStyle(color: Colors.grey),
        //     // ),
        //     // Text(
        //     //   maxTemp + "º",
        //     //   style: TextStyle(fontWeight: FontWeight.bold),
        //     //   textScaleFactor: 1.2,
        //     // ),
        //     // Padding(
        //     //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        //     //   child: Text(
        //     //     "мин. ",
        //     //     style: TextStyle(color: Colors.grey),
        //     //   ),
        //     // ),
        //     // Padding(
        //     //   padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        //     //   child: Text(
        //     //     minTemp + "º",
        //     //     style: TextStyle(fontWeight: FontWeight.bold),
        //     //     textScaleFactor: 1.2,
        //     //   ),
        //     //),
        //   ],
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            DayForecastThumbnal("20º", "assets/icons/day/02d.png"),
            // DayForecastThumbnal("День", "assets/icons/day/03d.png"),
            // DayForecastThumbnal("Вечер", "assets/icons/day/04d.png"),
            // DayForecastThumbnal("Ночь", "assets/icons/day/09d.png"),
          ]),
        )
      ]),
    ),
  );
}

class DayForecastThumbnal extends StatelessWidget {
  final String dayTime;
  final String weatherPath;
  const DayForecastThumbnal(this.dayTime, this.weatherPath);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(50, 255, 255, 255),
                borderRadius: BorderRadius.circular(20)),
            width: 80,
            height: 80,
            child: Center(
              child: FractionallySizedBox(
                  widthFactor: 0.6,
                  heightFactor: 0.6,
                  child: Image.asset(weatherPath)),
            ),
          ),
        ),
        Text(
          dayTime,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
