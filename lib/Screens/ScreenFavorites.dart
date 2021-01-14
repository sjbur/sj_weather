import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sj_weather/YandexPogoda.dart' as Pogoda;
import 'package:sj_weather/Scripts/favorites.dart';

class ScreenFavorites extends StatefulWidget {
  @override
  _ScreenFavoritesState createState() => _ScreenFavoritesState();
}

class _ScreenFavoritesState extends State<ScreenFavorites> {
  TextEditingController textController = TextEditingController();
  List<Pogoda.City> cities;
  Favorites favs = new Favorites();
  bool gotFav = false;

  @override
  void initState() {
    super.initState();
    loadFavs();
    textController.addListener(search);
  }

  void loadFavs() async {
    await favs.init();

    if (favs.cities != null) {
      gotFav = favs.cities.isNotEmpty;

      try {
        favs.cities.forEach((city) {
          print(city.cityName);
        });
        // print(favs.cities.);
      } catch (ex) {
        print(ex);
      }

      setState(() {});
    }
  }

  void search() async {
    if (textController.text != "") {
      cities = await Pogoda.searchCityByName(textController.text);
    } else {
      cities = null;
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 51, 56),
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {},
              child: IconButton(
                icon: Icon(CupertinoIcons.location_fill),
                onPressed: () {
                  Navigator.of(context).pop("current_location");
                },
                // color: Colors.white,
              ))
        ],
        title: Text(
          "Избранное",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 50, 51, 56),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.search),
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    fillColor: Color.fromARGB(255, 40, 40, 40),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Город или район',
                  ),
                  style: TextStyle(),
                  // textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: textController.text.isEmpty
                  ? Column(
                      children: gotFav == false
                          ? <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Избранное",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.5,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 7, 14, 7),
                                child: Text(
                                    "Чтобы добавить новое место, найдите его в поиске, откройте прогноз и нажмите на звёздочку!"),
                              )
                            ]
                          : [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: favs.cities.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (dir) async {
                                          await favs.remove(favs.cities[index]);
                                          setState(() {});
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: Align(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  " Удалить",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                              ],
                                            ),
                                            alignment: Alignment.centerRight,
                                          ),
                                        ),
                                        key: Key(favs.cities[index].cityUrl),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context,
                                                favs.cities[index].cityUrl);
                                          },
                                          child: ListTile(
                                              title: Text(
                                                  favs.cities[index].cityName)),
                                        ),
                                      );
                                    }),
                              )
                            ],
                    )
                  : ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context, cities[index].cityUrl);
                          },
                          child: ListTile(
                            title: Text(cities[index].cityName),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
