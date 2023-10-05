import 'package:discovery_zone/core/helpers/helper_functions.dart';
import 'package:discovery_zone/core/utils/api_constatns.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';



class ShowImageScreen extends StatelessWidget {
  final String images;
  const ShowImageScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

PhotoView(
      imageProvider: NetworkImage(ApiConstants.imageUrl(images)),
         initialScale: PhotoViewComputedScale.contained * 0.8,
    ),

    // PhotoViewGallery.builder(
    //   scrollPhysics: const BouncingScrollPhysics(),
    //   builder: (BuildContext context, int index) {
    //     return PhotoViewGalleryPageOptions(
    //       imageProvider: NetworkImage(ApiConstants.imageUrl(images[index])),
    //       initialScale: PhotoViewComputedScale.contained * 0.8,
    //       // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
    //     );
    //   },
    //   itemCount: images.length,
    //   loadingBuilder: (context, event) => Center(
    //     child: Container(
    //       width: 20.0,
    //       height: 20.0,
    //       child: CircularProgressIndicator(
    //         value: event == null
    //             ? 0
    //             : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
    //       ),
    //     ),
    //   ),
    //   // backgroundDecoration: widget.backgroundDecoration,
    //   // pageController: widget.pageController,
    // ),
 
    Positioned(
        right: 30,
        top: 50,
        child: GestureDetector(
          onTap: () {
            pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        )),
      ],
    );
  }
}
