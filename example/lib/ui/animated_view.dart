import 'package:example/ui/clippers/drow_cliperr.dart';
import 'package:flutter/material.dart';

class AnimatedView extends StatefulWidget {
  const AnimatedView({Key? key}) : super(key: key);

  @override
  _AnimatedViewState createState() => _AnimatedViewState();
}

class _AnimatedViewState extends State<AnimatedView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                // child: Container(
                //   height: size.height * 0.5,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment.bottomLeft,
                //       end: Alignment.bottomRight,
                //       colors: [
                //         Color(0xFFE0647B),
                //         Color(0xFFFCDD89),
                //       ],
                //     ),
                //   ),
                // ),
                builder: (context, child) {
                  return ClipPath(
                    clipper: DrowClipper(_controller.value),
                    child: Container(
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Color(0xFFE0647B), Color(0xFFFCDD89)]),
                      ),
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  'Peach',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 46,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Your money is safe',
                style: TextStyle(color: Colors.white),
              )
            ],
          )
        ],
      ),
    );
  }
}
