import 'package:flutter/material.dart';
import 'package:flutter_masterclass/models/character.dart';

import '../../theme.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.character});
  final Character character;
  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _sizeAnimation = TweenSequence(
      [
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 25, end: 40),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 40, end: 25),
          weight: 50,
        ),
      ],
    ).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IconButton(
          onPressed: () {
            setState(() {
              _controller.reset();
              _controller.forward();
              widget.character.toggleIsFav();
            });
          },
          icon: Icon(
            Icons.favorite,
            color: widget.character.isFav
                ? AppColors.primaryColor
                : AppColors.textColor,
            size: _sizeAnimation.value,
          ),
        );
      },
    );
  }
}
