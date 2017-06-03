// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flitch/src/widgets/top_videos.dart';
import 'package:flutter/material.dart';
import '../services.dart' as services;
import '../widgets/game.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget();

  @override
  State<StatefulWidget> createState() {
    return new HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = 0;
  final List<Screen> _screens = [
    new Screen(
      title: 'Top Games',
      body: new TopGameList(),
      key: new Key('TopGamesList'),
      icon: Icons.games,
    ),
    new Screen(
      title: 'Top Videos',
      body: new TopVideosList(services.twitch),
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
        ),
        body: new Stack(
            children: (_screens
                // Get all inactive screens
                .where((screen) => _screens.indexOf(screen) != _currentIndex)
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
                      child: _screens[_currentIndex].body,
                      key: _screens[_currentIndex].key)))),
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (currentIndex) {
              setState(() {
                _currentIndex = currentIndex;
              });
            },
            items: _screens
                .map((item) => new BottomNavigationBarItem(
                    icon: new Icon(item.icon), title: new Text(item.title)))
                .toList()));
  }
}

class Screen {
  final Widget body;
  final IconData icon;
  final String title;
  final Key key;

  Screen({this.body, this.icon, this.title, this.key});
}
