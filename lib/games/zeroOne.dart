import 'package:flutter/material.dart';
import '../style.dart';

class ZeroOne extends StatefulWidget {
  final String game;
  final List<String> players;

  const ZeroOne({super.key, required this.game, required this.players});

  @override
  State<ZeroOne> createState() => _ZeroOneState();
}

class _ZeroOneState extends State<ZeroOne> {
  void _shotRegiterer() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: List.generate(widget.players.length, (index) {
            return GestureDetector(
              onTap: () => {
                _shotRegiterer()
              },
              child: Container(
                  color: Styler.primaryLight,
                  child: Center(
                    child: Text(
                      widget.players[index],
                      style: TextStyle(
                        fontSize: 42,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w700,
                        color: Styler.primaryForeground,
                      ),
                    ),
                  )
              ),
            );
          })
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Styler.primaryForeground,
        onPressed: () {
          setState(() {

          });
        },
        child: const Icon(Icons.undo_outlined),
      ),
    );
  }
}