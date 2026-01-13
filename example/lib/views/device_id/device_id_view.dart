import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import '../../theme/app_colors.dart';
import 'cubit/device_id_cubit.dart';
import 'cubit/device_id_state.dart';

class DeviceIdView extends MasterViewCubit<DeviceIdCubit, DeviceIdState> {
  DeviceIdView({
    super.key,
    required Function(String) goRoute,
  }) : super(
          currentView: MasterViewCubitTypes.content,
          goRoute: goRoute,
          coreAppBar: (context, viewModel) {
            return AppBar(
              title: const Text('Device ID'),
              centerTitle: true,
            );
          },
        );

  @override
  Future<void> initialContent(DeviceIdCubit viewModel, BuildContext context) async {
    await viewModel.loadDeviceId();
  }

  @override
  Widget viewContent(BuildContext context, DeviceIdCubit viewModel, DeviceIdState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
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
              onPressed: () => viewModel.loadDeviceId(),
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
                  Icon(LucideIcons.hash, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Device Identifier',
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
                  state.deviceId ?? 'Unknown',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => viewModel.loadDeviceId(),
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
