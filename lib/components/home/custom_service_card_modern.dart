import 'package:flutter/material.dart';

class CustomServiceCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color borderColor;
  final double imageBoxFactor; // default 0.45

  const CustomServiceCard({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onTap,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFEEEEEE),
    this.imageBoxFactor = 0.45,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = width ?? screenWidth * 0.60;
    final cardHeight = height ?? screenHeight * 0.14;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.90),
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
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