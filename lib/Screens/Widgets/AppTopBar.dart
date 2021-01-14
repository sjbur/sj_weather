import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ScreenFavorites.dart';

class AppTopBar extends StatefulWidget {
  final String placeName;
  final VoidCallback onFavorClicked;
  final VoidCallback onMenuClicked;
  final bool isFavor;

  const AppTopBar(
      {Key key,
      this.placeName,
      this.onFavorClicked,
      this.isFavor,
      this.onMenuClicked})
      : super(key: key);

  @override
  _AppTopBarState createState() => _AppTopBarState();
}

class _AppTopBarState extends State<AppTopBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(children: [
              IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.grid_on),
                  onPressed: widget.onMenuClicked),
              IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    widget.isFavor
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.star,
                    color: Colors.white,
                  ),
                  onPressed: widget.onFavorClicked),
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
                style: TextStyle(color: Color.fromARGB(255, 137, 138, 144)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: widget.placeName == null
                  ? Text(
                      "Paris, FR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      widget.placeName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            )
          ],
        )
      ],
    );
  }
}
