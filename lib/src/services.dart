// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:twitch/twitch.dart';

class Services {
  static final Services _singleton = new Services._internal();
  static final Twitch twitch = _singleton._twitch;
  Twitch _twitch;

  Services._internal();

  static void setup(Twitch twitch) {
    _singleton._twitch = twitch;
  }
}
