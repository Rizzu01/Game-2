import 'dart:ui';
import 'package:flame/components.dart';

class PlatformBlock extends PositionComponent {
  PlatformBlock({required super.position, required super.size});

  @override
  void render(Canvas canvas) {
    final base = Paint()..color = const Color(0xFF263A58);
    final top = Paint()..color = const Color(0xFF58C7A8);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.x, size.y), const Radius.circular(7)), base);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.x, 7), const Radius.circular(4)), top);
  }
}
