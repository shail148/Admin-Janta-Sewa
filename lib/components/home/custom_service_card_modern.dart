import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:flutter/material.dart';

class CustomServiceCard extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final String imagePath;
  final VoidCallback onTap;
  final double imageBoxFactor;
  final Color backgroundColor;
  final Color borderColor;

  const CustomServiceCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.height,
    this.width,
    this.imageBoxFactor = 0.6,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFEEEEEE),
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // keep default width similar to original admin card so two cards fit in a row
    final double cardWidth = width ?? (screenWidth / 2.4);
    // final cardWidth = width ?? screenWidth * 0.41;

    // use a sensible default height (can be overridden)
    final double cardHeight = height ?? (screenHeight * 0.10);

    final double imgSize =
        (cardHeight < cardWidth ? cardHeight : cardWidth) * 0.8;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: cardHeight,
        width: cardWidth,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.95),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // top-left title
            Positioned(
              left: 10,
              top: 8,
              right: imgSize * 0.4,
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.visible,
                softWrap: false, // prevents line break
              ),
            ),

            // bottom-right image
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: cardWidth * imageBoxFactor,
                height: cardHeight * imageBoxFactor,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/* import 'package:flutter/material.dart';

class CustomServiceCard extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final String imagePath;
  final VoidCallback onTap;

  const CustomServiceCard({
    super.key,
    required this.title,
    this.height,
    this.width,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Card dimensions
    final double cardWidth = width ?? (screenWidth / 2.4);
    final double cardHeight = height ?? 100;

    final double imgSize =
        (cardHeight < cardWidth ? cardHeight : cardWidth) * 0.8;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: cardHeight,
        width: cardWidth,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   alignment: Alignment.bottomRight,
          //   image: AssetImage(imagePath),
          //   scale: 30,
          //   fit: BoxFit.contain,
          // ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 240, 237, 237),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            const Positioned(top: 5, left: 5, child: SizedBox.shrink()),
            Positioned(
              top: 5,
              left: 5,
              right: imgSize * 0.4,
              child: Text(
                title,
                //maxLines: 2,
                //overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              bottom: -9,
              right: -9,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
                child: Image.asset(
                  imagePath,
                  height: imgSize,
                  width: imgSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Image.asset(
            //     imagePath,
            //     height: imgSize,
            //     width: imgSize,
            //     fit: BoxFit.contain,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}


 */