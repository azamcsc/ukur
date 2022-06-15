import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'point.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
//import 'xxx.dart';



class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PermissionStatus _status;
  var getPath;
  @override
  void initState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.camera)
        .then(_updateStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Take Photo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [BoxShadow(color: Colors.blueAccent)]),
                padding: EdgeInsets.all(24.0),
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  iconSize: 50.0,
                  onPressed: () {
                    _askPermission();
                  },
                ),
              )


            ],
          ),

        ));
  }

  void _displayOptionsDialog() async {
    await _optionsDialogBox();
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take Photo'),
                    onTap: _askPermission,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select Image From Gallery'),
                    onTap: imageSelectorGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _askPermission() {
    PermissionHandler().requestPermissions([PermissionGroup.camera]).then(_onStatusRequested);
    // PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> value) {
    final status = value[PermissionGroup.camera];
    if (status == PermissionStatus.granted) {
      // imageSelectorCamera(context);
      showDialog(
          barrierDismissible: false,
          barrierColor: Colors.white,
          context: context,
          builder: (BuildContext builderContext) {
            return  AlertDialog(
                content: Container(
                  height: 150,
                  child: dfsdf(),
                )
            );
          });

      _takePhoto();
    } else {
      _updateStatus(status);
    }
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
                        "Checking Image\n Please.. wait...",
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

  _updateStatus(PermissionStatus value) {
    if (value != _status) {
      setState(() {
        _status = value;
      });
    }
  }


  void _takePhoto() async {

    ImagePicker.pickImage(source: ImageSource.camera)
        .then((File recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        setState(() {
          //firstButtonText = 'saving in progress...';
        });
        GallerySaver.saveImage(recordedImage.path, albumName: "albumName")
            .then((bool success) async{

          Navigator.pop(context);
          /*final navigator = Navigator.of(context);
          await navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  MyHomePagetest(recordedImage.path),
            ),
          );*/
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => MyHomePagetest(recordedImage.path)), (
              route) => false);

          print("ccccccc");
          print(recordedImage.path);
          print("ccccccc");

        });
      }
    });




  }


/*
  void imageSelectorCamera(BuildContext context) async {
    Navigator.pop(context);
    final navigator = Navigator.of(context);
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera,);





   var _image = File(imageFile.path);

    // getting a directory path for saving
    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    final String filePath = '$dirPath/image.png';

// copy the file to a new path
    final File newImage = await _image.copy(filePath);

    String xx =imageFile.toString();
    print("xxxxxyyyyxxxxx");
    print(newImage);
    print("xxxxxxyyyyyxxxx");
    await navigator.push(
      MaterialPageRoute(
        builder: (context) =>
            MyHomePagetest(newImage),
      ),
    );

    // DisplayImage(imageFile);
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp1()));
   // _navigateToNextScreen(context);

  }*/

  void _navigateToNextScreen(BuildContext context) async{
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp1()));
    // await Navigator.push(context, MaterialPageRoute( builder: (context) =>MyHomePagetest()));

  }

  Widget DisplayImage(imageFilepath){
    // var _image = File(imageFilepath);


    return Container(
        padding:
        EdgeInsets.zero,
        height: 150,
        width: 150,
        child: Image.file(File(imageFilepath))
    );
  }

  void imageSelectorGallery() async {
    Navigator.pop(context);
    var imageFile1 = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
  }
}