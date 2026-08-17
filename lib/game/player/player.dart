import 'dart:ui';
import 'package:flame/components.dart';
import '../game_config.dart';
import 'player_controller.dart';

enum PlayerState { idle, running, jumping, falling, doubleJumping, dead }

class Player extends PositionComponent {
  Player({required this.controller}) : super(position: Vector2(140, GameConfig.floorY - 60), size: Vector2(44, 60));

  final PlayerController controller;
  PlayerState state = PlayerState.idle;
  double velocityY = 0;
  double coyote = 0;
  double jumpBuffer = 0;
  bool grounded = true;
  bool doubleJumpAvailable = true;

  @override
  void update(double dt) {
    super.update(dt);
    final axis = controller.horizontalAxis.toDouble();
    final target = axis * GameConfig.maxSpeed;
    final step = GameConfig.acceleration * dt;
    if ((velocity.x - target).abs() <= step) {
      velocity.x = target;
    } else {
      velocity.x += velocity.x < target ? step : -step;
    }

    if (controller.jumpQueued) {
      jumpBuffer = GameConfig.jumpBuffer;
      controller.jumpQueued = false;
    }
    jumpBuffer -= dt;
    coyote = grounded ? GameConfig.coyoteTime : coyote - dt;

    if (jumpBuffer > 0 && (grounded || coyote > 0 || doubleJumpAvailable)) {
      final doubleJump = !grounded && coyote <= 0;
      velocityY = -GameConfig.jumpSpeed;
      if (doubleJump) doubleJumpAvailable = false;
      grounded = false;
      jumpBuffer = 0;
      state = doubleJump ? PlayerState.doubleJumping : PlayerState.jumping;
    }

    velocityY += GameConfig.gravity * dt;
    position += Vector2(velocity.x * dt, velocityY * dt);

    if (position.y + size.y >= GameConfig.floorY) {
      position.y = GameConfig.floorY - size.y;
      velocityY = 0;
      if (!grounded) doubleJumpAvailable = true;
      grounded = true;
      state = axis == 0 ? PlayerState.idle : PlayerState.running;
    } else if (velocityY > 0) {
      state = PlayerState.falling;
    }
  }

  @override
  void render(Canvas canvas) {
    final body = Paint()..color = const Color(0xFFE85D75);
    final visor = Paint()..color = const Color(0xFF66E3FF);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(2, 8, size.x - 4, size.y - 8), const Radius.circular(13)), body);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(8, 17, size.x - 16, 17), const Radius.circular(7)), visor);
  }
}
