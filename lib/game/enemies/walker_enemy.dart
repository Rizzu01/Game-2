import 'dart:ui';
import 'package:flame/components.dart';

class WalkerEnemy extends PositionComponent {
  WalkerEnemy({required super.position}) : super(size: Vector2(42, 38));
  double direction = -1;
  double speed = 70;

  @override
  void update(double dt) {
    super.update(dt);
    position.x += direction * speed * dt;
    if (position.x < 40 || position.x > 3000) direction *= -1;
  }

  @override
  void render(Canvas canvas) {
    final body = Paint()..color = const Color(0xFF8C6BE8);
    final eye = Paint()..color = const Color(0xFFFFE66D);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(2, 5, size.x - 4, size.y - 5), const Radius.circular(12)), body);
    canvas.drawCircle(Offset(13, 16), 4, eye);
    canvas.drawCircle(Offset(29, 16), 4, eye);
  }
}
