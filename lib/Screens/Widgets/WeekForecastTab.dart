import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sj_weather/YandexPogoda.dart' as Pogoda;

class WeekForecastTab extends StatefulWidget {
  final Pogoda.Forecast forecast;

  const WeekForecastTab({Key key, this.forecast}) : super(key: key);

  @override
  _WeekForecastTabState createState() => _WeekForecastTabState();
}

class _WeekForecastTabState extends State<WeekForecastTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 20, 8, 0),
      child: Container(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  DayForecastThumbnal(
                      widget.forecast.forecastForWeek[0].dayName,
                      widget.forecast.forecastForWeek[0].temp,
                      widget.forecast.forecastForWeek[0].icon),
                  DayForecastThumbnal(
                      widget.forecast.forecastForWeek[1].dayName,
                      widget.forecast.forecastForWeek[1].temp,
                      widget.forecast.forecastForWeek[1].icon),
                  DayForecastThumbnal(
                      widget.forecast.forecastForWeek[2].dayName,
                      widget.forecast.forecastForWeek[2].temp,
                      widget.forecast.forecastForWeek[2].icon),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  DayForecastThumbnal(
                      widget.forecast.forecastForWeek[3].dayName,
                      widget.forecast.forecastForWeek[3].temp,
                      widget.forecast.forecastForWeek[3].icon),
                  DayForecastThumbnal(
                      widget.forecast.forecastForWeek[4].dayName,
                      widget.forecast.forecastForWeek[4].temp,
                      widget.forecast.forecastForWeek[4].icon),
                  DayForecastThumbnal(
                      widget.forecast.forecastForWeek[5].dayName,
                      widget.forecast.forecastForWeek[5].temp,
                      widget.forecast.forecastForWeek[5].icon),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  DayForecastThumbnal(
                      widget.forecast.forecastForWeek[6].dayName,
                      widget.forecast.forecastForWeek[6].temp,
                      widget.forecast.forecastForWeek[6].icon),
                ])
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class DayForecastThumbnal extends StatelessWidget {
  final String temp;
  final String dayTime;
  final String weatherPath;
  const DayForecastThumbnal(this.dayTime, this.temp, this.weatherPath);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
          temp.toString(), //"º"
          style: TextStyle(color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            dayTime,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
