import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final int tryCount;
  final int score;
  final VoidCallback resetGame; //리셋 콜백 추가
  final int matchedCards;

  Header({
    super.key,
    this.tryCount = 0,
    this.score = 0,
    this.matchedCards = 0,
    required this.resetGame, //생성자에 required this.resetGame을 추가
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'score',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  letterSpacing: 0,
                  height: 0,
                ),
              ),
              Text(score.toString(),
                  style: TextStyle(
                      height: 0,
                      fontSize: 30,
                      letterSpacing: -2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'try count',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  letterSpacing: 0,
                  height: 0,
                ),
              ),
              Text(tryCount.toString(),
                  style: TextStyle(
                      height: 0,
                      fontSize: 30,
                      letterSpacing: -2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          )),
          Expanded(
            child: GestureDetector(
              //GestureDetector : 사용자 동작 감지 @@@
              onTap: resetGame, // 버튼 클릭 시 resetGame 호출
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xff94BEE5),
                ),
                child: const Center(
                  child: Text(
                    '새 게임',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
