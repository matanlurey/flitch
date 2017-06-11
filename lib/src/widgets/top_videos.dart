// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:twitch/twitch.dart';
import 'package:url_launcher/url_launcher.dart';

class TopVideosList extends StatelessWidget {
  final Twitch twitch;

  const TopVideosList(this.twitch);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new FutureBuilder<Response<Video>>(
      future: twitch.getTopVideos(),
      builder: (context, snapshot) {
        return new GridView.count(
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(4.0),
            childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
            children: snapshot != null && snapshot.data != null
                ? snapshot.data.map((video) => new _VideoItem(video)).toList()
                : []);
      },
    );
  }
}

class _VideoItem extends StatelessWidget {
  final Video _video;

  const _VideoItem(this._video);

  @override
  Widget build(_) {
    return new GridTile(
      child: new Hero(
        tag: _video.id,
        child: new InkWell(
            onTap: () async {
              if (await canLaunch(_video.url)) {
                await launch(_video.url);
              }
            },
            child: new Image.network(
              _video.preview.large,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
