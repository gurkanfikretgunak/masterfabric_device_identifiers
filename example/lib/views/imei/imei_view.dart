import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(LucideIcons.smartphone, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text('IMEI Number', style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              centerTitle: true,
              actions: [
                if (!viewModel.state.isLoading && Platform.isAndroid)
                  IconButton(
                    icon: const Icon(LucideIcons.refreshCw, size: 20),
                    onPressed: () => viewModel.loadImei(),
                    tooltip: 'Refresh',
                  ),
              ],
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
      return _buildPlatformNotSupported();
    }

    if (state.isLoading) {
      return _buildLoadingState();
    }

    if (state.permissionDenied) {
      return _buildPermissionDenied(context, viewModel);
    }

    if (state.errorMessage != null) {
      return _buildErrorState(context, viewModel, state.errorMessage!);
    }

    return _buildSuccessState(context, viewModel, state);
  }

  Widget _buildPlatformNotSupported() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.apple, size: 56, color: AppColors.grey600),
            ),
            const SizedBox(height: 24),
            Text(
              'Not Available on iOS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.grey800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'IMEI retrieval is only supported on Android devices due to platform restrictions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey600,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
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
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Checking permissions...',
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

  Widget _buildPermissionDenied(BuildContext context, ImeiCubit viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.shieldAlert, size: 56, color: AppColors.warning),
            ),
            const SizedBox(height: 24),
            Text(
              'Permission Required',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.grey800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Phone permission is required to access IMEI. This permission allows the app to read device identification information.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey600,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => viewModel.requestPermission(),
              icon: const Icon(LucideIcons.lock, size: 20),
              label: const Text('Grant Permission'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warning,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, ImeiCubit viewModel, String error) {
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
              child: Icon(LucideIcons.triangle, size: 48, color: AppColors.error),
            ),
            const SizedBox(height: 24),
            Text(
              'Failed to Retrieve IMEI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.grey800,
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
              onPressed: () => viewModel.loadImei(),
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

  Widget _buildSuccessState(BuildContext context, ImeiCubit viewModel, ImeiState state) {
    final imei = state.imei ?? 'Unknown';

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
          _buildPermissionBanner(),
          const SizedBox(height: 24),
          _buildImeiCard(context, imei),
          const SizedBox(height: 16),
          _buildInfoGrid(),
          const SizedBox(height: 16),
          _buildSecurityNote(),
        ],
      ),
    );
  }

  Widget _buildPermissionBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.success, AppColors.success.withValues(alpha: 0.8)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(LucideIcons.shieldCheck, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Permission Granted',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'READ_PHONE_STATE',
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

  Widget _buildImeiCard(BuildContext context, String imei) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.1),
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
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(LucideIcons.creditCard, size: 20, color: AppColors.secondary),
              ),
              const SizedBox(width: 12),
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
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.grey900,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey800),
            ),
            child: SelectableText(
              imei,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                color: Colors.cyanAccent,
                letterSpacing: 1.5,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: imei));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(LucideIcons.check, color: Colors.white, size: 18),
                      const SizedBox(width: 12),
                      const Text('IMEI copied to clipboard!'),
                    ],
                  ),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              );
            },
            icon: const Icon(LucideIcons.copy, size: 18),
            label: const Text('Copy IMEI'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              minimumSize: const Size(double.infinity, 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildInfoCard('Platform', 'Android', LucideIcons.smartphone, AppColors.success),
        _buildInfoCard('Length', '15 digits', LucideIcons.hash, AppColors.primary),
        _buildInfoCard('Type', 'Cellular', LucideIcons.smartphone, AppColors.secondary),
        _buildInfoCard('Unique', 'Hardware', LucideIcons.cpu, AppColors.warning),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.grey600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.shieldAlert, size: 20, color: AppColors.warning),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Note',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'IMEI is sensitive device information. Handle with care and follow privacy best practices.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
