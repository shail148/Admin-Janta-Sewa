import 'package:admin_jantasewa/constants/colors.dart';
import 'package:flutter/material.dart';

class TopTabs extends StatelessWidget {
  const TopTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(color: AppColors.border),
        ),
        child: TabBar(
          dividerColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          labelPadding: EdgeInsets.zero,
          labelColor: Colors.white,
        //  unselectedLabelColor: AppColors.primaryText,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          indicator: ShapeDecoration(
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          indicatorPadding: const EdgeInsets.all(4),
          tabs: const [
            _SegmentTab('Banner'),
            _SegmentTab('Speeches'),
            _SegmentTab('Gallery'),
          ],
        ),
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  final String text;
  const _SegmentTab(this.text);

  @override
  Widget build(BuildContext context) {
    return Tab(height: 40, child: Center(child: Text(text)));
  }
}
