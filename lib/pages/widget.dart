import 'package:flutter/material.dart';

class TextInFild extends StatefulWidget {
  TextInFild({
    Key key,
    @required this.myController,
    @required this.myHight,
    @required this.myHintText,
    @required this.myFillColor,
    @required this.charLimit,
    @required this.obscureText,
  }) : super(key: key);

  final TextEditingController myController;
  final double myHight;
  final String myHintText;
  final Color myFillColor;
  final charLimit;
  final obscureText;

  @override
  _TextInFildState createState() => _TextInFildState(
      charLimit: charLimit, myController: myController, myHintText: myHintText, obscureText: obscureText);
}

class _TextInFildState extends State<TextInFild> {
  final TextEditingController myController;
  final String myHintText;
  final _formKey = GlobalKey<FormState>();

  bool colorError = false;
  final charLimit;
  final obscureText;

  _TextInFildState({this.charLimit, this.myController, this.myHintText, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                new TextFormField(
                    obscureText: obscureText,
                    controller: myController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF2F2926)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                            width: 1,
                            color: colorError ? Colors.red : Color(0xFF63FED3)),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                          color: Colors.white24, //0xFF63FED3
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal),
                      hintText: myHintText,
                    ),
                    onChanged: (value) {
                      if (value.length < charLimit) {
                        setState(() {
                          colorError = true;
                        });
                      } else {
                        setState(() {
                          colorError = false;
                        });
                      }
                    },
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorError ? Colors.red : Colors.white),
                    cursorColor: Colors.white,
                    maxLength: charLimit + 10,
                    validator: (value) {
                      if (value.isEmpty) return '';
                      else return '';
                    }),
                colorError
                    ? Text('Minimum is $charLimit characters',
                        style: TextStyle(color: Colors.red))
                    : SizedBox(),
              ],
            )));
  }
}

class MyRaisedButton extends StatelessWidget {
  MyRaisedButton({
    Key key,
    @required this.myWidth,
    @required this.myHight,
    @required this.myFunction,
    @required this.myColor,
    @required this.textString,
  }) : super(key: key);

  final double myWidth;
  final double myHight;
  final Function myFunction;
  final Color myColor;
  final String textString;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(10.0),
      child: RaisedButton(
        onPressed: myFunction,
        color: myColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            side: BorderSide(color: Color(0xFF63FED3))),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            textString,
            style: TextStyle(
              fontSize: myHight,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final message;
  const ErrorDialog({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.red[900],
      title: Column(
        children: [
          Text('Ошибка Авторизации.'),
          Text('Код: ${message[0]}'),
        ],
      ),
      content: Text('${message[1]}'),
      actions: [
        FlatButton(
          color: Colors.black12,
          child: Text('Ok', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final tabID;
  final index;
  final id;

  const MyCard(
      {Key key, @required this.tabID, @required this.index, @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Tap OK!');
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.black87,
          width: double.infinity,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${tabID[index]['id']}',
                    style: TextStyle(color: Colors.white70)),
                SizedBox(height: 5.0),
                Text('${tabID[index]['text']}',
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
