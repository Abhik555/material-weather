import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Locationtile extends StatefulWidget {
  const Locationtile({
    super.key,
    required this.name,
    required this.city,
    required this.onClick,
    required this.country,
    required this.countryCode,
  });

  final String name;
  final String city;
  final String country;
  final String countryCode;
  final GestureTapCallback onClick;
  @override
  State<Locationtile> createState() => _LocationtileState();
}

class _LocationtileState extends State<Locationtile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 58, 58, 58),
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(24.0),
          color: Color.fromARGB(255, 33, 33, 33),
        ),
        padding: EdgeInsetsGeometry.all(16.0),
        margin: EdgeInsetsGeometry.only(top: 8.0, bottom: 8.0),
        child: Wrap(
          children: [
            CountryFlag.fromCountryCode(widget.countryCode , shape: Circle(),),
            const SizedBox(width: 15),
            Text(
              "${widget.name}\n${widget.city}, ${widget.country}",
              style: GoogleFonts.delius().copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
