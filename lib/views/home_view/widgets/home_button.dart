import 'package:barrier_free_life/constants/color.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.size,
    required this.icon,
    required this.callBack,
  });

  final Size size;
  final IconData icon;
  final Function() callBack;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: callBack,
        child: SizedBox(
          width: size.width,
          child: Icon(
            icon,
            color: colorYlw,
          ),
        ),
      ),
    );
  }
}
