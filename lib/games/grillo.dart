import 'dart:io';

import 'package:flutter/material.dart';
import '../style.dart';

class GrilloGame extends StatefulWidget {
  final String game;
  final List<String> players;

  const GrilloGame({super.key, required this.game, required this.players});

  @override
  State<GrilloGame> createState() => _GrilloGameState();
}

class _GrilloGameState extends State<GrilloGame> {
  double headerHeight = 50;
  double mainRowWidht = 80;

  void _shotRegiterer() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox( width: mainRowWidht, height: headerHeight,),
              Expanded(child: Row( // header
                    children: List.generate(widget.players.length, (index) {
                      return Expanded(child: SizedBox(
                        height: headerHeight,
                        child: Container(
                          color: Styler.primary,
                          child: Center(
                            child: Text(
                              widget.players[index],
                              style: TextStyle(
                                  color: Styler.primaryForeground,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Oswald'
                              ),
                            ),
                          )
                        ),
                      ));
                    })
                ),
              )
            ],
          ),
          Row( // main column
              children: [
                Expanded(child: Column(
                  children: [

                  ],
                )),
                Container() // Aquí les puntuacions en grid
              ]
          )
        ],
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