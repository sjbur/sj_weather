// import 'dart:html';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<Forecast> extract(String yandexUrl) async {
  // example: https://yandex.ru/pogoda/2

  print('url: ' + yandexUrl);

  Uri link = Uri.parse(yandexUrl);

  var request = await http.Client().get(link);
  var document = parse(request.body);

  Forecast fr = new Forecast();

  fr.placeName = document
      .getElementsByClassName("breadcrumbs__title")
      .last
      .text; //title title_level_1 header-title__title"
  fr.weatherState = document
      .getElementsByClassName("link__condition")
      .first
      .innerHtml
      .toString();
  fr.currentTemp =
      document.getElementsByClassName("temp__value")[1].innerHtml.toString();
  // print("кол-во temp_value: " +
  //     document.getElementsByClassName("temp__value").length.toString());
  fr.feelsLikeTemp =
      document.getElementsByClassName("temp__value")[2].innerHtml.toString();
  // print("кол-во wind-speed: " +
  //     document.getElementsByClassName("wind-speed").length.toString());
  fr.wind = document.getElementsByClassName("fact__wind-speed")[0].text;

  if (document.getElementsByClassName(" icon-abbr").length > 0) {
    fr.windDir =
        document.getElementsByClassName(" icon-abbr")[0].innerHtml.toString();
    document.getElementsByClassName(" icon-abbr")[0].remove();
    fr.windMeasure = document.getElementsByClassName("fact__unit")[0].text;
  } else {
    fr.windDir = "";
    fr.windMeasure = "";
  }

  fr.humidity = document
      .getElementsByClassName("term term_orient_v fact__humidity")[0]
      .getElementsByClassName("term__value")[0]
      .text;

  fr.pressure = document
      .getElementsByClassName("term term_orient_v fact__pressure")[0]
      .getElementsByClassName("term__value")[0]
      .text;

  document.getElementsByClassName("fact__hour swiper-slide").forEach((element) {
    try {
      String time = element.getElementsByClassName("fact__hour-label")[0].text;
      String degree = element.getElementsByClassName("fact__hour-temp")[0].text;
      String icon;
      document
          .getElementsByClassName("fact__hour swiper-slide")[0]
          .nodes[0]
          .children
          .forEach((child) {
        if (child.attributes.containsKey("src")) {
          child.classes.forEach((childClass) {
            if (childClass.contains("icon_thumb_")) {
              icon =
                  findConditionIcon(childClass.replaceAll("icon_thumb_", ""));
            }
          });
        }
      });

      fr.forecastForNext24Hours.add(ForecastForHour(time, degree, icon));
    } catch (ex) {
      print(ex);
    }
  });

  // элемент с прогнозами
  Element swiperWrapper = document.getElementsByClassName("swiper-wrapper")[1];

  // ищем точку входа
  bool found = false;

  int i = 0;
  int auf = 0;
  swiperWrapper.children.forEach((child) {
    if (auf == 4) found = true;

    if (found && i != 7) {
      String dayName =
          child.getElementsByClassName("forecast-briefly__name")[0].text;
      String temp = child
          .getElementsByClassName("forecast-briefly__temp_day")[0]
          .text
          .replaceAll(new RegExp(r"[a-zA-Zа-яА-ЯёЁ]"), '');
      String icon;
      child.nodes[0].children.forEach((element) {
        if (element.attributes.containsKey("src"))
          element.classes.forEach((clas) {
            if (clas.contains("icon_thumb_"))
              icon = clas.replaceAll("icon_thumb_", "");
          });
      });
      fr.forecastForWeek.add(
          DayForecast(fullDayName(dayName), temp, findConditionIcon(icon)));

      i++;
    }

    auf++;
  });

  return fr;
}

Future<List<City>> searchCityByName(String city) async {
  List<City> res = new List<City>();
  Uri link = Uri.parse("https://yandex.ru/pogoda/search?request=" + city);

  var request = await http.Client().get(link);
  var document = parse(request.body);

  document
      .getElementsByClassName("link place-list__item-name")
      .forEach((element) {
    res.add(new City(
        element.innerHtml, "https://yandex.ru" + element.attributes["href"]));
  });

  return res;
}

Future<Forecast> searchForecastByCoords(
    double longitude, double latitude) async {
  // https://yandex.ru/pogoda/?lat=59.93486023&lon=30.3153553
  // print("https://yandex.ru/pogoda/?lat=$latitude&lon=$longitude");
  return await extract(
      "https://yandex.ru/pogoda/?lat=$latitude&lon=$longitude");
}

