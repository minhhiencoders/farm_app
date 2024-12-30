import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:smart_farm_application/utilities/size_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final size = SizeUtils(context);
    return Scaffold(
      body: Column(
        children: [
          Neumorphic(
            style: const NeumorphicStyle(
                surfaceIntensity: 0.5,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 10,
                intensity: 0.8,
                shadowLightColor: Colors.brown,
                oppositeShadowLightSource: true,
                lightSource: LightSource.bottomRight,
                shape: NeumorphicShape.flat),
            child: NeumorphicButton(
              minDistance: -10,
              onPressed: () {},
              style: const NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  color: Colors.white,
                  depth: 10,
                  intensity: 0.8,
                  shape: NeumorphicShape.convex),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 30,
                color: Colors.black12,
              ),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.changpw,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size.titleFontSize),
          ),
          const SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.requireChangepw),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
