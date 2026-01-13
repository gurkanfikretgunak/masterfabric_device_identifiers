import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import 'dart:io' show Platform;
import '../../theme/app_colors.dart';
import 'cubit/imei_cubit.dart';
import 'cubit/imei_state.dart';

class ImeiView extends MasterViewCubit<ImeiCubit, ImeiState> {
  ImeiView({
    super.key,
    required Function(String) goRoute,
  }) : super(
          currentView: MasterViewCubitTypes.content,
          goRoute: goRoute,
          coreAppBar: (context, viewModel) {
            return AppBar(
              title: const Text('IMEI'),
              centerTitle: true,
            );
          },
        );

  @override
  Future<void> initialContent(ImeiCubit viewModel, BuildContext context) async {
    await viewModel.loadImei();
  }

  @override
  Widget viewContent(BuildContext context, ImeiCubit viewModel, ImeiState state) {
    if (!Platform.isAndroid) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.cable, size: 64, color: AppColors.grey400),
            const SizedBox(height: 16),
            Text(
              'IMEI is only available on Android devices',
              style: TextStyle(color: AppColors.grey600),
            ),
          ],
        ),
      );
    }

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.permissionDenied) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.shieldAlert, size: 64, color: AppColors.warning),
            const SizedBox(height: 16),
            const Text('Phone permission required'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => viewModel.requestPermission(),
              icon: const Icon(LucideIcons.lock),
              label: const Text('Grant Permission'),
            ),
          ],
        ),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.cable, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(state.errorMessage!, style: TextStyle(color: AppColors.error)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => viewModel.loadImei(),
              icon: const Icon(LucideIcons.refreshCw),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.creditCard, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'IMEI Number',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  state.imei ?? 'Unknown',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => viewModel.loadImei(),
                icon: const Icon(LucideIcons.refreshCw),
                label: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
