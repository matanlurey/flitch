// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:flitch/src/widgets/flitch_fade_in_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:twitch/twitch.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class VideosList extends StatelessWidget {
  final Future<Response<Video>> future;

  const VideosList(this.future);

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final orientation = queryData.orientation;
    final size = queryData.size;
    final crossAxisCount = (orientation == Orientation.portrait) ? 1 : 2;

    return new FutureBuilder<Response<Video>>(
      future: future,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? new GridView.count(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio:
                    size.width / crossAxisCount / VideoItem.containerHeight,
                padding: const EdgeInsets.all(4.0),
                children: snapshot.hasData
                    ? snapshot.data
                        .map((video) => new VideoItem(video, crossAxisCount))
                        .toList()
                    : [])
            : new Center(child: new CircularProgressIndicator());
      },
    );
  }
}

class VideoItem extends StatelessWidget {
  static double containerHeight = 200.0;

  final Video video;
  final int crossAxisCount;

  const VideoItem(this.video, this.crossAxisCount);

  @override
  Widget build(context) {
    return new GridTile(
      child: new InkWell(
        onTap: () async {
          new FlutterWebviewPlugin().launch(video.url);
        },
        child: new Container(
          height: containerHeight,
          child: new Stack(
            fit: StackFit.expand,
            children: [
              new FlitchFadeInImage(video.preview.large),
              new Positioned(
                bottom: 0.0,
                child: new Container(
                  margin: new EdgeInsets.only(right: 16.0),
                  constraints: new BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width /
                              this.crossAxisCount -
                          16.0),
                  padding: new EdgeInsets.all(12.0),
                  decoration: new BoxDecoration(
                    color: new Color.fromARGB(255, 33, 33, 33),
                  ),
                  child: new Text(
                    video.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: Colors.white70,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
