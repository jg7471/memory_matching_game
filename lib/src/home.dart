import 'package:flutter/material.dart';
import 'package:memory_matching_game/src/card_boards.dart';
import 'package:memory_matching_game/src/header.dart';
import 'package:memory_matching_game/src/card_model.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tryCount = 0;
  int score = 0;
  List<CardModel> matchedCards = []; // 맞힌 카드 목록 추가

  void updateTryCount() {
    setState(() {
      tryCount++;
    });
  }

  void updateScore() {
    setState(() {
      score += 100; // 점수 증가
    });
  }

  void resetGame() {
    setState(() {
      tryCount = 0;
      score = 0;
      matchedCards.clear(); // 맞힌 카드 초기화
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECE7E4),
      appBar: AppBar(
        title: const Text('짝맞추기 게임'),
        backgroundColor: const Color(0xff92CBFF),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(
                tryCount: tryCount,
                score: score,
                resetGame: resetGame), //score 등록/전달@@@

            SizedBox(height: 20),
            Expanded(
              child: CardBoards(
                updateTryCount: updateTryCount,
                updateScore: updateScore, //cardBoards 점수 업데이트 호출@@@
                resetGame: resetGame,
                matchedCards: matchedCards, // 맞힌 카드 목록 전달
              ),
            ),
          ],
        ),
      ),
    );
  }
}
