import 'package:flutter/material.dart';

import '../../../constant/app_images.dart';

class ChangeImageWidget extends StatefulWidget {
  const ChangeImageWidget({super.key});

  @override
  _ChangeImageWidgetState createState() => _ChangeImageWidgetState();
}

class _ChangeImageWidgetState extends State<ChangeImageWidget> {
  double _imageWidth = 50;
  double _imageHeight = 50;
  double _imagePosition = 100.0;

  @override
  void initState() {
    super.initState();
    _animateImage(); // Start the animation after 2 seconds (you can change this delay)
  }

  void _animateImage() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _imageWidth = 200;
        _imageHeight = 200;
        _imagePosition = 100.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _imageWidth,
              height: _imageHeight,
              margin: EdgeInsets.only(top: _imagePosition),
              child: Image.asset(
                AppImage.logoLanding,
              ), // Replace 'image.png' with your image asset path
            ),
          ],
        ),
      ],
    );
  }
}
