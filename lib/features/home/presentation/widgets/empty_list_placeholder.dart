import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/nothing.png'),
            const Gap(16),
            const Text(
              'No documents found',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Gap(8),
            const Text(
              'Tap the button below to scan\nor convert to PDF',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff7D7D7D)),
            ),
          ],
        ),
      ),
    );
  }
}
