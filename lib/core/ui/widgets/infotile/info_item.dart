import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InfoItem extends StatefulWidget {
  const InfoItem({
    super.key,
    required this.title,
    required this.data,
    required this.asset,
    required this.size,
  });

  final String title;
  final String data;
  final String asset;
  final double size;

  @override
  State<InfoItem> createState() => _InfoItemState();
}

class _InfoItemState extends State<InfoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsGeometry.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(widget.asset, width: widget.size, height: widget.size),
          Text(widget.data, style: Theme.of(context).textTheme.titleLarge),
          Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
