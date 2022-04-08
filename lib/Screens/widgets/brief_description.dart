import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BriefDescription extends StatelessWidget {
  String title;
  String publishedAt;
  int position;

  final TextStyle _title = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  BriefDescription({
    Key? key,
    required this.title,
    required this.publishedAt,
    required this.position,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: (position.isEven)
            ? const Color.fromARGB(69, 13, 10, 110)
            : Colors.blue,
        shape: BoxShape.rectangle,
        //borderRadius: BorderRadius.circular(8.0),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45.0),
            bottomLeft: Radius.circular(45.0),
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.length > 50 ? title.substring(0, 50) +'...': title,
              style: _title,
            ),
            Text(
              publishedAt,
            ),
          ],
        ),
      ),
    );
  }
}
