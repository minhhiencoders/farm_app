import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class ExtentionInfor extends StatefulWidget {
  const ExtentionInfor({
    super.key,
    required this.voidCallback,
  });
  final VoidCallback voidCallback;

  @override
  State<ExtentionInfor> createState() => _ExtentionInforState();
}

class _ExtentionInforState extends State<ExtentionInfor>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation _menuAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _menuAnimation = Tween(begin: 0.0, end: 25.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.50, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
          surfaceIntensity: 1,
          boxShape: NeumorphicBoxShape.circle(),
          depth: 1,
          intensity: 0.8,
          shape: NeumorphicShape.flat),
      child: NeumorphicButton(
        onPressed: () {
          // z.toggle!();
          widget.voidCallback();
        },
        style: const NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            color: Colors.white,
            depth: 10,
            intensity: 0.8,
            shape: NeumorphicShape.convex),
        child: Icon(
          Icons.question_answer,
          size: _menuAnimation.value,
        ),
      ),
    );
  }
}
