import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:masterfabric_core/masterfabric_core.dart';
import 'dart:io' show Platform;
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(LucideIcons.hash, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text('Device ID', style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              centerTitle: true,
              actions: [
                if (!viewModel.state.isLoading)
                  IconButton(
                    icon: const Icon(LucideIcons.refreshCw, size: 20),
                    onPressed: () => viewModel.loadDeviceId(),
                    tooltip: 'Refresh',
                  ),
              ],
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
      return _buildLoadingState();
    }

    if (state.errorMessage != null) {
      return _buildErrorState(context, viewModel, state.errorMessage!);
    }

    return _buildSuccessState(context, viewModel, state);
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Fetching Device ID...',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.grey600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, DeviceIdCubit viewModel, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.circleAlert, size: 48, color: AppColors.error),
            ),
            const SizedBox(height: 24),
            Text(
              'Failed to Load',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => viewModel.loadDeviceId(),
              icon: const Icon(LucideIcons.refreshCw, size: 18),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, DeviceIdCubit viewModel, DeviceIdState state) {
    final deviceId = state.deviceId ?? 'Unknown';
    final platform = Platform.isAndroid ? 'Android' : 'iOS';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.grey50, Colors.white],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildPlatformBanner(platform),
          const SizedBox(height: 24),
          _buildDeviceIdCard(context, deviceId),
          const SizedBox(height: 16),
          _buildInfoCards(platform),
          const SizedBox(height: 16),
          _buildTechnicalDetails(platform, deviceId),
        ],
      ),
    );
  }

  Widget _buildPlatformBanner(String platform) {
    final isAndroid = platform == 'Android';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isAndroid
              ? [AppColors.success, AppColors.success.withValues(alpha: 0.8)]
              : [AppColors.grey700, AppColors.grey600],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isAndroid ? AppColors.success : AppColors.grey700).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            isAndroid ? LucideIcons.smartphone : LucideIcons.apple,
            size: 28,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  isAndroid ? 'Settings.Secure.ANDROID_ID' : 'UIDevice.identifierForVendor',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.9),
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceIdCard(BuildContext context, String deviceId) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(LucideIcons.hash, size: 20, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
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
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.grey900,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey800),
            ),
            child: SelectableText(
              deviceId,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: Colors.greenAccent,
                letterSpacing: 0.5,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: deviceId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(LucideIcons.check, color: Colors.white, size: 18),
                            const SizedBox(width: 12),
                            const Text('Copied to clipboard!'),
                          ],
                        ),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  },
                  icon: const Icon(LucideIcons.copy, size: 18),
                  label: const Text('Copy ID'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(LucideIcons.check, size: 18, color: AppColors.success),
                    const SizedBox(width: 8),
                    Text(
                      '${deviceId.length} chars',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards(String platform) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            'Persistent',
            platform == 'Android' ? 'Until reset' : 'Per vendor',
            LucideIcons.database,
            AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            'Unique',
            'Per device',
            LucideIcons.shield,
            AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.grey600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalDetails(String platform, String deviceId) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.info, size: 18, color: AppColors.grey600),
              const SizedBox(width: 8),
              const Text(
                'Technical Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Platform', platform),
          _buildDetailRow('Method', platform == 'Android' ? 'ANDROID_ID' : 'identifierForVendor'),
          _buildDetailRow('Length', '${deviceId.length} characters'),
          _buildDetailRow('Format', deviceId.contains('-') ? 'UUID' : 'Hexadecimal'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.grey600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
