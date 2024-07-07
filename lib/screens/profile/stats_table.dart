import 'package:flutter/material.dart';

import 'package:flutter_masterclass/models/character.dart';
import 'package:flutter_masterclass/theme.dart';

import '../../shared/styled_text.dart';

class StatsTable extends StatefulWidget {
  const StatsTable(
    this.character, {
    Key? key,
  }) : super(key: key);

  final Character character;

  @override
  State<StatsTable> createState() => _StatsTableState();
}

class _StatsTableState extends State<StatsTable> {
  double turns = 0.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // available  points
          Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.secondaryColor,
            child: Row(
              children: [
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.star,
                    color: widget.character.points > 0
                        ? AppColors.highlightColor
                        : AppColors.textColor,
                  ),
                ),
                const SizedBox(width: 20),
                const StyledText('stats points available : '),
                const Expanded(child: SizedBox(width: 20)),
                StyledHeading(widget.character.points.toString()),
              ],
            ),
          ),
          // stats table
          Table(
            children: widget.character.statsAsFormattedList.map((stats) {
              return TableRow(
                decoration: BoxDecoration(),
                children: [
                  TableCell(
                    // stats title
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: StyledHeading(stats['title']!),
                    ),
                  ),
                  TableCell(
                    // stats value
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: StyledHeading(stats['value']!),
                    ),
                  ),
                  // icon to increase stats
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.character.increaseStat(stats['title']!);
                          turns += 0.5;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_upward,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  // icon to decrease stats
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.character.decreaseStat(stats['title']!);
                          turns -= 0.5;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_downward,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
