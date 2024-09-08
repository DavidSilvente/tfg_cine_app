import 'package:cine_tfg_app/features/auth/presentation/providers/providers.dart';
import 'package:cine_tfg_app/presentation/widgets/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key, 
    required this.scaffoldKey
  });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        // Navegación utilizando GoRouter
        switch (value) {
          case 0:
            context.go('/home/0'); // Navega a la página home/0 (Productos)
            break;
          case 1:
            context.go('/home/1'); // Navega a la página home/1 (Películas)
            break;
          case 2:
            context.go('/home/2'); // Navega a la página home/2 (Series)
            break;
          default:
            context.go('/home/0');
        }

        widget.scaffoldKey.currentState?.closeDrawer(); // Cierra el Drawer
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: Text('Saludos', style: textStyles.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
          child: Text('Tony Stark', style: textStyles.titleSmall),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          label: Text('Productos'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.movie_outlined),
          label: Text('Películas'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.tv_outlined),
          label: Text('Series'),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Otras opciones'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
            text: 'Cerrar sesión',
          ),
        ),
      ],
    );
  }
}