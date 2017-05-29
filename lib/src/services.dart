// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:twitch/twitch.dart';

Twitch _twitch;

/// Sets up services for the entire application.
void setUpServices({
  Twitch twitch,
}) {
  _twitch = twitch;
}

/// Returns the Twitch service.
Twitch get twitch => _twitch;