class Forecast {
  String placeName;
  String weatherState;
  String currentTemp;
  String feelsLikeTemp;

  String humidity;
  String pressure;

  String wind;
  String windDir;
  String windMeasure;

  List<ForecastForHour> forecastForNext24Hours = new List<ForecastForHour>();
  List<DayForecast> forecastForWeek = List<DayForecast>();
}

class ForecastForHour {
  String time;
  String conditionIcon;
  String degree;

  ForecastForHour(this.time, this.degree, this.conditionIcon);
}

class DayForecast {
  final String dayName;
  final String icon;
  final String temp;

  DayForecast(this.dayName, this.temp, this.icon);

  // ForecastForHour morningTemp =
  //     ForecastForHour("Утро", "1", "assets/icons/day/01d.png");
  // ForecastForHour dayTemp =
  //     ForecastForHour("День", "1", "assets/icons/day/01d.png");
  // ForecastForHour eveningTemp =
  //     ForecastForHour("Вечер", "1", "assets/icons/day/01d.png");
  // ForecastForHour nightTemp =
  //     ForecastForHour("Ночь", "1", "assets/icons/day/01d.png");
}

String findConditionIcon(String str) {
  String res;

  switch (str) {
    case "ovc":
      res = "assets/icons/day/04d.png";
      break;
    case "ovc-ra":
      res = "assets/icons/day/09d.png";
      break;
    case "ovc-sn":
      res = "assets/icons/day/13d.png";
      break;
    case "ovc-ra":
      res = "assets/icons/day/09d.png";
      break;
    case "ovc-sn":
      res = "assets/icons/day/13d.png";
      break;
    case "ovc-m-sn":
      res = "assets/icons/day/13d.png";
      break;
    case "ovc-ra-sn":
      res = "assets/icons/day/13d.png";
      break;
    case "ovc-ts-ra":
      res = "assets/icons/day/11d.png";
      break;

    case "bkn-ra-d":
      res = "assets/icons/day/09d.png";
      break;
    case "bkn-sn-d":
      res = "assets/icons/day/13d.png";
      break;
    case "bkn-d":
      res = "assets/icons/day/03d.png";
      break;
    case "bkn-ra-d":
      res = "assets/icons/day/09d.png";
      break;
    case "bkn-sn-d":
      res = "assets/icons/day/13d.png";
      break;

    case "bkn-ra-n":
      res = "assets/icons/day/09d.png";
      break;
    case "bkn-sn-n":
      res = "assets/icons/day/13d.png";
      break;
    case "bkn-d":
      res = "assets/icons/day/03d.png";
      break;
    case "bkn-n":
      res = "assets/icons/day/03d.png";
      break;
    case "bkn-ra-n":
      res = "assets/icons/day/09d.png";
      break;
    case "bkn-sn-n":
      res = "assets/icons/day/13d.png";
      break;
    case "bkn-m-sn-d":
      res = "assets/icons/day/13d.png";
      break;
    case "bkn-m-sn-n":
      res = "assets/icons/day/13d.png";
      break;

    case "fg-d":
      res = "assets/icons/day/50d.png";
      break;
    case "fg-n":
      res = "assets/icons/day/50d.png";
      break;

    case "skc-d":
      res = "assets/icons/day/01d.png";
      break;

    case "skc-n":
      res = "assets/icons/night/01n.png";
      break;

    case "bl":
      res = "assets/icons/day/13d.png";
      break;

    case "sunrise":
      res = "assets/icons/day/01d.png";
      break;

    case "sunset":
      res = "assets/icons/day/02d.png";
      break;

    //

    // case "skc-d":
    //   res = "assets/icons/day/01d.png";
    //   break;

    // case "skc-n":
    //   res = "assets/icons/day/01d.png";
    //   break;

    default:
      print("err: " + str);
      res = "assets/icons/day/03d.png";
      break;
  }

  // print(str);
  // print(res);
  // print("");

  return res;
}

class City {
  String cityName;
  String cityUrl;

  City(this.cityName, this.cityUrl);

  toJson() => {"cityName": cityName, "cityUrl": cityUrl};
}

String fullDayName(String day) {
  switch (day) {
    case "Пн":
      return "Понедельник";
      break;

    case "Вт":
      return "Вторник";
      break;

    case "Ср":
      return "Среда";
      break;

    case "Чт":
      return "Четверг";
      break;

    case "Пт":
      return "Пятница";
      break;

    case "Сб":
      return "Суббота";
      break;

    case "Вс":
      return "Воскресенье";
      break;

    default:
      return day;
      break;
  }
}
