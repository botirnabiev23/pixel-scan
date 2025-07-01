import 'package:go_router/go_router.dart';
import 'package:pixel_scan/features/document/presentation/pages/document_viewer_page.dart';
import 'package:pixel_scan/features/home/presentation/pages/home_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/document/:id',
      name: 'document',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DocumentViewerPage(id: id);
      },
    ),
  ],
);
