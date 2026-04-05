import 'package:ecommerce_prueba/main.dart';
import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/CategoryListPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/ClientListPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeState.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/list/OrderListPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/ProductListPage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/ProfilePage.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/SubCategoryListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color _primaryColor = Color(0xff173A7A);
  static const Color _accentColor = Color(0xff2F6BFF);
  static const Color _surfaceColor = Color(0xffF4F7FC);

  HomeBloc? _bloc;
  int _selectedIndex = 0;

  late final List<_MenuEntry> _menuEntries;

  late final List<Widget> _pages = [
    _DashboardHome(
      onNavigate: _changePage,
      items: _menuEntries.where((item) => !item.isLogout).toList(),
    ),
    const ProfilePage(),
    const CategoryListPage(),
    const SubCategoryListPage(),
    const ProductListPage(),
    const ClientListPage(),
    const OrderListPage(),
  ];

  @override
  void initState() {
    super.initState();
    _menuEntries = const [
      _MenuEntry(
        index: 1,
        title: 'Actualizar perfil',
        subtitle: 'Edita tus datos y tu foto de usuario.',
        icon: Icons.person_outline_rounded,
        accent: Color(0xff3154F6),
      ),
      _MenuEntry(
        index: 2,
        title: 'Categorias',
        subtitle: 'Organiza las lineas de tu catalogo.',
        icon: Icons.category_rounded,
        accent: Color(0xff0F9D8A),
      ),
      _MenuEntry(
        index: 3,
        title: 'Subcategorias',
        subtitle: 'Agrupa productos con mayor precision.',
        icon: Icons.account_tree_rounded,
        accent: Color(0xff8B5CF6),
      ),
      _MenuEntry(
        index: 4,
        title: 'Productos',
        subtitle: 'Administra precios, stock e imagenes.',
        icon: Icons.inventory_2_outlined,
        accent: Color(0xffF97316),
      ),
      _MenuEntry(
        index: 5,
        title: 'Clientes',
        subtitle: 'Consulta y actualiza tu base comercial.',
        icon: Icons.groups_2_outlined,
        accent: Color(0xff14B8A6),
      ),
      _MenuEntry(
        index: 6,
        title: 'Ventas',
        subtitle: 'Revisa pedidos y movimiento comercial.',
        icon: Icons.point_of_sale_outlined,
        accent: Color(0xffEF4444),
      ),
      _MenuEntry(
        index: -2,
        title: 'Cerrar sesion',
        subtitle: 'Salir del panel administrativo.',
        icon: Icons.logout_rounded,
        accent: Color(0xffD92D20),
        isLogout: true,
      ),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.add(InitHomeEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      backgroundColor: _surfaceColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_primaryColor, _accentColor],
            ),
          ),
        ),
        title: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final currentTitle = _selectedIndex == 0
                ? 'Panel de administracion'
                : _menuEntries
                          .where((item) => item.index == _selectedIndex)
                          .firstOrNull
                          ?.title ??
                      'Panel de administracion';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  state.user?.nombre.isNotEmpty == true
                      ? 'Hola, ${state.user!.nombre}'
                      : 'Gestion elegante de tu tienda',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      drawer: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Drawer(
            backgroundColor: const Color(0xffF8FAFF),
            child: SafeArea(
              child: Column(
                children: [
                  _DrawerHeaderCard(
                    user: state.user,
                    primaryColor: _primaryColor,
                    accentColor: _accentColor,
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 18),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 10),
                          child: Text(
                            'Modulos',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: const Color(0xff64748B),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                          ),
                        ),
                        ..._menuEntries.map(_drawerItem),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffEEF4FF), Color(0xffF7F9FD), Color(0xffffffff)],
          ),
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return _pages[_selectedIndex];
          },
        ),
      ),
    );
  }

  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _drawerItem(_MenuEntry item) {
    final isSelected = _selectedIndex == item.index;
    final foregroundColor = item.isLogout
        ? const Color(0xffD92D20)
        : isSelected
        ? Colors.white
        : const Color(0xff334155);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.pop(context);

            if (item.isLogout) {
              _bloc?.add(LogoutHomeEvent());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                (_) => false,
              );
              return;
            }

            _changePage(item.index);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [item.accent, _primaryColor],
                    )
                  : null,
              color: isSelected ? null : Colors.white,
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : const Color(0xffD9E4F5),
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: item.accent.withValues(alpha: 0.22),
                        blurRadius: 24,
                        spreadRadius: -10,
                        offset: const Offset(0, 16),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.18)
                        : item.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(item.icon, color: foregroundColor),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          color: foregroundColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.82)
                              : const Color(0xff64748B),
                          fontSize: 12.5,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  color: isSelected ? Colors.white : const Color(0xff94A3B8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  final List<_MenuEntry> items;
  final ValueChanged<int> onNavigate;

  const _DashboardHome({required this.items, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final user = state.user;
        final shortcuts = items.take(4).toList();

        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DashboardHero(user: user),
                const SizedBox(height: 20),
                _QuickStats(items: items),
                const SizedBox(height: 22),
                Text(
                  'Accesos rapidos',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff102A43),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Ingresa a los modulos mas usados desde una portada mas clara y moderna.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xff64748B),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: shortcuts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.08,
                  ),
                  itemBuilder: (context, index) {
                    final item = shortcuts[index];
                    return _ShortcutCard(
                      item: item,
                      onTap: () => onNavigate(item.index),
                    );
                  },
                ),
                const SizedBox(height: 22),
                _DashboardHighlight(
                  item: items.length > 4 ? items[4] : items.first,
                  secondaryItem: items.length > 5 ? items[5] : items.last,
                  onNavigate: onNavigate,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DashboardHero extends StatelessWidget {
  final User? user;

  const _DashboardHero({required this.user});

  @override
  Widget build(BuildContext context) {
    final String userName = (user?.nombre ?? '').trim();
    final String email = (user?.email ?? '').trim();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff153677), Color(0xff2558D9), Color(0xff6EA8FE)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2558D9).withValues(alpha: 0.24),
            blurRadius: 30,
            spreadRadius: -10,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _UserAvatar(imageUrl: user?.imagen, size: 64),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName.isNotEmpty
                          ? 'Bienvenido, $userName'
                          : 'Bienvenido al panel',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      email.isNotEmpty
                          ? email
                          : 'Supervisa productos, clientes y ventas desde un solo lugar.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.86),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _HeroTag(
                icon: Icons.auto_graph_rounded,
                label: 'Panel visual y moderno',
              ),
              _HeroTag(
                icon: Icons.dashboard_customize_outlined,
                label: 'Acceso directo a modulos',
              ),
              _HeroTag(
                icon: Icons.verified_user_outlined,
                label: 'Gestion centralizada',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickStats extends StatelessWidget {
  final List<_MenuEntry> items;

  const _QuickStats({required this.items});

  @override
  Widget build(BuildContext context) {
    final List<_StatData> stats = [
      _StatData(
        title: 'Modulos activos',
        value: '${items.length}',
        icon: Icons.widgets_outlined,
        accent: const Color(0xff3154F6),
      ),
      _StatData(
        title: 'Catalogo',
        value: 'Categorias y productos',
        icon: Icons.inventory_2_outlined,
        accent: const Color(0xff0F9D8A),
      ),
      _StatData(
        title: 'Operacion',
        value: 'Clientes y ventas',
        icon: Icons.local_mall_outlined,
        accent: const Color(0xffF97316),
      ),
    ];

    return Column(
      children: stats
          .map(
            (stat) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xffDCE6F8)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: stat.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(stat.icon, color: stat.accent),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stat.title,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: const Color(0xff64748B),
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stat.value,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: const Color(0xff102A43),
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _DashboardHighlight extends StatelessWidget {
  final _MenuEntry item;
  final _MenuEntry secondaryItem;
  final ValueChanged<int> onNavigate;

  const _DashboardHighlight({
    required this.item,
    required this.secondaryItem,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xff0F172A),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0F172A).withValues(alpha: 0.18),
            blurRadius: 30,
            spreadRadius: -12,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Espacio de trabajo recomendado',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Continua con los modulos que suelen mover mas informacion en el panel.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.78),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          _HighlightAction(
            item: item,
            buttonLabel: 'Abrir ${item.title.toLowerCase()}',
            onTap: () => onNavigate(item.index),
          ),
          const SizedBox(height: 12),
          _HighlightAction(
            item: secondaryItem,
            buttonLabel: 'Ir a ${secondaryItem.title.toLowerCase()}',
            onTap: () => onNavigate(secondaryItem.index),
          ),
        ],
      ),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  final _MenuEntry item;
  final VoidCallback onTap;

  const _ShortcutCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, item.accent.withValues(alpha: 0.08)],
            ),
            border: Border.all(color: const Color(0xffDCE6F8)),
            boxShadow: [
              BoxShadow(
                color: item.accent.withValues(alpha: 0.16),
                blurRadius: 24,
                spreadRadius: -14,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: item.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(item.icon, color: item.accent, size: 28),
              ),
              const Spacer(),
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xff102A43),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xff64748B),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HighlightAction extends StatelessWidget {
  final _MenuEntry item;
  final String buttonLabel;
  final VoidCallback onTap;

  const _HighlightAction({
    required this.item,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item.icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.76),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xff0F172A),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              elevation: 0,
            ),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeaderCard extends StatelessWidget {
  final User? user;
  final Color primaryColor;
  final Color accentColor;

  const _DrawerHeaderCard({
    required this.user,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final email = (user?.email ?? '').trim();
    final phone = (user?.telefono ?? '').trim();

    return Container(
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, accentColor],
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.24),
            blurRadius: 28,
            spreadRadius: -12,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _UserAvatar(imageUrl: user?.imagen, size: 68),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (user?.nombre ?? 'Usuario').toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Panel administrativo',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.76),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (email.isNotEmpty || phone.isNotEmpty) ...[
            const SizedBox(height: 18),
            if (email.isNotEmpty)
              _ContactRow(icon: Icons.mail_outline, text: email),
            if (phone.isNotEmpty) ...[
              const SizedBox(height: 10),
              _ContactRow(icon: Icons.phone_outlined, text: phone),
            ],
          ],
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.86), size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.86),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const _UserAvatar({required this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    final hasImage = (imageUrl ?? '').trim().isNotEmpty;

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: ClipOval(
        child: hasImage
            ? FadeInImage.assetNetwork(
                image: imageUrl!,
                placeholder: 'assets/img/user_image.png',
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 250),
                imageErrorBuilder: (context, error, stackTrace) {
                  return _fallbackAvatar();
                },
              )
            : _fallbackAvatar(),
      ),
    );
  }

  Widget _fallbackAvatar() {
    return Container(
      color: Colors.white,
      child: const Icon(
        Icons.person_rounded,
        color: Color(0xff3154F6),
        size: 34,
      ),
    );
  }
}

class _HeroTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroTag({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuEntry {
  final int index;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final bool isLogout;

  const _MenuEntry({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    this.isLogout = false,
  });
}

class _StatData {
  final String title;
  final String value;
  final IconData icon;
  final Color accent;

  const _StatData({
    required this.title,
    required this.value,
    required this.icon,
    required this.accent,
  });
}

extension _IterableFirstWhereOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
