import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.textButton});
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [BoxShadow(offset: Offset(0.0, 0.0), blurRadius: 25)],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blue, Colors.purple],
          ),
        )
        // BoxDecoration(
        //     color: bgColorButton,
        //     borderRadius: BorderRadius.circular(12),
        //     border: Border.all(color: AppColors.bgBlack)),
        ,
        child: Center(
          child: Text(
            textButton,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ).animate(target: 1).fade(end: 0.8).scaleXY(end: 1.1),
        ),
      ),
    );
  }
}
