import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_farm_application/components/switch_page.dart';
import 'package:smart_farm_application/components/circle_button_widget.dart';
import 'package:smart_farm_application/model/drawer_item.dart';
import 'package:smart_farm_application/model/information.dart';
import 'package:smart_farm_application/utilities/drawer_list_utils.dart';
import 'package:smart_farm_application/utilities/size_utils.dart';
import 'package:smart_farm_application/view_models/auth_view_model.dart';

import '../../configs/contants.dart';
import '../../utilities/hive_utils.dart';
import '../../view_models/client_infor_view_model.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen>
    with SingleTickerProviderStateMixin {
  static const Duration _animationDuration = Duration(milliseconds: 400);
  static const double _maxScale = 0.85;
  static const double _maxSlide = 250.0;
  static const double _maxRadius = 20.0;

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _radiusAnimation;

  DrawerItem _currentItem = DrawerListItem.control;
  bool _isDrawerOpen = false;
  Widget _page = switchPage(DrawerListItem.control);

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _getClientInfo();
  }

  Future<void> _getClientInfo() async {
    await HiveUtils.getValue<Information?>(
            Contant.INFORMATION_LIST, Contant.INFORMATION)
        .then(
      (value) {
        if (value != null) {
          ref.read(clientInfoProvider.notifier).getClientInfo(
              value.authToken.toString(), value.clients.first.id ?? 1);
        }
      },
    );
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: _maxScale).animate(curvedAnimation);
    _slideAnimation =
        Tween<double>(begin: 0.0, end: _maxSlide).animate(curvedAnimation);
    _radiusAnimation =
        Tween<double>(begin: 0.0, end: _maxRadius).animate(curvedAnimation);
  }

  Future<void> _toggleDrawer() async {
    if (_isDrawerOpen) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
    setState(() => _isDrawerOpen = !_isDrawerOpen);
  }

  void _handleItemTap(DrawerItem item) {
    setState(() {
      _currentItem = item;
      _page = switchPage(item);
      _toggleDrawer().whenComplete(() {
        if (item == DrawerListItem.logout) {
          ref.read(authNotifierProvider.notifier).logout();
        }
      });
    });
  }

  Widget _buildDrawerHeader(SizeUtils size) {
    return DrawerHeader(
      padding: EdgeInsets.only(bottom: 5, left: size.sizeWidth * 0.2),
      curve: Curves.easeIn,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Lottie.asset('lib/assets/images/splash.json'),
          ),
          const SizedBox(height: 10),
          const Text(
            'Welcome Back',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(DrawerItem item) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      style: ListTileStyle.drawer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      selectedColor: Colors.white,
      child: ListTile(
        horizontalTitleGap: 10,
        selectedTileColor: Colors.black26,
        selected: item == _currentItem,
        minLeadingWidth: 40,
        title: Text(item.title),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(item.icon),
        ),
        onTap: () => _handleItemTap(item),
      ),
    );
  }

  Widget _buildDrawerContent(SizeUtils size) {
    return ListView(
      children: [
        _buildDrawerHeader(size),
        Padding(
          padding: EdgeInsets.only(left: 10, top: size.sizeHeight * 0.02),
          child: Column(
            children: DrawerListItem.screens.map(_buildDrawerItem).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: _buildMainScaffold(),
          ),
        );
      },
    );
  }

  Widget _buildMainScaffold() {
    return GestureDetector(
      onTap: _toggleDrawer,
      child: AbsorbPointer(
        absorbing: _isDrawerOpen,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(_radiusAnimation.value),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWidget(
                  voidCallback: _toggleDrawer,
                  icon: Icons.menu_rounded,
                ),
              ],
            ),
            body: AnimatedSwitcher(
              duration: _animationDuration,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: _page,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeUtils(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          _buildDrawerContent(size),
          _buildMainContent(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
