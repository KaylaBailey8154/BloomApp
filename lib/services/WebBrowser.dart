import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL({String flowerType}) async {
  String url = 'https://flutter.dev';
  if(flowerType == 'King Protea'){
    url = 'http://pza.sanbi.org/protea-cynaroides';
  }
  if(flowerType == 'Rose'){
    url = 'https://www.britannica.com/plant/rose-plant';
  }
  if(flowerType == 'Disa'){
    url = 'http://pza.sanbi.org/disa-uniflora';
  }
  if(flowerType == 'Erica'){
    url = '';
  }
  if(flowerType == 'Cape Daisy'){
    url = 'http://pza.sanbi.org/erica-shannonii';
  }
  if(flowerType == 'African Iris'){
    url = 'http://pza.sanbi.org/dietes-grandiflora';
  }

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}