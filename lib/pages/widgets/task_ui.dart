import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String imageURL;
  final String text;
  final void Function()? ontap;
  const TaskWidget({
    Key? key,
    this.text = '',
    this.imageURL = '',
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = AssetImage(imageURL);
    precacheImage(imageUrl, context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: ontap,
            child: Card(
              color: Theme.of(context).backgroundColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, top: 15, right: 15, bottom: 15),
                child: Container(
                  padding: const EdgeInsets.all(0),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ),
          Positioned(
            left: -20,
            top: -5,
            child: Image(
              image: imageUrl,
            ),
          ),
        ],
      ),
    );
  }
}
