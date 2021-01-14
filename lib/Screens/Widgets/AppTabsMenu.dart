import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTabsMenu extends StatefulWidget {
  final VoidCallback onTodayClick;
  final VoidCallback onWeekClick;
  final String state;

  const AppTabsMenu({Key key, this.onTodayClick, this.onWeekClick, this.state})
      : super(key: key);

  @override
  _AppTabsMenuState createState() => _AppTabsMenuState();
}

class _AppTabsMenuState extends State<AppTabsMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlineButton(
              onPressed: widget.onTodayClick,
              child: Text("Сегодня"),
              borderSide: widget.state == "today"
                  ? BorderSide(color: Color.fromARGB(255, 64, 130, 187))
                  : null),
          // OutlineButton(
          //   onPressed: () {},
          //   child: Text("Завтра"),
          // ),
          OutlineButton(
              onPressed: widget.onWeekClick,
              child: Text("Неделя"),
              borderSide: widget.state == "week"
                  ? BorderSide(color: Color.fromARGB(255, 64, 130, 187))
                  : null)
        ],
      ),
    );
  }
}
