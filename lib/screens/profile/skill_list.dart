import 'package:flutter/material.dart';
import 'package:flutter_masterclass/models/character.dart';
import 'package:flutter_masterclass/shared/styled_text.dart';
import 'package:flutter_masterclass/theme.dart';

import '../../models/skill.dart';

class SkillList extends StatefulWidget {
  const SkillList(this.character, {super.key});

  final Character character;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  late List<Skill> availableSkills;
  late Skill selectedSkill;

  @override
  void initState() {
    availableSkills = allSkills.where((skill) {
      return skill.vocation == widget.character.vocation;
    }).toList();

    if (widget.character.skills.isEmpty) {
      selectedSkill = availableSkills[0];
    }

    if (widget.character.skills.isNotEmpty) {
      selectedSkill = widget.character.skills.first;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.secondaryColor.withOpacity(0.5),
        child: Column(
          children: [
            const StyledHeading('Choose an active skill'),
            const StyledText('skill are unique to your vocation'),
            const SizedBox(height: 20),
            Row(
              children: availableSkills
                  .map((skill) => Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.character.updateSkills(skill);
                              selectedSkill = skill;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: skill == selectedSkill
                                  ? AppColors.highlightColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(2),
                            child: Image.asset(
                              'assets/img/skills/${skill.image}',
                              width: 70,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            StyledHeading(selectedSkill.name),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}