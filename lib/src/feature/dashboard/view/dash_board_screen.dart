import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i2hand/gen/assets.gen.dart';
import 'package:i2hand/src/feature/dashboard/item/navigation_bar.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_bloc.dart';
import 'package:i2hand/src/feature/dashboard/logic/dashboard_state.dart';
import 'package:i2hand/src/theme/colors.dart';
import 'package:i2hand/src/theme/value.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    super.key,
    required this.currentItem,
    required this.body,
  });

  final XNavigationBarItems currentItem;
  final Widget body;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(widget.currentItem),
      child: BlocBuilder<DashboardBloc, XNavigationBarItems>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              context.read<DashboardBloc>().goHome();
            },
            child: Scaffold(
              body: widget.body,
              bottomNavigationBar: XBottomNavigationBar(
                items: [
                  TabItem<Widget>(
                      icon: state.index == 0
                          ? Assets.jsons.home.lottie()
                          : Icon(XNavigationBarItems.home.icon)),
                  TabItem<Widget>(
                      icon: state.index == 1
                          ? Assets.jsons.home.lottie()
                          : Icon(XNavigationBarItems.product.icon)),
                  TabItem<Widget>(
                      icon: state.index == 2
                          ? Assets.jsons.home.lottie()
                          : Icon(XNavigationBarItems.post.icon)),
                  TabItem<Widget>(
                    icon: state.index == 3
                        ? SizedBox(
                            height: AppSize.s36,
                            width: AppSize.s36,
                            child: OverflowBox(
                              minHeight: AppSize.s90,
                              maxHeight: AppSize.s90,
                              minWidth: AppSize.s90,
                              maxWidth: AppSize.s90,
                              child:
                                  Assets.jsons.cart.lottie(fit: BoxFit.contain),
                            ),
                          )
                        : Assets.svg.cart.svg(
                            fit: BoxFit.contain,
                            width: AppSize.s36,
                            colorFilter: const ColorFilter.mode(
                                AppColors.black, BlendMode.srcIn)),
                  ),
                  TabItem<Widget>(
                    icon: state.index == 4
                        ? Assets.jsons.account
                            .lottie(fit: BoxFit.contain, width: AppSize.s36)
                        : Assets.svg.account.svg(
                            fit: BoxFit.contain,
                            width: AppSize.s36,
                            colorFilter: const ColorFilter.mode(
                                AppColors.black, BlendMode.srcIn)),
                  ),
                ],
                index: state.index,
                style: ItemStyle.circle,
                color: AppColors.black,
                bgColor: AppColors.white,
                onChangedTab: (index) =>
                    context.read<DashboardBloc>().onDestinationSelected(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
