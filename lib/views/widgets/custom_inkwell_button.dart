import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInkwellButton extends StatelessWidget {
  final Widget nextPage;
  final String buttonText;

  const CustomInkwellButton({
    super.key,
    required this.nextPage,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => nextPage,
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 100,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
