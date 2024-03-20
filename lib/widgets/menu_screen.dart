import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/constants/assets.dart';
import 'package:guess_card_smaller_or_greater/widgets/second_page.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late final myController = AnimationController(
    duration: Duration(seconds: 1),
    vsync: this,
  );
  late Animation animation;
  @override
  void initState() {
    animation = Tween<double>(begin: 0.0, end: 1).animate(
      myController,
    );
    myController.forward();
    myController.addListener(() {
      if (animation.status == AnimationStatus.completed) {
        myController.reverse();
      }
      if (animation.status == AnimationStatus.dismissed) {
        myController.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber, Colors.orange, Colors.red],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                AnimatedBuilder(
                  animation: animation,
                  builder: (_, __) {
                    return Transform.rotate(
                      angle: animation.value * 0.7,
                      origin: Offset(0, 200),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(94, 255, 157, 0),
                              offset: Offset.zero,
                              blurRadius: 50,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          Assets.assetsJack,
                          width: 200,
                          height: 400,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: animation.value * 0.3,
                        origin: Offset(0, 200),
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(94, 255, 157, 0),
                                offset: Offset.zero,
                                blurRadius: 50,
                                // spreadRadius: 100,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            Assets.assetsJoker,
                            width: 200,
                            height: 400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: -animation.value * 0.15,
                        origin: Offset(-0, 200),
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(94, 255, 157, 0),
                                offset: Offset.zero,
                                blurRadius: 50,
                                // spreadRadius: 100,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            Assets.assetsQueen,
                            width: 200,
                            height: 400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  child: AnimatedBuilder(
                    animation: animation,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: -animation.value * 0.7,
                        origin: Offset(-0, 200),
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(94, 255, 157, 0),
                                offset: Offset.zero,
                                blurRadius: 50,
                                // spreadRadius: 100,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            Assets.assetsKing,
                            width: 200,
                            height: 400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.5),
                padding: const EdgeInsets.all(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SecondPage(),
                  ),
                );
              },
              child: const Text(
                'PLAY',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
