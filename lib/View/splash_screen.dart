import 'dart:async';

import 'package:covid_tracker/View/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _animeController = AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this,
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _animeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 4),
      (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const WorldState()));}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
              animation: _animeController,
              child: const Center(
                child: Image(image: AssetImage("images/virus.png"),),
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                  angle: _animeController.value * 2.0 * math.pi,
                  child: child,
                );
              }
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .09,
            ),
            Text("Covid-19\nTracker App",style: TextStyle(
              color: Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              shadows: [Shadow(
                color: Colors.grey.shade600,
                blurRadius: 2,
                offset: const Offset(3, 1)
              )]
            ),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}