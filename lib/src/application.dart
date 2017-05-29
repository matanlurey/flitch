// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'views/home.dart';

class FlitchApp extends MaterialApp {
  FlitchApp()
      : super(
          debugShowCheckedModeBanner: false,
          title: 'Flitch',
          home: const HomeView(),
          theme: _twitchTheme,
        );
}

// Unofficial theme colors for Twitch.
//
// Based on the following material palette:
// * materialpalette.com/deep-purple/grey
final _twitchTheme = new ThemeData(
  primaryColor: const Color.fromRGBO(0x67, 0x3A, 0xB7, 1.0),
  accentColor: const Color.fromRGBO(0x9E, 0x9E, 0x9E, 1.0),
);
