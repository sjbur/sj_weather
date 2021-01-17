import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Misty/YandexPogoda.dart' as Pogoda;

class DayForecastTab extends StatefulWidget {
  // final void Function(bool) setFavor;
  final bool isFavor;
  final Pogoda.Forecast forecast;

  const DayForecastTab({Key key, this.isFavor, this.forecast})
      : super(key: key);

  @override
  _DayForecastTabState createState() => _DayForecastTabState();
}

class _DayForecastTabState extends State<DayForecastTab> {
  // Pogoda.Forecast forecast;
  // Position position;
  // Favorites favs;

  // bool basedOnLocation = true;
  // String currentURL;

  @override
  void initState() {
    super.initState();
    // getForecast();
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

  // void getForecast({String cityUrl}) async {
  //   favs = new Favorites();
  //   await favs.init();
  //   widget.setFavor(false);

  //   if (cityUrl == null) {
  //     position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     forecast = await Pogoda.searchForecastByCoords(
  //         position.longitude, position.latitude);

  //     basedOnLocation = true;
  //   } else {
  //     forecast = await Pogoda.extract(cityUrl);
  //     currentURL = cityUrl;
  //     basedOnLocation = false;
  //   }

  //   try {
  //     favs.cities.forEach((element) {
  //       if (element.cityName == forecast.placeName) widget.setFavor(true);
  //     });
  //   } catch (ex) {
  //     print(ex);
  //   }

  //   if (mounted) setState(() {});

  //   // showForecast(forecast);
  // }

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
    if (widget.forecast == null)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: weatherStateImage(
                  widget.forecast.weatherState.toLowerCase())),
          Center(
            child: Column(
              children: [
                Text(widget.forecast.weatherState,
                    style:
                        TextStyle(color: Color.fromARGB(255, 137, 138, 144))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.forecast.currentTemp + "º",
                    textScaleFactor: 3.0,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, 16, 8),
                    child: Text(
                        "Ветер: " + widget.forecast.wind.toString() + " ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, 16, 8),
                    child: Text("Влажность: " + widget.forecast.humidity,
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, 16, 8),
                    child: Text(
                        "Ощущается как " + widget.forecast.feelsLikeTemp + "º",
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, 16, 8),
                    child: Text(widget.forecast.pressure,
                        style: TextStyle(
                            color: Color.fromARGB(255, 137, 138, 144))),
                  ),
                ],
              )
            ],
          ),
          Container(
              height: 170,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.forecast.forecastForNext24Hours.length,
                  itemBuilder: (context, index) {
                    Widget res;
                    try {
                      if (index == 0)
                        res = Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                          child: WeatherThumbnail(
                              time: widget
                                  .forecast.forecastForNext24Hours[index].time,
                              degree: widget.forecast
                                  .forecastForNext24Hours[index].degree,
                              iconPath: widget.forecast
                                  .forecastForNext24Hours[index].conditionIcon),
                        );
                      else
                        res = WeatherThumbnail(
                            time: widget
                                .forecast.forecastForNext24Hours[index].time,
                            degree: widget
                                .forecast.forecastForNext24Hours[index].degree,
                            iconPath: widget.forecast
                                .forecastForNext24Hours[index].conditionIcon);
                    } catch (ex) {
                      print(ex);
                    }

                    if (res != null)
                      return res;
                    else
                      return Text("");
                  }))
        ],
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
        height: 90,
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
