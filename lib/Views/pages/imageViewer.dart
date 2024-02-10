import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  dynamic data = {};
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments;
    List pictures = data['picture'];
    // pageController.animateToPage(1,
    //     duration: Duration(milliseconds: 500), curve: Curves.easeIn);

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: pageController,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(pictures[index]),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 3);
              },
              itemCount: pictures.length,
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Row(
                children: const [
                  Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
