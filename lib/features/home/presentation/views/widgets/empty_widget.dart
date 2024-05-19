import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.svgImagePath,
    required this.text,
  });

  final String svgImagePath;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgImagePath,
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(text),
          )
        ],
      ),
    );
  }
}
