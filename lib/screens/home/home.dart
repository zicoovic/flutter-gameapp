import 'package:flutter/material.dart';

import 'package:flutter_masterclass/screens/home/character_card.dart';
import 'package:flutter_masterclass/services/character_store.dart';
import 'package:flutter_masterclass/shared/styled_button.dart';
import 'package:flutter_masterclass/shared/styled_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  @override
  void initState() {
    Provider.of<CharacterStore>(context, listen: false).fetchCharactersOnce();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Your Characters'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          // list of characters
          Expanded(
            child: Consumer<CharacterStore>(builder: (context, value, child) {
              return ListView.builder(
                  itemCount: value.characters.length,
                  itemBuilder: (_, index) {
                    return Dismissible(
                      key: Key(value.characters[index].id),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return Get.defaultDialog(
                            title: 'Delete Character',
                            middleText:
                                'Are you sure you want to delete ${value.characters[index].name}?',
                            textConfirm: 'Yes',
                            textCancel: 'No',
                            onConfirm: () {
                              Provider.of<CharacterStore>(context,
                                      listen: false)
                                  .removeCharacter(value.characters[index]);
                              Get.back();
                            },
                            onCancel: () => Get.back(),
                          );
                        }
                        return false;
                      },
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: CharacterCard(value.characters[index]),
                    );
                  });
            }),
          ),

          StyledButton(
            onPressed: () {
              // navigate to the create screen
              Get.toNamed('/create');
            },
            child: const StyledHeading('Create New'),
          ),
        ]),
      ),
    );
  }
}
