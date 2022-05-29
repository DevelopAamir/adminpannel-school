

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as paint;


class WidgetToImage extends StatefulWidget {
  final Function(GlobalKey key) builder;
  const WidgetToImage({Key? key, required this.builder}) : super(key: key);

  @override
  State<WidgetToImage> createState() => _WidgetToImageState();
}

class _WidgetToImageState extends State<WidgetToImage> {
  final globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: widget.builder(globalKey),
    );
  }
}

// class Utils {
//   static capture(GlobalKey key) {
//     if (key == null) return null;
//     paint.RenderRepaintBoundary boun dary = key.currentContext!.
//     boundary.toImage()
//   }
// }
