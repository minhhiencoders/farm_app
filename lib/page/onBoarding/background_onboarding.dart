import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BackGroundOnBoarding extends StatefulWidget {
  const BackGroundOnBoarding({super.key, this.isStopScrollView = false});
  final bool isStopScrollView;

  @override
  State<BackGroundOnBoarding> createState() => _BackGroundOnBoardingState();
}

class _BackGroundOnBoardingState extends State<BackGroundOnBoarding> {
  final ScrollController _scrollController = ScrollController();
  late Timer _scrollTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startReverseScroll();
    });
  }

  @override
  void didUpdateWidget(covariant BackGroundOnBoarding oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isStopScrollView != oldWidget.isStopScrollView) {
      _scrollTimer.cancel();
      // _scrollController.dispose();
    }
  }

  void _startReverseScroll() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (_scrollController.hasClients) {
        double currentScroll = _scrollController.offset;

        // Scroll upwards
        double nextScroll = currentScroll - 2.0;

        if (nextScroll <= 0) {
          // Reset to the bottom
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        } else {
          _scrollController.jumpTo(nextScroll);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  final List<Widget Function()> _imageBuilders = [
    () => ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(16),
          ),
          child: Image.asset(
            'lib/assets/images/image-1.jpg',
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/assets/images/image-2.jpg',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(16),
          ),
          child: Image.asset(
            'lib/assets/images/image-3.jpg',
            width: 100,
            height: 0,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(16),
          ),
          child: Image.asset(
            'lib/assets/images/image-4.jpg',
            width: 100,
            height: 0,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(16),
          ),
          child: Image.asset(
            'lib/assets/images/image-5.jpg',
            width: 100,
            height: 0,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(0),
          ),
          child: Image.asset(
            'lib/assets/images/image-6.jpg',
            width: 80,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/assets/images/image-7.jpg',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/assets/images/image-8.jpg',
            width: 120,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(0),
          ),
          child: Image.asset(
            'lib/assets/images/image-9.jpg',
            width: 120,
            height: 190,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/assets/images/image-10.jpg',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/assets/images/image-11.jpg',
            width: 120,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(0),
          ),
          child: Image.asset(
            'lib/assets/images/image-12.jpg',
            width: 120,
            height: 190,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/assets/images/image-13.jpg',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'lib/assets/images/image-14.jpg',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'lib/assets/images/image-15.jpg',
        width: 120,
        height: 160,
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: MasonryGridView.count(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          itemCount: _imageBuilders.length * 100, // Repeat items
          itemBuilder: (context, index) {
            final imageBuilder = _imageBuilders[index % _imageBuilders.length];
            return imageBuilder();
          },
        ),
      ),
    );
  }
}
