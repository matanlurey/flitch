// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:flitch/src/widgets/fading_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:twitch/twitch.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class VideosList extends StatelessWidget {
  final Future<Response<Video>> future;

  const VideosList(this.future);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new FutureBuilder<Response<Video>>(
      future: future,
      builder: (context, snapshot) {
        return snapshot == null || snapshot.data == null
            ? new Center(child: new CircularProgressIndicator())
            : new GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                childAspectRatio:
                    (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: snapshot != null && snapshot.data != null
                    ? snapshot.data
                        .map((video) => new _VideoItem(video))
                        .toList()
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
              new FlutterWebviewPlugin().launch(_video.url);
            },
            child: new FadingImage(
              image: new NetworkImage(_video.preview.large),
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
