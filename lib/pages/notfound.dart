import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageURL = 'assets/images/no-data-concept-illustration_203587-28.png';
    var imageUrl = AssetImage(imageURL);
    precacheImage(imageUrl, context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Image(
          image: imageUrl,
        ),
      ),
    );
  }
}
