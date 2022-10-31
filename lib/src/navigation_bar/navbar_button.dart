import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NavBarButton extends HookConsumerWidget {
  /* Utilizo el HookConsumerWidget para no cambiar a un statefullwidget
  a su vez HookConsumerWidget sigue siendo un StatelessWidget */
  final String text;
  final VoidCallback ontap;

  const NavBarButton(
      {Key? key,
      // required this.ontap,
      required this.text,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = useState<Color>(Colors.black);
    return MouseRegion(
      onEnter: (value) {
        textColor.value = Colors.blue;
      },
      onExit: (value) {
        textColor.value = Colors.black;
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor.value),
            ),
          ),
        ),
      ),
    );
  }
}
