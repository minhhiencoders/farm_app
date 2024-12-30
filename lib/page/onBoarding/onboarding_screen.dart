import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:smart_farm_application/utilities/size_utils.dart';
import 'background_onboarding.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final BoxController _boxController = BoxController();
  final ScrollController _scrollController = ScrollController();
  bool _isStopScrollView = false;

  void _handleBoxOpen() {
    setState(() {
      _isStopScrollView = true;
    });
  }

  void _handleBoxClose() {
    _boxController.openBox();
  }

  void _handleTap() {
    if (!_isStopScrollView) {
      setState(() {
        _isStopScrollView = true;
        _boxController.openBox();
      });
    }
  }

  @override
  void dispose() {
    _boxController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeUtils(context);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: SlidingBox(
            controller: _boxController,
            onBoxClose: _handleBoxClose,
            onBoxOpen: _handleBoxOpen,
            color: Colors.white,
            style: BoxStyle.shadow,
            draggableIconBackColor: Colors.transparent,
            minHeight: size.sizeHeight * 0.2,
            maxHeight: _isStopScrollView
                ? size.sizeHeight * 0.65
                : size.sizeHeight * 0.2,
            backdrop: Backdrop(
              body: BackGroundOnBoarding(isStopScrollView: _isStopScrollView),
            ),
            collapsed: true,
            body: _buildBoxContent(size),
          ),
        ),
      ),
    );
  }

  Widget _buildBoxContent(SizeUtils size) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGreetingHeader(size),
          _buildLoginSection(),
        ],
      ),
    );
  }

  Widget _buildGreetingHeader(SizeUtils size) {
    return Container(
      alignment: Alignment.center,
      height: size.sizeHeight * 0.15,
      child: Text(
        AppLocalizations.of(context)!.greeting,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: size.titleFontSize,
        ),
      ),
    );
  }

  Widget _buildLoginSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: LoginScreen(),
    );
  }
}
