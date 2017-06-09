// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flitch/src/screens/search.dart';
import 'package:flitch/src/services.dart';
import 'package:flitch/src/widgets/videos.dart';
import 'package:flutter/material.dart';
import '../widgets/top_games.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Tab> _tabs = [
    new Tab(
      title: 'Top Games',
      body: new TopGameList(),
      key: new Key('TopGamesList'),
      icon: Icons.games,
    ),
    new Tab(
      title: 'Top Videos',
      body: new VideosList(Services.twitch.getTopVideos()),
      key: new Key('TopVideosList'),
      icon: Icons.videocam,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final transitionDuration = new Duration(milliseconds: 200);

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flitch'),
          actions: [
            new ClipOval(
              child: new InkWell(
                  child: new Container(
                      child: new Icon(Icons.search),
                      padding: new EdgeInsets.fromLTRB(16.0, 0.0, 12.0, 0.0)),
                  onTap: () async {
                    await Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new SearchScreen()));
                  }),
            ),
          ],
        ),
        body: new Stack(
            children: (_tabs
                // Get all inactive screens
                .where((screen) => _tabs.indexOf(screen) != _currentIndex)
                // Place them on the bottom of the Stack, and fade em out
                .map((screen) => new AnimatedOpacity(
                    opacity: 0.0,
                    duration: transitionDuration,
                    child: screen.body,
                    key: screen.key))
                .toList()
                  // Finally, place the active screen on top so it can receive touch events and fade it in
                  ..add(new AnimatedOpacity(
                      opacity: 1.0,
                      duration: transitionDuration,
                      child: _tabs[_currentIndex].body,
                      key: _tabs[_currentIndex].key)))),
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (currentIndex) {
              setState(() {
                _currentIndex = currentIndex;
              });
            },
            items: _tabs
                .map((item) => new BottomNavigationBarItem(
                    icon: new Icon(item.icon), title: new Text(item.title)))
                .toList()));
  }
}

class Tab {
  final Widget body;
  final IconData icon;
  final String title;
  final Key key;

  Tab({this.body, this.icon, this.title, this.key});
}
