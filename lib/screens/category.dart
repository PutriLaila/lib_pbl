import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Category extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool showBorder;
  final Color backgroundColor;

  const Category({
    Key? key,
    required this.imagePath,
    required this.title,
    this.showBorder = false,
    this.backgroundColor = const Color.fromRGBO(206, 222, 189, 5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: showBorder
          ? RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8.0),
            )
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
      color: backgroundColor,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: 60,
          height: 73,
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: 30,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(67, 83, 52, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
