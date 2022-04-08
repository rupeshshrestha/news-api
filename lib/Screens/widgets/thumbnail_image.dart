// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ThumbnailImage extends StatelessWidget {
  String urlToImage;
  ThumbnailImage({Key? key, required this.urlToImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, right: 250),
      child: ClipOval(
        child: (urlToImage != 'null')
            ? Hero(
                tag: urlToImage,
                child: Image.network(
                  urlToImage,
                  fit: BoxFit.cover,
                  height: 70.0,
                  width: 70.0,
                ))
            : Container(
                color: Colors.black,
                height: 75.0,
                width: 75.0,
                child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Image',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              
      ),
    );

    // return Container(
    //     margin: const EdgeInsets.symmetric(vertical: 6.0),
    //     alignment: FractionalOffset.centerLeft,
    //     //'https://raw.githubusercontent.com/sergiandreplace/planets-flutter/master/assets/img/mars.png'
    //     child: Image.network(urlToImage
    //       ,
    //       height: 92,
    //       width: 92,
    //     ));
  }
}
