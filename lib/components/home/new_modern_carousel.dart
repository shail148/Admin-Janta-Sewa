import 'package:admin_jantasewa/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

/// --- Notched top-right clipper with deeper cut ---
class NotchedCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const cornerRadius = 22.0;
    const notchRadius = 28.0;
    const notchWidth = 55.0; // horizontal cut depth
    const notchHeight = 50.0; // vertical cut depth

    final path = Path();

    // top-left rounded corner
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // top edge to notch start
    path.lineTo(size.width - notchWidth - notchRadius, 0);
    path.quadraticBezierTo(
      size.width - notchWidth,
      0,
      size.width - notchWidth,
      notchRadius,
    );

    // inside notch
    path.lineTo(size.width - notchWidth, notchHeight - notchRadius);
    path.quadraticBezierTo(
      size.width - notchWidth,
      notchHeight,
      size.width - notchWidth + notchRadius,
      notchHeight,
    );

    // across to right edge
    path.lineTo(size.width - cornerRadius, notchHeight);
    path.quadraticBezierTo(
      size.width,
      notchHeight,
      size.width,
      notchHeight + cornerRadius,
    );

    // right, bottom edges
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// --- Card used inside the carousel ---
class RequestCard extends StatelessWidget {
  final String title;
  final int count;
  final double percentage;
  final bool isPositive;
  final Color bgColor;
  final Color accentColor;
  final String imageAsset;
  final VoidCallback? onTap;

