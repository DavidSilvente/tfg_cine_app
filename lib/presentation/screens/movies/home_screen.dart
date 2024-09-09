import 'package:cine_tfg_app/presentation/providers/video/discover_provider.dart';
import 'package:cine_tfg_app/presentation/screens/video/discover_screen.dart';
import 'package:cine_tfg_app/presentation/views/views.dart';
import 'package:cine_tfg_app/presentation/widgets/shared/shared.dart';
import 'package:cine_tfg_app/presentation/widgets/shared/widgets/side_menu.dart';
import 'package:cine_tfg_app/presentation/widgets/shared/widgets/video_scrollable_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
    super.key, 
    required this.pageIndex
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with AutomaticKeepAliveClientMixin {
  
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Obtenemos los videos del estado de discoverProvider
    final videos = ref.watch(discoverProvider).videos;

    final viewRoutes = <Widget>[
      const HomeView(),
      DiscoverScreen(), // Pasamos los videos al VideoScrollableView
      const FavoritesView(),
    ];

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex, 
        curve: Curves.easeOut, 
        duration: const Duration(milliseconds: 250)
      );
    }

    return Scaffold(
      drawer: SideMenu(scaffoldKey: GlobalKey<ScaffoldState>()),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: widget.pageIndex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
