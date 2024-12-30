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
          child: Image.network(
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW91bnRhaW5zfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60',
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1519681393784-d120267933ba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bW91bnRhaW5zfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60',
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
          child: Image.network(
            'https://picsum.photos/seed/32/600',
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
          child: Image.network(
            'https://picsum.photos/seed/32/600',
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
          child: Image.network(
            'https://picsum.photos/seed/32/600',
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
          child: Image.network(
            'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bW91bnRhaW5zfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60',
            width: 80,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91bnRhaW5zfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60',
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
          child: Image.network(
            'https://images.unsplash.com/photo-1445363692815-ebcd599f7621?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
            width: 120,
            height: 190,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1540390769625-2fc3f8b1d50c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjN8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://images.unsplash.com/photo-1443632864897-14973fa006cf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzJ8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
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
          child: Image.network(
            'https://images.unsplash.com/photo-1614597396930-cd6760b99f7c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzZ8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
            width: 120,
            height: 190,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://picsum.photos/seed/32/600',
            width: 120,
            height: 160,
            fit: BoxFit.cover,
          ),
        ),
    () => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://picsum.photos/seed/32/600',
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
