import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:void_vault/core/common/void_scanner.dart';
import 'package:void_vault/core/theme/app_theme.dart';
import 'package:void_vault/features/gallery/controller/gallery_controller.dart';

class AddAccountScreen extends ConsumerStatefulWidget {
  const AddAccountScreen({super.key});

  @override
  ConsumerState<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends ConsumerState<AddAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final cloudController = TextEditingController();
  final presetController = TextEditingController();
  final labelController = TextEditingController();

  @override
  void dispose() {
    cloudController.dispose();
    presetController.dispose();
    labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(galleryControllerProvider);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppTheme.background,
          appBar: AppBar(
            backgroundColor: AppTheme.background,
            elevation: 0,
            centerTitle: false,
            title: Text(
              "ADD ACCOUNT",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.primary,
                    fontSize: 14,
                    letterSpacing: 4,
                  ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 18, color: AppTheme.textSecondary),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
              if (state.isLoading) const MinimalVoidScan(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextField(
                          controller: labelController,
                          label: "LABEL",
                          hint: "e.g., Primary Vault",
                          validator: (value) => value == null || value.isEmpty
                              ? 'LABEL_REQUIRED'
                              : null,
                        ),
                        const SizedBox(height: 32),
                        _buildTextField(
                          controller: cloudController,
                          label: "CLOUD NAME",
                          hint: "your-cloud-name",
                          validator: (value) => value == null || value.isEmpty
                              ? 'CLOUD_NAME_REQUIRED'
                              : null,
                        ),
                        const SizedBox(height: 32),
                        _buildTextField(
                          controller: presetController,
                          label: "UPLOAD PRESET",
                          hint: "your-preset-name",
                          validator: (value) => value == null || value.isEmpty
                              ? 'PRESET_REQUIRED'
                              : null,
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    await ref
                                        .read(galleryControllerProvider.notifier)
                                        .addAccount(
                                          cloudController.text,
                                          presetController.text,
                                          labelController.text,
                                        );
                                    if (context.mounted) Navigator.pop(context);
                                  }
                                },
                          child: Text(
                              state.isLoading ? 'SCANNING...' : 'SAVE_CHANGES'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 10,
            letterSpacing: 2,
          ),
        ),
        TextFormField(
          controller: controller,
          cursorColor: AppTheme.primary,
          validator: validator,
          style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.3)),
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 10),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.outlineVariant, width: 1),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primary, width: 2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ],
    );
  }
}
