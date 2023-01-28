import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TappableContainer extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final Color? color;
  final EdgeInsets padding;

  const TappableContainer({
    super.key,
    required this.onTap,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
	  final color = Theme.of(context).colorScheme.onBackground;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: padding,
        child: child,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.08),
              color.withOpacity(0.05),
            ],
          ),
        ),
      ),
    );
  }
}
