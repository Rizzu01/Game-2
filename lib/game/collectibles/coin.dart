import 'dart:ui';
import 'package:flame/components.dart';

class Coin extends PositionComponent {
  Coin({required super.position}) : super(size: Vector2.all(24));

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFFFD45A);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), 10, paint);
    final shine = Paint()..color = const Color(0xFFFFF1A6);
    canvas.drawCircle(Offset(size.x * .4, size.y * .35), 3, shine);
  }
}
