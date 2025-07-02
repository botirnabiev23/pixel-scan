import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_scan/features/home/application/bloc/home_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pixel_scan/features/home/presentation/widgets/document_list.dart';
import 'package:pixel_scan/features/home/presentation/widgets/empty_list_placeholder.dart';
import 'package:pixel_scan/features/home/presentation/widgets/scan_fab.dart';
import 'package:pixel_scan/features/home/presentation/widgets/search_field.dart';
import 'package:open_file/open_file.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const HomeEvent.loadDocuments()),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title: SvgPicture.asset('assets/images/logo.svg', height: 24),
          actions: [
            IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {
                context.read<HomeBloc>().add(const HomeEvent.toggleSort());
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SearchField(),
              const Gap(20),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is Error) {
                      return Center(child: Text('Error: ${state.message}'));
                    }

                    if (state is Loaded) {
                      if (state.documents.isEmpty) {
                        return const EmptyListPlaceholder();
                      }
                      return DocumentList(
                        documents: state.documents,
                        onDocumentTap: (document) {
                          if (document.pdfPath != null &&
                              document.pdfPath!.isNotEmpty) {
                            OpenFile.open(document.pdfPath);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('PDF файл еще не создан'),
                              ),
                            );
                          }
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: const ScanFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
