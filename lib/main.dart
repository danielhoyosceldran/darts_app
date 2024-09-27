import 'package:flutter/material.dart';
import 'games/grillo.dart';
import 'games/zeroOne.dart';
import 'style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Darts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Styler.primary),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Darts'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> games = ["Grillo", "501", "301"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        foregroundColor: Styler.primaryForeground,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: games.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(games[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailPage(game: games[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GameDetailPage extends StatefulWidget {
  const GameDetailPage({super.key, required this.game});

  final String game;

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  List<String> players = ["Eneko", "Dani"];

  void _addItem() {
    if (players.length >= 4) {
      _message(context, "Ya no se pueden añadir más jugadores");
      return;
    }

    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusNode.requestFocus();
        });

        return AlertDialog(
          title: const Text('Añadir un/a jugador/a'),
          content: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(hintText: "Nombre del jugador/a:"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    players.add(controller.text);
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Añadir'),
            ),
          ],
        );
      },
    );
  }

  void _editPlayer(int index) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusNode.requestFocus();
        });
        return AlertDialog(
          title: const Text('Editar jugador/a'),
          content: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(hintText: "Nuevo nombre"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    players[index] = controller.text;
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _message(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Styler.secondaryForeground,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Styler.secondary,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.game),
        foregroundColor: Styler.primaryForeground,
      ),
      body: ListView.builder(
        itemCount: players.length + 1,
        itemBuilder: (context, index) {
          if (index == players.length) {
            return ListTile(
              title: const Text('Añadir jugador'),
              leading: const Icon(Icons.add),
              onTap: _addItem,
            );
          } else {
            return ListTile(
              title: Text(players[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _editPlayer(index);
                      });
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        players.remove(players[index]);
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          if (players.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (widget.game == "Grillo")
                    ? GrilloGame(game: widget.game, players: players)
                    : ZeroOne(game: widget.game, players: players),
              ),
            );
          } else {
            _message(context, "Añade almenos un/a jugador/a");
          }
        },
        foregroundColor: Styler.primaryForeground,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}




