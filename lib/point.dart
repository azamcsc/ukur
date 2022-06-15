import 'package:document_measure/document_measure.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'dart:async';
import 'point2.dart';
import 'camera.dart';

//class MetadataRepository {}

class MyHomePagetest extends StatefulWidget {
  final String usernameController;//if you have multiple values add here
  MyHomePagetest(this.usernameController, {Key key}): super(key: key);

  @override
  _MyHomePagetestState createState() => _MyHomePagetestState();
}



class _MyHomePagetestState extends State<MyHomePagetest> {
  Color selectedColor = Colors.blue;
  Color unselectedColor = Colors.red;
  var val1;
  var val2;
//var cc = ${widget.usernameController};

  Timer _timer;
  static String originalTitle = 'Measurement app';
  String title = originalTitle;
  bool measure = true;
  bool showDistanceOnLine = true;
  bool showTolerance = false;
  bool zoomed = true;

  List<LengthUnit> unitsOfMeasurement = [
    Meter.asUnit(),
    Millimeter.asUnit(),
    Inch.asUnit(),
    Foot.asUnit()
  ];
  int unitIndex = 1;


  MeasurementController controller;
 // MeasurementController controller2;

  @override
  void initState() {
   // check whether the state object is in tree
      setState(() {
        controller =  MeasurementController();
        // make changes here
      });
print("ddddddddd");

   // controller.resetZoom();
   // dafsfsdfs();
    //screenLoadingx(context,"ProcessImage","ssss",false,true,false);
    _showDialog();
      print("oooooo");
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
                        "Process Image\n Please.. wait...",
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
          _timer = Timer(Duration(seconds: 5), () {
            if (zoomed) {
              controller.resetZoom();
              print("xxxxxx");
              print(zoomed);
            } else {
              controller.zoomToLifeSize();
              print("yyyyy");
              print(zoomed);
            }

            setState(() {
              zoomed = !zoomed;
            });
            Navigator.of(context).pop();
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

rePoint()async{
    print(widget.usernameController);
  await  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => MyHomePagetest2((widget.usernameController).toString())), (
      route) => false);
}




  Color getButtonColor(bool selected) {
    if (selected) {
      return selectedColor;
    } else {
      return unselectedColor;
    }
  }

  @override
  Widget build(BuildContext context) {
   // debugPaintSizeEnabled=true;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Point Measurement"),
      ),
     /* appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff1280b3),
        title: Row(
          children: <Widget>[
            IconButton(
              onPressed: () => setState(() {
                measure = !measure;
                title = originalTitle;
              }),
              icon: Icon(
                Icons.straighten,
                color: getButtonColor(
                  measure,
                ),
              ),
            ),
            IconButton(
              onPressed: () =>
                  setState(() => showDistanceOnLine = !showDistanceOnLine),
              icon: Icon(
                Icons.vertical_align_bottom,
                color: getButtonColor(showDistanceOnLine),
              ),
            ),

            SizedBox.fromSize(
              child: MaterialButton(
                shape: CircleBorder(),
               onPressed: ()async{

               },
               // onPressed: () =>setState(() => showTolerance = !showTolerance),
                child: Text("x"),
                //textColor: getButtonColor(showTolerance),
                //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              size: Size(52, 52),
            ),
            SizedBox.fromSize(
              child: MaterialButton(
                shape: CircleBorder(),
                onPressed: () => setState(() =>
                unitIndex = (unitIndex + 1) % unitsOfMeasurement.length),
                child: Text(unitsOfMeasurement[unitIndex].getAbbreviation()),
                textColor: unselectedColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              size: Size(64, 64),
            ),
            IconButton(
                onPressed: () {
                  if (zoomed) {
                    controller.resetZoom();
                    print("xxxxxx");
                    print(zoomed);
                  } else {
                    controller.zoomToLifeSize();
                    print("yyyyy");
                    print(zoomed);
                  }

                  setState(() {
                    zoomed = !zoomed;
                  });
                },
                icon:
                Icon(Icons.zoom_out_map, color: getButtonColor(zoomed))),
          ],
        ),
      ),*/
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Measurements(
                magnificationStyle: MagnificationStyle(
                  magnificationColor: Color.fromARGB(255, 200, 50, 80),
                  magnificationRadius: 60,
                  outerCircleThickness: 5,
                  crossHairThickness: 2,
                ),
                pointStyle: PointStyle(
                  dotColor: Color.fromARGB(255, 200, 50, 80),
                  dotRadius: 5,
                  lineType: DashedLine(
                    dashWidth: 4,
                    dashLength: 10,
                    dashDistance: 12,
                    lineColor: Color.fromARGB(255, 50, 200, 80),
                  ),
                ),

                /*deleteChild: Container(
             width: MediaQuery.of(context).size.width,
             height: 100,
             color: Colors.blue,
           ),*/
                deleteChildAlignment: Alignment.bottomRight,
                child:Image.file(File(widget.usernameController), fit: BoxFit.cover,),
                measurementInformation: MeasurementInformation(
                  scale: 1 / 1,//50.0,
                  documentWidthInLengthUnits: Millimeter(200),
                  documentHeightInLengthUnits: Millimeter(200),
                  targetLengthUnit: unitsOfMeasurement[unitIndex],
                ),
                controller: controller,
                showDistanceOnLine: showDistanceOnLine,
                distanceStyle: DistanceStyle(
                  showTolerance: showTolerance,
                  numDecimalPlaces: 2,
                ),
                measure: measure,
              ),

            ),

          ),
          RaisedButton(
            child: Text("Value 1 :$val1", style: TextStyle(fontSize: 20),),
            onPressed:(){
              var dosx;
              if(controller.distances!=null){
                setState(() {
                  val1 =((controller.distances).toString()).replaceAll("[", "").replaceAll("]", "");//().substring(0,2);
                  dosx = double.parse(val1);
                  val1= dosx.toStringAsFixed(2);
                });
              }
            },
            color: Colors.red,
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.grey,
          ),
          RaisedButton(
            child: Text("Value 2 :$val2", style: TextStyle(fontSize: 20),),
            onPressed:(){
              var dosy;
              if(controller.distances!=null){
                setState(() {
                  setState(() {
                    val2 =((controller.distances).toString()).replaceAll("[", "").replaceAll("]", "");//().substring(0,2);
                    dosy = double.parse(val2);
                    val2= dosy.toStringAsFixed(2);
                  });
                });
              }
            },
            color: Colors.white,
            textColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.grey,
          ),
          RaisedButton(
            child: Text("Calculate result", style: TextStyle(fontSize: 20),),
            onPressed:(){
              var jj;
              var dos;



              if(val1 !=null && val2 !=null){
                setState(() {
                  jj =(double.tryParse(val1) - double.tryParse(val2))/2;
                });

                Alert(
                  context: context,
                  type: AlertType.info,
                  title: "Decentration  for each lens :",
                  desc: "${num.parse(jj.toStringAsFixed(2))} mm",
                  buttons: [
                    DialogButton(
                        child: Text(
                          "New Photo",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed:(){
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context) => MyHomePage()), (
                              route) => false);
                        }

                    ),
                  /*  DialogButton(
                        child: Text(
                          "Repoint",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () {
                          rePoint();

                        }
                    )*/
                  ],
                ).show();


              }else{
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "ERROR",
                  desc: "No point selected",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                    )
                  ],
                ).show();
              }
            },
            color: Colors.blue,
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.grey,
          )
        ],
      ),

    );
  }
}