  const RequestCard({
    super.key,
    required this.title,
    required this.count,
    required this.percentage,
    required this.isPositive,
    required this.bgColor,
    required this.accentColor,
    required this.imageAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      //child: SizedBox(
       // width: double.infinity, // increase width
       // height: 200, //  increase height
       
        child: Card(
          elevation: 0, // no shadow color fill
          color: Colors.transparent, // transparent surface
          //margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            
            clipBehavior: Clip.none,
            children: [
              ClipPath(
                clipper: NotchedCardClipper(),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgColor,
                      /* border: Border.all(
                       color: AppColors.textGrey, // light grey border
                       width: 1, // thickness
                     ), */  

                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // left content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '$count',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Icon(
                                  isPositive
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 14,
                                  color: isPositive
                                      ? Colors.green
                                      : Colors.redAccent,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${percentage.abs()}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isPositive
                                        ? Colors.green
                                        : Colors.redAccent,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'This month',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: Image.asset(imageAsset, fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ),
              ),
              // arrow button neatly in the notch
              Positioned(
                top: 2,
                right: 5,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: accentColor, // ← use the card’s accentColor
                  child: Icon(
                    Icons.arrow_outward,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
     // ),
    );
  }
}

/// --- Carousel using the RequestCard ---
class NewModernCarousel extends StatefulWidget {
  const NewModernCarousel({super.key});
  @override
  State<NewModernCarousel> createState() => _NewModernCarouselState();
}

class _NewModernCarouselState extends State<NewModernCarousel> {
  //final CarouselController _controller = CarouselController();

  int _current = 0;

  late final List<Widget> cards = [
    RequestCard(
      title: 'New request',
      count: 250,
      percentage: 20,
      isPositive: true,
      bgColor: const Color(0xFFE8F0FF),
      accentColor: const Color(0xFF4A6CF7), // blue arrow
      imageAsset: 'assets/images/mail_request.png',
    ),
    RequestCard(
      title: 'Approved request',
      count: 250,
      percentage: 20,
      isPositive: true,
      bgColor: const Color(0xFFE8F8F1),
      accentColor: const Color(0xFF20A86B), // green arrow
      imageAsset: 'assets/images/verified.png',
    ),
    RequestCard(
      title: 'Pending request',
      count: 250,
      percentage: 20,
      isPositive: false,
      bgColor: const Color(0xFFFFF3E5),
      accentColor: const Color(0xFFD19B06), // yellow/orange arrow
      imageAsset: 'assets/images/hourglass_bottom.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
         // width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            items: cards,
            // carouselController: _controller,
            options: CarouselOptions(
              //height: 220,    // increase  up from 170 to 240 now
              aspectRatio: 2 / 1,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              onPageChanged: (i, _) => setState(() => _current = i),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cards.asMap().entries.map((e) {
            return GestureDetector(
              //onTap: () => _controller.animateToPage(e.key),
              child: Container(
                width: _current == e.key ? 12 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _current == e.key
                      ? Colors.blueAccent
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}


/* import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

/// Custom clipper to create a curve cut on the top-right corner
/// Makes a circular notch in the top-right corner
class TopRightNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double notchRadius = 28; // notch size
    const double borderRadius = 16;

    final path = Path();

    // top-left rounded corner
    path.moveTo(0, borderRadius);
    path.quadraticBezierTo(0, 0, borderRadius, 0);

    // straight line until the notch starts
    path.lineTo(size.width - notchRadius, 0);

    // skip the notch (cut-out circle)
    path.arcTo(
      Rect.fromCircle(
        center: Offset(size.width - notchRadius, notchRadius),
        radius: notchRadius,
      ),
      -1.57, // start from top
      1.57,  // sweep down (cut-out)
      false,
    );

    // continue along right edge
    path.lineTo(size.width, size.height - borderRadius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - borderRadius, size.height);

    // bottom edge and back
    path.lineTo(borderRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - borderRadius);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class RequestCard extends StatelessWidget {
  final String title;
  final int count;
  final double percentage;
  final bool isPositive;
  final Color bgColor;
  final Color accentColor;
  final String imageAsset; // big image on the right
  final VoidCallback? onTap;

  const RequestCard({
    super.key,
    required this.title,
    required this.count,
    required this.percentage,
    required this.isPositive,
    required this.bgColor,
    required this.accentColor,
    required this.imageAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            ClipPath(
              clipper: TopRightNotchClipper(),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // left content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$count',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(
                                isPositive
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                size: 14,
                                color: isPositive
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${percentage.abs()}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isPositive
                                      ? Colors.green
                                      : Colors.redAccent,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'This month',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // big right image
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: Image.asset(
                        imageAsset,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // arrow button sitting neatly in the cut area
            Positioned(
              top: 6,
              right: 6,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: accentColor,
                child: const Icon(
                  Icons.arrow_outward,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewModernCarousel extends StatefulWidget {
  const NewModernCarousel({super.key});
  @override
  State<NewModernCarousel> createState() => _NewModernCarouselState();
}

class _NewModernCarouselState extends State<NewModernCarousel> {
  final CarouselController _controller = CarouselController();
  
  int _current = 0;

  late final List<Widget> cards = [
    RequestCard(
      title: 'New request',
      count: 250,
      percentage: 20,
      isPositive: true,
      bgColor: const Color(0xFFE8F0FF),
      accentColor: const Color(0xFF4A6CF7),
      imageAsset: 'assets/images/mail_request.png', 
    ),
    RequestCard(
      title: 'Approved request',
      count: 250,
      percentage: 20,
      isPositive: true,
      bgColor: const Color(0xFFE8F8F1),
      accentColor: const Color(0xFF20A86B),
      imageAsset: 'assets/images/verified.png',
    ),
    RequestCard(
      title: 'Pending request',
      count: 250,
      percentage: 20,
      isPositive: false,
      bgColor: const Color(0xFFFFF3E5),
      accentColor: const Color(0xFFD19B06),
      imageAsset: 'assets/images/hourglass_bottom.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: cards,
          //carouselController: _controller,
          options: CarouselOptions(
            height: 170,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            onPageChanged: (i, _) => setState(() => _current = i),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cards.asMap().entries.map((e) {
            return GestureDetector(
              //onTap: () => _controller.animateToPage(e.key),
              child: Container(
                width: _current == e.key ? 12 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _current == e.key
                      ? Colors.blueAccent
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

 */

//old code shailendra
/* import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final int count;
  final double percentage;
  final bool isPositive;
  final Gradient? gradientColor;
  final Widget? childWidget;
  final Color? containerBgColor;
  final Color? allrequestbgColor;

  const RequestCard({
    super.key,
    required this.title,
    required this.count,
    required this.percentage,
    required this.isPositive,
    this.gradientColor,
    this.childWidget,
    this.containerBgColor,
    this.allrequestbgColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      child: Center(
        child: ClipPath(
          clipBehavior: Clip.hardEdge,
          clipper: NotchedCardClipper(),
          child: Container(
            // width: screenWidth,
            // height: screenHeight / 5,
            padding: const EdgeInsets.all(16),
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  /// Main column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Count
                      Text(
                        '$count',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const Spacer(),

                      // Bottom Row (percentage + all request button)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Percentage container
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (isPositive ? Colors.green : Colors.red)
                                  // ignore: deprecated_member_use
                                  .withOpacity(0.1),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isPositive
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  color: isPositive ? Colors.green : Colors.red,
                                  size: 14,
                                ),
                                Text(
                                  '${percentage.toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isPositive
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Top-right arrow
                  Positioned(
                    top: -26,
                    right: -26,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.white,
                        //   style: BorderStyle.solid,
                        //   width: 4,
                        // ),
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_outward,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(child: Image.asset("assets/icons/request.png")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NewModernCarousel extends StatefulWidget {
  const NewModernCarousel({super.key});

  @override
  State<NewModernCarousel> createState() => _NewModernCarouselState();
}

class _NewModernCarouselState extends State<NewModernCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  final List<RequestCard> cards = const [
    RequestCard(
      title: "New Request",
      count: 25,
      percentage: 2.0,
      isPositive: true,
      allrequestbgColor: Color(0xFF264D8E),

      childWidget: Icon(
        Icons.description_outlined,
        color: Colors.white,
        size: 24,
      ),
    ),
    RequestCard(
      title: "Approved Request",
      count: 25,
      percentage: 12.0,
      allrequestbgColor: Color(0xFF08532F),
      isPositive: true,
      childWidget: Icon(Icons.verified, color: Colors.white, size: 24),
      gradientColor: LinearGradient(
        colors: [Color(0xFF08532F), Color(0xFF1FBD70)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    RequestCard(
      title: "Pending Request",
      count: 12,
      percentage: -3.2,
      allrequestbgColor: Color(0xFF91721E),
      isPositive: false,
      childWidget: Icon(
        Icons.pending_actions_sharp,
        color: Colors.white,
        size: 24,
      ),
      gradientColor: LinearGradient(
        colors: [Color(0xFF91721E), Color(0xFFD19B06)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: cards,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height / 4.5,
            initialPage: 0,
            viewportFraction: 1,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cards.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: _currentIndex == entry.key ? 12.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _currentIndex == entry.key
                      ? AppColors.btnBgColor
                      : Colors.grey.shade400,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class NotchedCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const cornerRadius = 12.0;
    const notchWidth = 30.0;
    const notchHeight = 24.0;
    const notchRadius = 20.0;




    final path = Path();

    // Start at top-left with rounded corner
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    // Top edge to notch start
    path.lineTo(size.width - notchWidth - notchRadius, 0);

    // Top curve into notch
    path.quadraticBezierTo(
      size.width - notchWidth,
      0,
      size.width - notchWidth,
      notchRadius,
    );

    // Downward line inside notch
    path.lineTo(size.width - notchWidth, notchHeight - notchRadius);

    // Curve out to right edge
    path.quadraticBezierTo(
      size.width - notchWidth,
      notchHeight,
      size.width - notchWidth + notchRadius,
      notchHeight,
    );

    // Continue to top-right corner (rounded)
    path.lineTo(size.width - cornerRadius, notchHeight);
    path.quadraticBezierTo(
      size.width,
      notchHeight,
      size.width,
      notchHeight + cornerRadius,
    );

    // Right edge
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );

    // Bottom edge
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
 */