import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixel_scan/features/home/application/bloc/home_bloc.dart';

class ScanFAB extends StatelessWidget {
  const ScanFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 68,
          width: 260,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        Container(
          height: 82,
          width: 82,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            color: Colors.red,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            onTap: () async {
              try {
                final images = await CunningDocumentScanner.getPictures();

                if (images != null && images.isNotEmpty) {
                  context.read<HomeBloc>().add(HomeEvent.addDocument(images));
                }
              } catch (e) {
                debugPrint('Ошибка сканера: $e');
              }
            },
            child: Center(
              child: SvgPicture.asset('assets/images/scan_button.svg'),
            ),
          ),
        ),
      ],
    );
  }
}
