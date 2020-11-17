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
import 'package:carousel_slider/carousel_slider.dart';

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

  Future<Image> assetThumbToImage(Asset asset) async {
    final ByteData byteData = await asset.getByteData();

    final Image image = Image.memory(byteData.buffer.asUint8List());

    return image;
  }

  double _currentSliderValue = 0;

  // DateTime dateAdded = DateTime.now();
  // final List<String> flowers = <String>['Protea', 'Rose', 'Flour'];
  //List<String> colours = ['Red', 'Green', 'Flour coloured (off-white)'];

  @override
  Widget build(BuildContext context) {
    int stemLength = _currentSliderValue.toInt();
    Widget buildCarousel() {
      if (images.length != 0){

        /*for(final Asset asset in images){
          Image thumbImg = await assetThumbToImage(asset);
          return Image(image: thumbImg.image,);
        }*/
         return Column(
           children: <Widget>[
             CarouselSlider(
               options: CarouselOptions(height: 300, autoPlay: true,autoPlayInterval: Duration(seconds: 3),
                 autoPlayAnimationDuration: Duration(milliseconds: 800),),
               items: images.map((image) => AssetThumb(asset: image,width: 300,height: 300,),).toList(),
             ),
           ],
         )
           ;}
      else
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imageplaceholder.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        );

    }

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
          .updateStockData(imageUrls, flowerType, _itemCount,stemLength,
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
                    Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          width: 500,
                          child: buildCarousel()
                          ,),
                        Positioned(
                            left: 0.0,
                            top: 20.0,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: 30,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20.0)),
                          child: Container(
                            height: 290,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                        height: 80,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                          ),
                                        )

                                    ),
                                    Icon(
                                      Icons.info_outline,
                                      size: 20,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                Text(
                                  'Quick Tip!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Choose the following photos for more detail:'
                                      '1. Top View'
                                      '2. Side View'
                                      '3. Petals'
                                      '4. Stem'
                                      '5. Leaf'
                                ),
                                FlatButton(
                                  color: Colors.green,
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                        color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onPressed: () async {
                                    loadAssets();
                                  }
                                ),
                              ],
                            ),
                          )

                        );
                      },
                      child: Text(
                          'Pick Images',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Stem Length:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Slider(
                          value: _currentSliderValue,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          activeColor: Colors.green,
                          inactiveColor: Colors.lightGreen,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                        Text(
                          'in cm',
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
                        color: Colors.redAccent,
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

