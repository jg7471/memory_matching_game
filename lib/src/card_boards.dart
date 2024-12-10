import 'package:flutter/material.dart';
import 'package:memory_matching_game/src/card.dart';

class CardBoards extends StatelessWidget {
  CardBoards({super.key});
  List<int> cards = [1, 5, 2, 6, 3, 4, 3, 2, 6, 1, 4, 5];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          for (var i = 0; i < cards.length; i++)
            CardWidget(
              cardNumber: cards[i],
            ),
        ],
      ),
    );
  }
}
