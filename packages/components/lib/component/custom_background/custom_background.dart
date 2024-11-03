import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: const Offset(-191, 0),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(19.74 / 360),
                child: Container(
                  height: 326,
                  width: 346.53,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: const Offset(-40, 110),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-32.12 / 360),
                child: Container(
                  height: 249.17,
                  width: 247.82,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: const Offset(30, 40),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-62.61 / 360),
                child: Container(
                  height: 95.17,
                  width: 106.34,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Transform.translate(
              offset: const Offset(85, -160),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-39.05 / 360),
                child: Container(
                  height: 114.87,
                  width: 114.99,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          child: Align(
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: const Offset(-118, 0),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-39.05 / 360),
                child: Container(
                  height: 190.68,
                  width: 169.29,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          child: Align(
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: const Offset(-150, 120),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-17.06 / 360),
                child: Container(
                  height: 190.68,
                  width: 189.89,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          child: Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: const Offset(120, 80),
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-45.46 / 360),
                child: Container(
                  height: 190.68,
                  width: 195.79,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



