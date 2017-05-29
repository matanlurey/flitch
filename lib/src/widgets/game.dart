// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../services.dart' as services;
import 'package:twitch/twitch.dart';

class GameList extends StatelessWidget {
  const GameList();

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new FutureBuilder<Response<TopGame>>(
      future: services.twitch.getTopGames(),
      builder: (context, snapshot) {
        return new GridView.count(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: const EdgeInsets.all(4.0),
          childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
          children: snapshot.data.map((g) => new _GameItem(g)).toList(),
        );
      },
    );
  }
}

class _GameItem extends StatelessWidget {
  final TopGame _game;

  const _GameItem(this._game);

  @override
  Widget build(_) {
    return new GridTile(
      child: new Hero(
        tag: _game.name,
        child: new Image.network(
          _game.box.large,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
