import 'package:flutter/material.dart';
import 'package:flutter_masterclass/models/character.dart';
import 'package:flutter_masterclass/shared/styled_text.dart';
import 'package:flutter_masterclass/theme.dart';
import 'package:get/get.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard(this.character, {super.key});

  final Character character;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to character profile screen
        Get.toNamed('/profile', arguments: widget.character);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(children: [
            Hero(
              tag: widget.character.id,
              child: Image.asset(
                  'assets/img/vocations/${widget.character.vocation.image}',
                  width: 80),
            ),
            const SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              StyledHeading(widget.character.name),
              StyledText(widget.character.vocation.title),
            ]),
            const Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.character.toggleIsFav();
                });
              },
              child: Icon(
                widget.character.isFav
                    ? Icons.favorite
                    : Icons.favorite_outline,
                color: AppColors.textColor,
              ),
            ),
            IconButton(
                onPressed: () {
                  // navigate to character profile screen
                  Get.toNamed('/profile', arguments: widget.character);
                },
                icon: Icon(Icons.arrow_forward, color: AppColors.textColor)),
          ]),
        ),
      ),
    );
  }
}
