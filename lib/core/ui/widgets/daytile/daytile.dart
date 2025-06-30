import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../models/weather.dart';

class DayTile extends StatefulWidget {
  const DayTile({
    super.key,
    required this.daydate,
    required this.max,
    required this.min,
    required this.weathercode,
    required this.unit,
  });

  final String daydate;
  final double max;
  final double min;
  final int weathercode;
  final String unit;
  @override
  State<DayTile> createState() => _DayTileState();
}

class _DayTileState extends State<DayTile> {
  @override
  Widget build(BuildContext context) {
    final day = DateFormat('EEEE').format(DateTime.parse(widget.daydate));

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 58, 58, 58), width: 2.5),
        borderRadius: BorderRadius.circular(24.0),
        color: Color.fromARGB(255, 33, 33, 33),
      ),
      padding: EdgeInsetsGeometry.all(16.0),
      margin: EdgeInsetsGeometry.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: GoogleFonts.delius().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Max: ${widget.max}${widget.unit} \nMin: ${widget.min}${widget.unit}",
                style: GoogleFonts.delius().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          Lottie.asset(ICONMAP[widget.weathercode]!, height: 80, width: 80),
        ],
      ),
    );
  }
}
