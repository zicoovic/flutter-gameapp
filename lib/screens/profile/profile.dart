import 'package:flutter/material.dart';
import 'package:flutter_masterclass/models/character.dart';
import 'package:flutter_masterclass/screens/profile/heart.dart';
import 'package:flutter_masterclass/screens/profile/skill_list.dart';
import 'package:flutter_masterclass/screens/profile/stats_table.dart';
import 'package:flutter_masterclass/shared/styled_button.dart';
import 'package:flutter_masterclass/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../services/character_store.dart';
import '../../shared/styled_text.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.char});

  final Character char;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(char.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // basic information - image , vocation , desorption
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.secondaryColor.withOpacity(0.3),
                  child: Row(
                    children: [
                      Hero(
                        tag: char.id,
                        child: Image.asset(
                          'assets/img/vocations/${char.vocation.image}',
                          width: 140,
                          height: 140,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyledHeading(char.vocation.title),
                            StyledText(char.vocation.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Heart(character: char),
                ),
              ],
            ),

            // weapon and ability and slogan

            const SizedBox(
              height: 20,
            ),
            Center(
              child: Icon(
                Icons.code,
                color: AppColors.primaryColor,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: AppColors.secondaryColor.withOpacity(0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StyledHeading('Slogan'),
                    StyledText(char.slogan),
                    const SizedBox(height: 10),
                    const StyledHeading('Weapon'),
                    StyledText(char.vocation.weapon),
                    const SizedBox(height: 10),
                    const StyledHeading('Abilities'),
                    StyledText(char.vocation.ability),
                    const SizedBox(height: 10),
                    const StyledHeading('Desorption'),
                    StyledText(char.vocation.description),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            // stats , skills
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  StatsTable(char),
                  SkillList(char),
                ],
              ),
            ),
            // save button
            const SizedBox(height: 20),
            StyledButton(
              onPressed: () {
                Provider.of<CharacterStore>(context, listen: false)
                    .updateCharacter(char);
                Get.defaultDialog(
                  title: 'Character saved',
                  titleStyle: TextStyle(color: Theme.of(context).primaryColor),
                  content: const StyledText(
                      'Are you sure you want to save this character?'),
                  backgroundColor:
                      Theme.of(context).dialogTheme.backgroundColor,
                  confirm: StyledButton(
                    onPressed: () {
                      Get.showSnackbar(
                        const GetSnackBar(
                          shouldIconPulse: true,
                          isDismissible: true,
                          animationDuration: Duration(milliseconds: 300),
                          icon: Icon(Icons.check_circle, color: Colors.white),
                          duration: Duration(seconds: 3),
                          message: 'Character saved',
                          // snackPosition: SnackPosition.TOP,
                        ),
                      );
                      Get.offAllNamed('/home');
                    },
                    child: const StyledHeading('Ok'),
                  ),
                  cancel: StyledButton(
                    onPressed: () {
                      Get.showSnackbar(
                        const GetSnackBar(
                          shouldIconPulse: true,
                          isDismissible: true,
                          animationDuration: Duration(milliseconds: 300),
                          icon: Icon(Icons.close, color: Colors.white),
                          duration: Duration(seconds: 3),
                          message: 'Nothing changed',
                          // snackPosition: SnackPosition.TOP,
                        ),
                      );
                      Get.offAllNamed('/home');
                    },
                    child: const StyledHeading('Cancel'),
                  ),
                  cancelTextColor: AppColors.secondaryColor,
                  confirmTextColor: AppColors.secondaryColor,
                  radius: 10,
                  buttonColor: AppColors.primaryColor,
                );
              },
              child: const StyledHeading('Save character'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
