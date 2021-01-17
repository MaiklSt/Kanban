import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanban_app/pages/widget.dart';
import 'package:kanban_app/services/validate.dart';

import 'list_page.dart';

class RegistrPage extends StatefulWidget {
  @override
  _RegistrPageState createState() => _RegistrPageState();
}

class _RegistrPageState extends State<RegistrPage> {
  final TextEditingController _logConttroller = TextEditingController();
  final TextEditingController _passConttroller = TextEditingController();

  bool conect = true;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //var myWidth = MediaQuery.of(context).size.width;
    var myHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kanban'),
      ),
      body: conect
          ? Center(
            child: Container(
              height: myHeight / 1.5,
              child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextInFild(
                            charLimit: 4,
                            myController: _logConttroller,
                            myHight: 5.0,
                            myHintText: 'Enter login',
                            myFillColor: Color(0xFF000000),
                            obscureText: false,
                          ),
                          TextInFild(
                            charLimit: 8,
                            myController: _passConttroller,
                            myHight: 5.0,
                            myHintText: 'Enter password',
                            myFillColor: Colors.cyan,
                            obscureText: true,
                          ),
                          SizedBox(height: 20.0),
                          MyRaisedButton(
                            myColor: Color(0xFF63FED3),
                            myFunction: () async {
                              setState(() {
                                conect = false;
                              });

                              var result = await (Validate(
                                      log: _logConttroller.text,
                                      pass: _passConttroller.text)
                                  .validate());
                              print(result[0]);
                              print(result[1]);

                              if (result != null) {
                                  setState(() {
                                    conect = true;
                                  });                            
                                if (result[0] == 400) {
                                  print(result[1]);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ErrorDialog(message: result));

                                } else if (result[0] == 200) {
                                  String token = result[1];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CardLists(token: token)));
                                }
                                if (result[0] == 'conect') {
                                  print(result[1]);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ErrorDialog(message: result));
                                }
                              }
                            },
                            myHight: 20,
                            myWidth: 100,
                            textString: 'Log in',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
