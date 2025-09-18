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

  const RequestCard({
    super.key,
    required this.title,
    required this.count,
    required this.percentage,
    required this.isPositive,
    this.gradientColor,
    this.childWidget,
    this.containerBgColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: gradientColor,
            color: containerBgColor ?? Colors.white,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
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
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // "This month" text
                  Text(
                    "This month",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
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
                          color: isPositive
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
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
                      // Child widget (icon)
                      if (childWidget != null) childWidget!,
                    ],
                  ),
                ],
              ),
              // Top-right arrow (outside the card)
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_outward,
                    size: 36, // Adjusted size of the arrow icon
                    color: Colors.white,
                  ),
                ),
              ),
            ],
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
      count: 250,
      percentage: 20.0,
      isPositive: true,
      containerBgColor: Color(0xFFE3F2FD),
      childWidget: Icon(
        Icons.description_outlined,
        color: Colors.blue,
        size: 30, // Increased icon size to match UI
      ),
    ),
    RequestCard(
      title: "Approved Request",
      count: 250,
      percentage: 20.0,
      isPositive: true,
      containerBgColor: Color(0xFFD1E8DC),
      gradientColor: LinearGradient(
        colors: [Color(0xFF08532F), Color(0xFF1FBD70)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      childWidget: Icon(
        Icons.verified,
        color: Colors.green,
        size: 30, // Increased icon size to match UI
      ),
    ),
    RequestCard(
      title: "Pending Request",
      count: 250,
      percentage: -20.0,
      isPositive: false,
      containerBgColor: Color(0xFFFFF3E0),
      gradientColor: LinearGradient(
        colors: [Color(0xFF91721E), Color(0xFFD19B06)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      childWidget: Icon(
        Icons.pending_actions_sharp,
        color: Colors.orange,
        size: 30, // Increased icon size to match UI
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
                      ? Colors.blue
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