import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/pages/wallet_page/methods/wallet_card.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/widgets/back_navigation_bar_widget.dart';

class NavBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final WidgetRef ref;
  const NavBarWidget({super.key, required this.ref});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 3);
}

class _NavBarWidgetState extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.black,
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              BackNavigationBarWidget(
                title: 'My Wallet',
                clickListener: () {
                  widget.ref.read(routerProvider).pop();
                },
              ),
              verticalSpace(10),
              walletCard(widget.ref),
            ],
          ),
        ),
      ),
    );
  }
}
