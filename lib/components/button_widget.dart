import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.title,
      this.colorTitle,
      this.icon,
      required this.color,
      required this.onTap});
  final String title;
  final Color? colorTitle;
  final Widget? icon;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.fromLTRB(0, size.height * 0.05, 0, 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return color.withOpacity(0.5);
              }
              return color;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Colors.white)),
          ),
        ),
        child: icon == null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (rect) => icon.toString().isNotEmpty
                      ? const LinearGradient(
                              colors: [Colors.white, Colors.white12],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.mirror)
                          .createShader(rect)
                      : LinearGradient(
                              colors: [colorTitle!, colorTitle!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.mirror)
                          .createShader(rect),
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                        fontFamily: 'Roboto'),
                  ),
                ),
              )
            : ListTile(
                leading: icon,
                title: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (rect) => icon.toString().isNotEmpty
                      ? const LinearGradient(
                              colors: [Colors.white, Colors.white12],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.mirror)
                          .createShader(rect)
                      : LinearGradient(
                              colors: [colorTitle!, colorTitle!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              tileMode: TileMode.mirror)
                          .createShader(rect),
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                        fontFamily: 'Roboto'),
                  ),
                ),
              ),
      ),
    );
  }
}
