
import 'package:document_measure/document_measure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'dart:async';
import 'point.dart';


class MyHomePagetest2 extends StatefulWidget {
  final String usernameController;//if you have multiple values add here
  MyHomePagetest2(this.usernameController, {Key key}): super(key: key);

  @override
  _MyHomePagetest2State createState() => _MyHomePagetest2State();
}


class _MyHomePagetest2State extends State<MyHomePagetest2> {


  Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _showDialog();
    Timer(Duration(seconds: 5), () async{
      print("zzzzzz");
      final navigator = Navigator.of(context);
      await navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              MyHomePagetest(widget.usernameController),
        ),
      );

      /* Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => MyHomePagetest(widget.usernameController)), (
                route) => false);*/
    });

  }


  Widget dfsdf(){
    return Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(10.0)
              ),
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Center(
                      child: new Text(
                        "Process Image\n Please.. waitx...",
                        style: new TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.white,
        context: context,
        builder: (BuildContext builderContext) {
          _timer = Timer(Duration(seconds: 5), () async{
            print("zzzzzz");
            final navigator = Navigator.of(context);
          await navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  MyHomePagetest(widget.usernameController),
            ),
          );

           /* Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => MyHomePagetest(widget.usernameController)), (
                route) => false);*/
          });

          return  AlertDialog(
              content: Container(
                height: 150,
                child: dfsdf(),
              )
          );
        }
    ).then((val){
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff1280b3),

      ),
      body: Center(
        child: Text(widget.usernameController),
      ),


    );
  }
}