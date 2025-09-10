import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onSearchPressed;

  // style params (tweak as you like)
  final Color fieldBgColor; // input bg
  final Color borderColor; // light grey border
  final Color hintColor; // placeholder
  final Color textColor; // input text
  final Color buttonColor; // purple circle
  final Color iconColor; // search icon in circle
  final double height;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.hint = 'Search…',
    this.onChanged,
    this.onClear,
    this.onSearchPressed,
    this.fieldBgColor = Colors.white,
    this.borderColor = const Color(0xFFD9D9D9), // #D9D9D9
    this.hintColor = const Color(0xFF9CA3AF),
    this.textColor = const Color(0xFF111827),
    this.buttonColor = const Color(0xFF3F3270), // brand purple
    this.iconColor = Colors.white,
    this.height = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // pill input
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: fieldBgColor,
              borderRadius: BorderRadius.circular(height), // pill
              border: Border.all(color: borderColor.withOpacity(0.8)),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.03),
              //     blurRadius: 4,
              //     offset: const Offset(0, 2),
              //   ),
              // ],
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 18, color: Color(0xFF8B8B8B)),
                  const SizedBox(width: 8),
                  // TextField + live clear button (no Stateful needed)
                  Expanded(
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller,
                      builder: (context, value, _) {
                        final hasText = value.text.isNotEmpty;
                        return TextField(
                          controller: controller,
                          onChanged: onChanged,
                          style: TextStyle(color: textColor, fontSize: 14),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: hint,
                            hintStyle: TextStyle(color: hintColor),
                            border: InputBorder.none,
                            suffixIcon: hasText
                                ? GestureDetector(
                                    onTap: () {
                                      controller.clear();
                                      onClear?.call();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                  )
                                : null,
                            suffixIconConstraints: const BoxConstraints(
                              minWidth: 24,
                              minHeight: 24,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // round action button
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap:
              onSearchPressed ??
              () {
                // default behavior: trigger onChanged with current text
                onChanged?.call(controller.text);
              },
          child: Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
              color: buttonColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: buttonColor.withOpacity(0.35),
                  //blurRadius: 10,
                  // offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.search, color: iconColor, size: 20),
          ),
        ),
      ],
    );
  }
}
