// Copyright 2017, Google Inc.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flitch/src/widgets/search_channels.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  State<StatefulWidget> createState() {
    return new SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Container(
            padding: new EdgeInsets.only(right: 12.0),
            child: new TextField(
                onSubmitted: (query) {
                  setState(() {
                    _query = query;
                  });
                },
                autofocus: true,
                decoration: new InputDecoration(
                    hideDivider: true,
                    hintText: "Search channels",
                    hintStyle: new TextStyle(
                        color: new Color.fromARGB(120, 255, 255, 255),
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal)),
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal)),
          ),
        ),
        body: _query.isEmpty
            ? new Container()
            : new SearchChannelsList(
                _query,
                key: new Key(_query),
              ));
  }
}
