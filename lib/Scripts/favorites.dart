import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sj_weather/YandexPogoda.dart' as Pogoda;

class Favorites {
  List<Pogoda.City> cities;

  Future<void> init() async {
    cities = await get();
  }

  Future<void> add(Pogoda.City city) async {
    try {
      cities = await get();

      if (cities != null) {
        if (!listContains(city)) {
          cities.add(city);
          print("city added");

          print(" => ");
          print(city.cityName + " " + city.cityUrl);

          cities.forEach((city) {
            print(city.cityName + " " + city.cityUrl);
          });
        } else {
          print("deleting city from favs");
          await remove(city);
        }
      } else {
        print("cities is null");
        cities = new List<Pogoda.City>();
        cities.add(city);
      }

      File file = await _localFile;

      await file.writeAsString(jsonEncode(cities));
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> remove(Pogoda.City city) async {
    try {
      cities = await get();
      removeFromList(city);

      File file = await _localFile;

      await file.writeAsString(jsonEncode(cities));
    } catch (ex) {
      print(ex);
    }
  }

  Future<List<Pogoda.City>> get() async {
    File file = await _localFile;
    List<Pogoda.City> res;

    // print("exists: " + (await file.exists()).toString());
    // print("content: " + (await file.readAsString()));

    try {
      List content = jsonDecode(await file.readAsString()); // list of map

      content.forEach((map) {
        if (res == null) res = new List<Pogoda.City>();

        res.add(new Pogoda.City(map["cityName"], map["cityUrl"]));
      });
    } catch (ex) {
      res = null;
      print(ex);
    }
    return res;
  }

  bool listContains(Pogoda.City city) {
    bool res = false;

    cities.forEach((element) {
      if (element.cityName == city.cityName && element.cityUrl == city.cityUrl)
        res = true;
    });

    return res;
  }

  bool removeFromList(Pogoda.City city) {
    bool res = false;
    var toDel;

    cities.forEach((element) {
      if (element.cityName == city.cityName && element.cityUrl == city.cityUrl)
        toDel = element;
    });

    if (toDel != null) cities.remove(toDel);

    return res;
  }

  Future<void> clearFavorites() async {
    File favFile = await _localFile;

    await favFile.delete();
  }

  Future<String> get _localPath async {
    return await getApplicationDocumentsDirectory().then((value) => value.path);
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/favorites.json');
  }
}
