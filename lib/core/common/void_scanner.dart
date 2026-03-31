import 'package:flutter/material.dart';
import 'package:void_vault/core/theme/app_theme.dart';

class MinimalVoidScan extends StatefulWidget {
  const MinimalVoidScan({super.key});

  @override
  State<MinimalVoidScan> createState() => _MinimalVoidScanState();
}

class _MinimalVoidScanState extends State<MinimalVoidScan>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: double.infinity,
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return FractionalTranslation(
            translation: Offset(_animation.value, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primary.withOpacity(0),
                    AppTheme.primary,
                    AppTheme.primary.withOpacity(0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
