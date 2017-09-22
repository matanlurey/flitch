// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flitch/src/screens/channel.dart';
import 'package:flitch/src/services.dart';
import 'package:flitch/src/widgets/flitch_fade_in_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twitch/twitch.dart';

class SearchChannelsList extends StatelessWidget {
  final String query;

  const SearchChannelsList(this.query, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Response<Channel>>(
      future: Services.twitch.searchChannels(query),
      builder: (context, snapshot) {
        return snapshot == null || snapshot.data == null
            ? new Center(child: new CircularProgressIndicator())
            : new ListView(
                children: snapshot != null && snapshot.data != null
                    ? ListTile
                        .divideTiles(
                            color: Colors.grey[200],
                            tiles: snapshot.data.map((channel) => new ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new ChannelScreen(channel)));
                                },
                                leading: channel.logo == null
                                    ? new Container()
                                    : new ClipOval(
                                        child: new FlitchFadeInImage(channel.logo),
                                      ),
                                title: new Text(channel.name),
                                subtitle: new Text(channel.url))))
                        .toList()
                    : [],
              );
      },
    );
  }
}
