import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() => runApp(const PixelQuestApp());

class PixelQuestApp extends StatelessWidget {
  const PixelQuestApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pixel Quest: Shadow Runner',
        theme: ThemeData.dark(useMaterial3: true),
        home: const MainMenu(),
      );
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0B1020), Color(0xFF17304A)],
            ),
          ),
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('PIXEL QUEST', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, letterSpacing: 4)),
              const Text('SHADOW RUNNER', style: TextStyle(color: Color(0xFF66E3FF), letterSpacing: 3, fontWeight: FontWeight.bold)),
              const SizedBox(height: 36),
              FilledButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GamePage())),
                child: const Text('PLAY'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(onPressed: () {}, child: const Text('LEVELS')),
              const SizedBox(height: 10),
              OutlinedButton(onPressed: () {}, child: const Text('SETTINGS')),
            ]),
          ),
        ),
      );
}

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GameWidget(game: PixelQuestGame()),
      );
}

class PixelQuestGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF0D1526);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}
