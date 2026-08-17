enum GameMode { loading, menu, playing, paused, playerDead, levelComplete, gameOver, bossFight, victory }

class GameState {
  GameMode mode = GameMode.loading;
  int level = 0;
  int coins = 0;
  int score = 0;
  int health = 3;
  double elapsed = 0;

  void startRun() {
    mode = GameMode.playing;
    coins = 0;
    score = 0;
    health = 3;
    elapsed = 0;
  }
}
