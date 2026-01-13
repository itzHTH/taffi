import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCachedNetworkAvatar extends StatelessWidget {
  const CustomCachedNetworkAvatar({
    super.key,
    required this.imageUrl,
    required this.size,
    this.hasBorder = true,
    this.isSvg = false,
    this.padding = EdgeInsets.zero,
  });

  final String imageUrl;
  final double size;
  final bool hasBorder;
  final bool isSvg;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Color(0xFF3481B9).withAlpha(60),
        shape: BoxShape.circle,
        border: hasBorder
            ? Border.all(color: Color(0xffDFEEFF), width: 2)
            : null,
      ),
      child: isSvg
          ? SvgPicture.network(
              imageUrl,
              width: size,
              height: size,
              fit: BoxFit.cover,
              placeholderBuilder: (context) => Center(
                child: SizedBox(
                  width: size - 6,
                  height: size - 6,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                width: size,
                height: size,
                child: CircleAvatar(
                  radius: size / 2,
                  backgroundImage: imageProvider,
                ),
              ),
              placeholder: (context, url) => Center(
                child: SizedBox(
                  width: size - 6,
                  height: size - 6,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEEEEEE),
                ),
                child: const Icon(Icons.error, color: Colors.red),
              ),
              fadeInDuration: const Duration(milliseconds: 300),
            ),
    );
  }
}
