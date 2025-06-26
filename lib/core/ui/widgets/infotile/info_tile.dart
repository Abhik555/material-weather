import 'package:flutter/material.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({super.key, required this.items});

  final List<Widget> items;

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(16.0),
      margin: EdgeInsetsGeometry.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 58, 58, 58), width: 2.5),
        borderRadius: BorderRadius.circular(24.0),
        color: Color.fromARGB(255, 33, 33, 33),
      ),
      child: ClipRRect(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.items,
        ),
      ),
    );
  }
}
