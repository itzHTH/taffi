import 'package:flutter/material.dart';
import 'package:taffi/core/widgets/custom_cached_network_avatar.dart';

class SpecialtyCard extends StatelessWidget {
  const SpecialtyCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    this.hasHero = true,
  });

  final String imageUrl;
  final String title;
  final VoidCallback onTap;
  final bool hasHero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCachedNetworkAvatar(
              imageUrl: imageUrl,
              size: 50,
              hasBorder: false,
              isSvg: true,
              padding: EdgeInsets.all(16),
            ),
            SizedBox(height: 4),
            hasHero
                ? Hero(
                    tag: title,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
          ],
        ),
      ),
    );
  }
}
