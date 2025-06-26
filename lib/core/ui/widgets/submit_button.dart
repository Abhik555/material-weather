import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({super.key , required this.onClick});

  final GestureTapCallback onClick;

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
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
            "Search",
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
