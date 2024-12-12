import 'package:flutter/material.dart';
import 'package:memory_matching_game/src/card.dart';

// 카드보드 위젯: 상태를 가지는 위젯으로, 게임 보드를 나타냅니다.
class CardBoards extends StatefulWidget {
  final Function() updateTryCount;
  CardBoards({super.key, required this.updateTryCount});

  @override
  State<CardBoards> createState() => _CardBoardsState(); //추상 메서드
}

class _CardBoardsState extends State<CardBoards> {
  // 카드의 번호를 나타내는 리스트 (게임의 카드 구성)
  List<int> cards = [1, 5, 2, 6, 3, 4, 3, 2, 6, 1, 4, 5];

  // 각 카드의 뒤집힘 상태를 저장하는 불리언 리스트
  List<bool> cardsFlippedState = [
    //generic bool타입 그룹
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  int instantFirstCard = -1; //선택되지 않음을 의미

  // 카드 클릭 시 호출되는 함수
  void onTapCard(int cardIndex) {
    print('$cardIndex 번째 카드를 선택하셨습니다.');
    if (instantFirstCard == -1) {
      instantFirstCard = cardIndex;
    } else {
      // 두번째 카드가 선택되었을때 로직 추가
      widget.updateTryCount(); // 추가 : widget 연결고리
      var firstCard = cards[instantFirstCard];
      var secondCard = cards[cardIndex];
      if (firstCard == secondCard) {
        print('짝이 맞았습니다.');
        instantFirstCard = -1;
      } else {
        resetInstantCards(instantFirstCard, cardIndex);
      }
    }
    setState(() {
      cardsFlippedState[cardIndex] = true;
    });
  }

  void resetInstantCards(int firstIndex, int secondIndex) async {
    await Future.delayed(Duration(seconds: 2)); // 추가
    setState(() {
      cardsFlippedState[firstIndex] = false;
      cardsFlippedState[secondIndex] = false;
    });
    instantFirstCard = -1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // 화면을 스크롤 가능하도록 감싸는 위젯
      child: Wrap(
        // 카드 배치를 담당하는 Wrap 위젯
        spacing: 4, // 카드 간의 가로 간격
        runSpacing: 4, // 카드 간의 세로 간격
        children: [
          // 카드 리스트를 반복문으로 생성
          for (var i = 0; i < cards.length; i++)
            CardWidget(
              cardNumber: cards[i], // 카드 번호 전달
              isFlipped: cardsFlippedState[i], // 현재 카드의 뒤집힘 상태 전달
              onTap: () {
                // 카드 클릭 시 실행할 함수
                onTapCard(i); // 클릭된 카드의 인덱스를 전달
              },
            ),
        ],
      ),
    );
  }
}
