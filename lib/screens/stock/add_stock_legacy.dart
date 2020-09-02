import 'dart:math';

import 'package:bloomflutterapp/models/stock.dart';
import 'package:bloomflutterapp/models/user.dart';
import 'package:bloomflutterapp/services/WebBrowser.dart';
import 'package:bloomflutterapp/services/database.dart';
import 'package:bloomflutterapp/services/image.dart';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:async';
import 'package:carousel_pro/carousel_pro.dart';

class AddStockMultiplePhotos extends StatefulWidget {
  @override
  _AddStockMultiplePhotosState createState() => _AddStockMultiplePhotosState();
}

class _AddStockMultiplePhotosState extends State<AddStockMultiplePhotos> {
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error;
  Color currentColor = Colors.redAccent;
  Color pickerColor = Colors.redAccent;

  void changeColor(Color color) => setState(() => pickerColor = color);

  final _formKey = GlobalKey<FormState>();

  File _image;
  String url;
  final _picker = ImagePicker();

  int _itemCount = 0;

  final date = new DateFormat('dd-MM-yyyy');

  String flowerType = '';




  Widget buildCarousel() {
    if (images.length != 0){
List<ExactAssetImage> imgs = List<ExactAssetImage>();
for(final Asset asset in images){
  imgs.add(ExactAssetImage(asset.getByteData().toString()));
}

      return Carousel(
          boxFit: BoxFit.cover,
          images: [],
          autoplay: false,
          indicatorBgPadding: 5.0,
          dotPosition: DotPosition.bottomCenter,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 2000));}
    else{
      return Container(color: Colors.white);
    }
    }


  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: false,

      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }
  Future saveImage(Asset asset) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    StorageReference ref = FirebaseStorage.instance.ref().child("StockPhotos/"+ asset.name+DateTime.now().toIso8601String());
    StorageUploadTask uploadTask = ref.putData(imageData);

    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }





  // DateTime dateAdded = DateTime.now();
  // final List<String> flowers = <String>['Protea', 'Rose', 'Flour'];
  //List<String> colours = ['Red', 'Green', 'Flour coloured (off-white)'];

  @override
  Widget build(BuildContext context) {


    int flowerColour = pickerColor.value;

    final user = Provider.of<User>(context);

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    void uploadPic() async {
      String profilePic = DateTime.now().toString();
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("profile/");
      StorageUploadTask uploadTask = firebaseStorageRef.child(
          profilePic + ".jpg").putFile(_image);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();

      print("Image Url= " + url);
    }

    Future getImage() async {
      var image = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image.path);
        print('Image Path $_image');
        uploadPic();
      });
    }

    Future getImageCamera() async {
      var image = await _picker.getImage(source: ImageSource.camera);

      setState(() {
        _image = File(image.path);
        print('Image Path $_image');
        uploadPic();
      });
    }

    void saveImages(String companyName) async{
      for (final Asset asset in images){
        var url = await saveImage(asset);
        imageUrls.add(url);

      }
      
      await DatabaseService(uid: user.uid)
          .updateStockData(imageUrls, flowerType, _itemCount,_itemCount,
          flowerColour, companyName);
    }


    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: 700,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[

                    SizedBox(
                      height: 150,
                      width: 300,
                      child: /*Carousel(
                        images: images,
                      )*/
                      buildCarousel ()
                      ,),
                    RaisedButton(
                      child: Text('Pick Images'),
                      onPressed: loadAssets,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Flower Type:   ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          width: 158,
                          height: 45,
                          child: DropdownButtonFormField<String>(
                              hint: Text("Select Flower Type"),
                              value: null,
                              items: [
                                'King Protea',
                                'Rose',
                                'Disa',
                                'Erica',
                                'Cape Daisy',
                                'African Iris'
                              ]
                                  .map((label) =>
                                  DropdownMenuItem(
                                    child: Text(label),
                                    value: label,
                                  ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() => flowerType = value);
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child:
                          Text(
                            flowerType != '' ?
                            'More information about the $flowerType' : '',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () {
                            launchURL(flowerType: flowerType);

                          },
                        ),
                      ],
                    ),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Quantity:    ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        _itemCount != 0
                            ? new IconButton(
                          icon: new Icon(Icons.remove),
                          onPressed: () =>
                              setState(() => _itemCount = _itemCount - 10),
                        )
                            : new Container(),
                        new Text(_itemCount.toString()),
                        new IconButton(
                            icon: new Icon(Icons.add),
                            onPressed: () =>
                                setState(() => _itemCount = _itemCount + 10)),
                        Text(
                          'in stems',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Colour:   ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    titlePadding: const EdgeInsets.all(0),
                                    contentPadding: const EdgeInsets.all(0),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: pickerColor,
                                        onColorChanged: changeColor,
                                        colorPickerWidth: 300,
                                        pickerAreaHeightPercent: 0.7,
                                        enableAlpha: true,
                                        displayThumbColor: true,
                                        showLabel: true,
                                        paletteType: PaletteType.hsl,
                                        pickerAreaBorderRadius: const BorderRadius.only(
                                          topLeft: const Radius.circular(2),
                                          topRight: const Radius.circular(2),
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          setState(() => currentColor = pickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: ClipOval(
                            child: Container(
                              color: currentColor,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Date:   ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          date.format(DateTime.now()),
                          style:
                          new TextStyle(color: Colors.grey[850],
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: RaisedButton(
                        onPressed: () async {

                          saveImages(snapshot.data.companyName);
                          /*await DatabaseService(uid: user.uid)
                              .updateStockData(imageUrls, flowerType, _itemCount,_itemCount,
                              flowerColour, snapshot.data.companyName);*/


                          Navigator.pop(context);
                        },
                        color: Colors.red[200],
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
    );
  }

}

