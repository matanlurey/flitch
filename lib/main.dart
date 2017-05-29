// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:twitch/twitch.dart';

import 'src/application.dart';
import 'src/services.dart';

// Please register a different client ID before publishing:
// https://www.twitch.tv/settings/connections
//
// This is an real ID that is used to test the package.
const _twitchClientId = '6gtkhkgt33mb3hujfq5f4vc0mrn4kc';

void main() {
  setUpServices(
    twitch: new Twitch(new TwitchHttp(clientId: _twitchClientId)),
  );
  runApp(new FlitchApp());
}
