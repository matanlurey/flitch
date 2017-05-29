// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../widgets/game.dart';

class HomeView extends StatelessWidget {
  const HomeView();

  @override
  Widget build(_) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flitch'),
      ),
      body: new GameList(),
    );
  }
}
