import 'package:animate_do/animate_do.dart';
import 'package:cine_tfg_app/config/helpers/human_format.dart';
import 'package:cine_tfg_app/domain/entities/video_post.dart';
import 'package:flutter/material.dart';

class VideoButtons extends StatelessWidget {

  final VideoPost video;

  const VideoButtons({
    super.key, 
    required this.video
  });

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}


class _CustomIconButton extends StatelessWidget {

  final int value;
  final IconData iconData;
  final Color? color;

  const _CustomIconButton({
    required this.value, 
    required this.iconData, 
    iconColor
  }): color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {}, 
          icon: Icon( iconData, color: color, size: 30, )),

        if ( value > 0 )
        Text( HumanFormats.humanReadbleNumber(value.toDouble()) ),
      ],
    );
  }
}