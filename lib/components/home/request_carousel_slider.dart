import 'package:admin_jantasewa/widgets/colors.dart';
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
    required this.childWidget,
    this.containerBgColor,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Determine the width based on screen size
    //double cardWidth = screenWidth < 600 ? 0 : 300; // Adjust
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight / 8,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12),
        gradient: gradientColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Container(

                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  
                  shape: BoxShape.circle,
                  color: containerBgColor,
                  border: Border.all(color: Colors.white,width: 2),
                  //borderRadius: BorderRadius.circular(100),
                ),
                child: childWidget??Text('Icons'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          Spacer(),
          Row(
            
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 16,
              ),
              Expanded(
                child: Text(
                  '${percentage.toStringAsFixed(1)} %',
                  style: TextStyle(
                    fontSize: 12,
                    
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
              ),
              Text(
                "All Request",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class RequestCarousel extends StatefulWidget {
  const RequestCarousel({super.key});

  @override
  State<RequestCarousel> createState() => _RequestCarouselState();
}

class _RequestCarouselState extends State<RequestCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  final List<RequestCard> cards = const [
    RequestCard(
      title: "New Request",
      count: 25,
      percentage: 2.0,
      isPositive: true,
      gradientColor: LinearGradient(
        colors: [Color(0xFF264D8E), Color(0xFF4285F4)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,

      ),
      childWidget: Icon(Icons.new_releases, color: Colors.white, size: 20),
    ),

    RequestCard(
      title: "Approved Request",
      count: 25,
      percentage: 12.0,
      isPositive: true,
      childWidget: Icon(Icons.request_quote, color: Colors.white, size: 20),
      gradientColor: LinearGradient(
        colors: [ Color(0xFF08532F), Color(0xFF1FBD70)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,

      ),
    ),
    RequestCard(
      title: "Pending Request",
      count: 12,
      percentage: 3.2,
      isPositive: true,
      childWidget: Icon(Icons.request_page, color: Colors.white, size: 20),
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
            height: 180,
            initialPage: 0,
            //autoPlay: true,
            //enlargeCenterPage: true,
            viewportFraction: 1,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            //autoPlay: true,
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
