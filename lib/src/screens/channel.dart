// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flitch/src/services.dart';
import 'package:flitch/src/widgets/videos.dart';
import 'package:flutter/material.dart';
import 'package:twitch/twitch.dart';

class ChannelScreen extends StatelessWidget {
  final Channel channel;

  const ChannelScreen(this.channel);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Videos from ${channel.name}")),
        body: new VideosList(Services.twitch.getChannelVideos(channel.id)));
  }
}
