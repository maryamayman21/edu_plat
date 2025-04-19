import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;
  final String imageName;

  const ImageViewerScreen({Key? key, required this.imageUrl, required this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(imageName),
      ),
      body: Center(
        child: Container(
           decoration: BoxDecoration(
               image: DecorationImage(image: NetworkImage(imageUrl),
               fit: BoxFit.fill
               )
           ),
        )
      ),
    );
  }
}