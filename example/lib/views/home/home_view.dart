import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import '../../app/routes.dart' as app_routes;
import '../../theme/app_colors.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomeView extends MasterViewCubit<HomeCubit, HomeState> {
  HomeView({
    super.key,
    required Function(String) goRoute,
  }) : super(
          currentView: MasterViewCubitTypes.content,
          goRoute: goRoute,
          coreAppBar: (context, viewModel) {
            return AppBar(
              title: const Text('Device Identifiers'),
              centerTitle: true,
            );
          },
        );

  @override
  Future<void> initialContent(HomeCubit viewModel, BuildContext context) async {
    await viewModel.loadData();
  }

  @override
  Widget viewContent(BuildContext context, HomeCubit viewModel, HomeState state) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeroCard(context),
        const SizedBox(height: 20),
        _buildNavigationCard(context),
      ],
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.secondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(LucideIcons.smartphone, size: 24, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device Identifiers',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'v0.0.1',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Get unique device identifiers for Android and iOS platforms. '
            'Supports Device ID and IMEI (Android only).',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        children: [
          _buildNavItem(
            context,
            'Device ID',
            'Get unique device identifier',
            LucideIcons.hash,
            app_routes.AppRoutes.deviceId,
          ),
          const Divider(height: 1),
          _buildNavItem(
            context,
            'IMEI',
            'Get IMEI (Android only)',
            LucideIcons.creditCard,
            app_routes.AppRoutes.imei,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, String title, String subtitle, IconData icon, String route) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => super.goRoute(route),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 24, color: AppColors.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.grey600)),
                  ],
                ),
              ),
              Icon(LucideIcons.chevronRight, size: 20, color: AppColors.grey600),
            ],
          ),
        ),
      ),
    );
  }
}
