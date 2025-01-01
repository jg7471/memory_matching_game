import 'package:flutter/material.dart';
import 'package:memory_matching_game/src/card.dart';
import 'package:memory_matching_game/src/card_model.dart';

// 카드보드 위젯: 상태를 가지는 위젯으로, 게임 보드를 나타냅니다.
class CardBoards extends StatefulWidget {
  final Function() updateTryCount;
  final Function() updateScore;
  final Function() resetGame;
  final List<CardModel> matchedCards; // 맞힌 카드 목록 추가

  CardBoards({
    super.key,
    required this.updateTryCount,
    required this.updateScore, //점수 업데이트 추가@@@
    required this.resetGame, //초기화 추가@@@
    required this.matchedCards, // matchedCards 전달
  });

  @override
  State<CardBoards> createState() => _CardBoardsState(); //추상 메서드
}

//*카드 리스트 초기화/관리
class _CardBoardsState extends State<CardBoards> {
  late List<CardModel> cards;
  CardModel? instantFirstCard; //선택되지 않음을 의미

  @override
  //상태 초기화
  void initState() {
    super.initState();
    List<int> cardsValue = [1, 5, 2, 6, 3, 4, 3, 2, 6, 1, 4, 5];
    cardsValue.shuffle();
    cards = List.generate(cardsValue.length, (index) {
      return CardModel(index: index, cardValue: cardsValue[index]);
    });
  }

  // 카드 클릭 시 호출되는 함수
  void onTapCard(int cardIndex) {
    print('$cardIndex 번째 카드를 선택하셨습니다.');
    //null 체크
    if (instantFirstCard == null) {
      instantFirstCard = cards[cardIndex];
    } else {
      // 두번째 카드가 선택되었을때 로직 추가
      widget.updateTryCount(); //힌트 : updateTryCount 부모(home)로 전달되었음(카드 시도 횟수)
      var firstCard = instantFirstCard;
      var secondCard = cards[cardIndex];
      if (firstCard!.cardValue == secondCard.cardValue) {
        print('짝이 맞았습니다.'); //힌트 : 부모한테 이벤트를 전달해라
        widget.updateScore(); //점수 업데이트@@@
        widget.matchedCards.add(firstCard); // 맞힌 카드 리스트에 추가
        widget.matchedCards.add(secondCard); // 맞힌 카드 리스트에 추가
        instantFirstCard = null;
      } else {
        resetInstantCards(instantFirstCard!, secondCard); //!강체 추출 null없으니까!
      }
    }
    //카드가 뒤집히거나 원래 상태로 복구될 때
    setState(() {
      cards[cardIndex].setFlipped(true);
    });
  }

  void resetInstantCards(CardModel firstCard, CardModel secondCard) async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      firstCard.setFlipped(false);
      secondCard.setFlipped(false);
    });
    instantFirstCard = null;
    return;
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
              card: cards[i],
              onTap: () {
                onTapCard(i);
              },
            ),
        ],
      ),
    );
  }
}
