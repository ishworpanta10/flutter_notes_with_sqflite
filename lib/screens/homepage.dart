import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    tiles = [
      StatelessColorful(
        key: UniqueKey(),
      ),
      StatelessColorful(
        key: UniqueKey(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // print(tiles.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: Row(
          children: tiles,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTiles,
        child: const Icon(Icons.sentiment_dissatisfied_sharp),
      ),
    );
  }

  void swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class UniqueColorGenaretor {
  static Color getColor() {
    // return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}

class StatelessColorful extends StatefulWidget {
  StatelessColorful({
    Key? key,
  }) : super(key: key);

  @override
  _StatelessColorfulState createState() => _StatelessColorfulState();
}

class _StatelessColorfulState extends State<StatelessColorful> {
  final Color color = UniqueColorGenaretor.getColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: color,
    );
  }
}
