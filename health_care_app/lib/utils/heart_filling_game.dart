import 'package:flutter/material.dart';

class HeartFillingGame extends StatefulWidget {
  @override
  _HeartFillingGameState createState() => _HeartFillingGameState();
}

class _HeartFillingGameState extends State<HeartFillingGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _fillPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fillHeart() {
    setState(() {
      if (_fillPercentage < 100) {
        _fillPercentage += 5;
        _controller.forward(from: 0); // Trigger animation
        print("this is fill: " + _fillPercentage.toString());
      }
      if (_fillPercentage >= 50) {
        print("what is this : " + _fillPercentage.toString());
        // Show congratulatory message
        // You can use a Flutter toast or showDialog to display messages
      } else {
        // Show exercise reminder
        // You can use a Flutter toast or showDialog to display messages
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/heart.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () => _fillHeart(),
              child: Text('Tap here'),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () => _fillHeart(),
              child: Text('Tap here'),
            ),
          ),
        ],
      ),
    );
  }
}
