import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kanban_app/pages/widget.dart';
import 'package:http/http.dart' as http;

class CardLists extends StatefulWidget {
  final String token;

  const CardLists({Key key, this.token}) : super(key: key);

  @override
  _CardListsState createState() => _CardListsState(token);
}

class _CardListsState extends State<CardLists> {
  final token;

  _CardListsState(this.token);

  bool loadComplite = false;
  bool errors = false;
  var errorsData;
  var datas = [];

  List onHold = [];
  List inProgress = [];
  List needsReview = [];
  List appRoved = [];

  @override
  void initState() {
    data(token);
    super.initState();
  }

  Future<List> addData() async {
    if (datas != null) {
      List nosHold = [];
      for (int x = 0; x < datas.length; x++) {
        if (datas[x]['row'] == '0')
          onHold.add(datas[x]);
        else if (datas[x]['row'] == '1')
          inProgress.add(datas[x]);
        else if (datas[x]['row'] == '2')
          needsReview.add(datas[x]);
        else if (datas[x]['row'] == '3') appRoved.add(datas[x]);
      }

      loadComplite = true;

      setState(() {});
      return nosHold;
    }
    return null;
  }

  Future<List<dynamic>> data(userToken) async {
    final headers = {'Authorization': 'JWT $userToken'};
    var dat = await loadData(headers);
    if (dat != null) {
      datas = dat;
      addData();
      return dat;
    }
    return null;
  }

  final apiUrl = 'https://trello.backend.tests.nekidaem.ru/api/v1/cards/';
  var jsMap;

  Future<dynamic> loadData(headers) async {
    return await http.get(apiUrl, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = utf8.decode(data.bodyBytes);
        jsMap = jsonDecode(jsonData);

        for (var x = 0; x < jsMap.length; x++) {
          print(
              '${jsMap[x]['id']} ${jsMap[x]['row']} ${jsMap[x]['seq_num']} ${jsMap[x]['text']}');
        }

        return jsMap;
      } else {}
    });
  }

  final apiUrlLogIn =
      'https://trello.backend.tests.nekidaem.ru/api/v1/users/login/';

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Center(
        child: ListView.builder(
          itemCount: onHold.length,
          itemBuilder: (BuildContext context, int index) {
            return MyCard(tabID: onHold, index: index, id: 'id');
          },
        ),
      ),
      Center(
        child: ListView.builder(
          itemCount: inProgress.length,
          itemBuilder: (BuildContext context, int index) {
            return MyCard(tabID: inProgress, index: index, id: 'id');
          },
        ),
      ),
      Center(
        child: ListView.builder(
          itemCount: needsReview.length,
          itemBuilder: (BuildContext context, int index) {
            return MyCard(tabID: needsReview, index: index, id: 'id');
          },
        ),
      ),
      Center(
        child: ListView.builder(
          itemCount: appRoved.length,
          itemBuilder: (BuildContext context, int index) {
            return MyCard(tabID: appRoved, index: index, id: 'id');
          },
        ),
      ),
    ];
    final _kTabs = <Tab>[
      Tab(text: 'On hold'),
      Tab(text: 'In progress'),
      Tab(text: 'Needs review'),
      Tab(text: 'Approved'),
    ];

    return errors
        ? Scaffold(
            appBar: AppBar(title: Text('error')),
            body: Text('errorsData', style: TextStyle(color: Colors.white)))
        : DefaultTabController(
            length: _kTabs.length,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      // width: 50,
                      height: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white54,
                        textColor: Colors.white,
                        shape: CircleBorder(side: BorderSide.none),
                        //child: Text('<', style: TextStyle(fontSize: 30)),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ], //
                title: Text('Kanban Title'),
                backgroundColor: Color(0xFF000000),
                bottom: TabBar(
                  indicatorColor: Colors.white54,
                  labelColor: Colors.white,
                  tabs: _kTabs,
                ),
              ),
              body: !loadComplite
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      color: Colors.black,
                      child: TabBarView(
                        children: _kTabPages,
                      ),
                    ),
            ),
          );
  }
}
