import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_list.dart';
import 'package:guess_card_smaller_or_greater/card_model_and_list/card_model.dart';
import 'package:guess_card_smaller_or_greater/constants/assets.dart';
import 'package:lottie/lottie.dart';

class GameWithButton extends StatelessWidget {
  const GameWithButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 0, 67),
        foregroundColor: Colors.white,
        title: const Text('ကစားပွဲ'),
      ),
      body: const GameScreen(),
    );
  }
}

//********************* GameScreen Widget *************************************/

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  List<CardModel> card1 = [];
  List<CardModel> card2 = [];
  int point = 0;
  int winPoint = 2;

  List<String> preditButton = ['Smaller', 'Bigger', 'Equal'];
  bool enableButton = true;
  bool enableNextRound = false;

  late final myController = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this);
  late final myAnimation =
      Tween<double>(begin: 1, end: 0).animate(myController);

  final flipcardController = FlipCardController();
  GlobalKey<FlipCardState> cardkey = GlobalKey();

  late Timer time;
  int timeCount = 5;
  void startTimeCount() {
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeCount == 0) {
        time.cancel();
        timeCount = 5;
        point--;

        nextRound();
        startTimeCount();
        setState(() {});
      } else {
        timeCount--;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    card1.addAll(CardList().cardlist);
    card2.addAll(CardList().cardlist);
    card1.shuffle();
    card2.shuffle();

    myController.forward();

    timeCount = 6;

    startTimeCount();

    super.initState();
  }

  @override
  void dispose() {
    time.cancel();
    myController.dispose();
    super.dispose();
  }

  void checkCard(String s) {
    switch (s) {
      case 'Smaller':
        if (card1.first.number > card2.first.number) {
          point++;
        } else {
          point--;
        }
        break;
      case 'Bigger':
        if (card1.first.number < card2.first.number) {
          point++;
        } else {
          point--;
        }
        break;
      case 'Equal':
        if (card1.first.number == card2.first.number) {
          point++;
        } else {
          point--;
        }
        break;
      default:
    }
    if (point == winPoint) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            alignment: Alignment.center,
            content: SizedBox(
              width: 400,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'နိုင်ပြီ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 249, 150, 2),
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Lottie.asset(
                    'images/won_cup.json',
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'သင်အမှတ် $point မှတ်ရရှိပါသည်။',
                    style: const TextStyle(
                      height: 2,
                      color: Color.fromARGB(255, 2, 127, 229),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: const Color.fromARGB(255, 36, 1, 95),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  point = 0;
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'ထပ်ဆော့မည်',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: const Color.fromARGB(255, 36, 1, 95),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  exit(0);
                },
                child: const Text(
                  'ထွက်မည်',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
    setState(() {});
  }

  void nextRound() {
    if (!cardkey.currentState!.isFront) {
      cardkey.currentState!.flipCard();
    }
    if (myAnimation.status == AnimationStatus.completed) {
      myController.reset();
    }

    myController.forward();
    enableButton = true;
    enableNextRound = false;
    setState(() {});
    card1.shuffle();
    card2.shuffle();
  }

//*****************************************************************************/
  @override
  Widget build(BuildContext context) {
    String s = ModalRoute.of(context)!.settings.arguments as String;
    winPoint = int.parse(s);
    Size size = MediaQuery.of(context).size;
    double high = size.height;
    double width = size.width;
    return Container(
      color: Colors.pink.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '$winPoint မှတ်ရလျှင်၊ သင်နိုင်ပြီ။',
            style: const TextStyle(fontSize: 25),
          ),
          Text(
            'သင့်ရမှတ်     $point',
            style: const TextStyle(
              color: Color.fromARGB(255, 12, 0, 67),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 20, 1, 105),
                  width: 5,
                  strokeAlign: BorderSide.strokeAlignOutside),
            ),
            width: width * 0.9,
            height: high * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width * 0.45,
                  height: high * 0.1,
                  color: const Color.fromARGB(255, 20, 1, 105),
                  child: const Text(
                    'လက်ကျန်ချိန်',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.amber.withOpacity(0.2),
                  width: width * 0.45,
                  height: high * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        color: Color.fromARGB(255, 180, 12, 0),
                        Icons.timelapse,
                        size: 50,
                      ),
                      Text(
                        '00:0$timeCount',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 180, 12, 0),
                          fontSize: 40,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedBuilder(
                animation: myAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: -myAnimation.value * 1,
                    origin: const Offset(-200, 200),
                    // offset: Offset(-myAnimation.value * 250, 0),
                    child: SizedBox(
                      width: 180,
                      height: 300,
                      child: Image.asset(card1.first.image),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: myAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(myAnimation.value * 400, 0),
                    child: SizedBox(
                      width: 180,
                      height: 300,
                      child: FlipCard(
                        key: cardkey,
                        backWidget: Image.asset(card2.first.image),
                        frontWidget: Image.asset(Assets.assetsBack),
                        controller: flipcardController,
                        rotateSide: RotateSide.bottom,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 3; i++)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: enableButton
                      ? () {
                          timeCount = 0;
                          time.cancel();
                          checkCard(preditButton[i]);
                          cardkey.currentState!.flipCard();
                          enableButton = false;
                          enableNextRound = true;
                          setState(() {});
                        }
                      : null,
                  child: Text(
                    preditButton[i],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: enableNextRound
                ? () {
                    timeCount = 5;
                    nextRound();
                    startTimeCount();
                  }
                : null,
            child: const Text(
              'နောက်ပွဲ',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
