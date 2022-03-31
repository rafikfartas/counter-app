import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Color? borderColor;
  final VoidCallback onTap;
  final Color? color;
  final String text;
  final Color? textColor;
  final double? opacity;

  const CircleButton({
    Key? key,
    this.borderColor,
    required this.onTap,
    this.color,
    this.text = '',
    this.textColor,
    this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity ?? 1,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            width: 2,
            color: (borderColor ?? Theme.of(context).primaryColor)
                .withOpacity(0.25),
          ),
        ),
        child: Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onTap,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    (color ?? Theme.of(context).primaryColor).withOpacity(0.25),
              ),
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: textColor ?? Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
