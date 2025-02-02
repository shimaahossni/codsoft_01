// features/home/persentation/widget/button_custom.dart
import 'package:flutter/material.dart';

@immutable
class ButtonCustom extends StatefulWidget {
  void Function()? onPressed;
  Widget? icon;
  ButtonCustom({super.key, required this.onPressed, required this.icon});

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade700, // Background color
        borderRadius: BorderRadius.circular(8),
        // Slightly rounded corners
      ),
      child: IconButton(
        onPressed: widget.onPressed,
        icon: widget.icon ??
            const Icon(
              Icons.refresh_rounded,
              color: Colors.white,
              size: 30,
            ),
      ),
    );
  }
}
