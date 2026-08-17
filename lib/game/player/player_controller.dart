class PlayerController {
  bool left = false;
  bool right = false;
  bool jumpQueued = false;
  bool attackQueued = false;

  int get horizontalAxis => (right ? 1 : 0) - (left ? 1 : 0);
  void queueJump() => jumpQueued = true;
  void queueAttack() => attackQueued = true;
}
