import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralButton extends StatefulWidget {
  const GeneralButton({super.key, required this.title, required this.onClick});

  final String title;
  final GestureTapCallback onClick;

  @override
  State<GeneralButton> createState() => _GeneralButtonState();
}

class _GeneralButtonState extends State<GeneralButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        margin: EdgeInsetsGeometry.all(16.0),
        padding: EdgeInsetsGeometry.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: GoogleFonts.delius().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
