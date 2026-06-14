import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/settings_provider.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class BusinessSettingsScreen extends ConsumerStatefulWidget {
  const BusinessSettingsScreen({super.key});

  @override
  ConsumerState<BusinessSettingsScreen> createState() =>
      _BusinessSettingsScreenState();
}

class _BusinessSettingsScreenState
    extends ConsumerState<BusinessSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _logoPath;
  final companyController = TextEditingController();
  final ownerController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final gstController = TextEditingController();

  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final ifscController = TextEditingController();
  final upiController = TextEditingController();

  final footerController = TextEditingController();

  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    companyController.dispose();
    ownerController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    gstController.dispose();

    bankController.dispose();
    accountController.dispose();
    ifscController.dispose();
    upiController.dispose();

    footerController.dispose();

    super.dispose();
  }

  void _populateFields(BusinessSetting? setting) {
    if (_initialized || setting == null) {
      return;
    }

    companyController.text = setting.companyName;
    ownerController.text = setting.ownerName ?? '';
    phoneController.text = setting.phone ?? '';
    emailController.text = setting.email ?? '';
    addressController.text = setting.address ?? '';
    gstController.text = setting.gstNo ?? '';

    bankController.text = setting.bankName ?? '';
    accountController.text = setting.accountNumber ?? '';
    ifscController.text = setting.ifscCode ?? '';
    upiController.text = setting.upiId ?? '';

    footerController.text =
        setting.footerMessage ?? 'Thank you for your business!';

    _logoPath = setting.logoPath;

    _initialized = true;
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        _saving = true;
      });

      final repo = ref.read(businessSettingsRepositoryProvider);

      await repo.saveSettings(
        BusinessSettingsCompanion.insert(
          companyName: companyController.text.trim(),

          ownerName: Value(ownerController.text.trim()),

          phone: Value(phoneController.text.trim()),

          email: Value(emailController.text.trim()),

          address: Value(addressController.text.trim()),

          gstNo: Value(gstController.text.trim()),

          logoPath: Value(_logoPath),

          bankName: Value(bankController.text.trim()),

          accountNumber: Value(accountController.text.trim()),

          ifscCode: Value(ifscController.text.trim()),

          upiId: Value(upiController.text.trim()),

          footerMessage: Value(footerController.text.trim()),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Business settings saved successfully')),
        );

        ref.invalidate(businessSettingsProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: TextFormField(
        controller: controller,

        maxLines: maxLines,

        keyboardType: keyboardType,

        validator: validator,

        decoration: InputDecoration(
          labelText: label,

          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _pickLogo() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    setState(() {
      _logoPath = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(businessSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Business Settings')),

      body: settings.when(
        data: (setting) {
          _populateFields(setting);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Company Information',

                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickLogo,

                          child: CircleAvatar(
                            radius: 50,

                            backgroundImage: _logoPath != null
                                ? FileImage(File(_logoPath!))
                                : null,

                            child: _logoPath == null
                                ? const Icon(Icons.camera_alt, size: 40)
                                : null,
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextButton.icon(
                          onPressed: _pickLogo,

                          icon: const Icon(Icons.upload),

                          label: const Text('Upload Company Logo'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildField(
                    controller: companyController,

                    label: 'Company Name',

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Company name is required';
                      }

                      return null;
                    },
                  ),

                  _buildField(controller: ownerController, label: 'Owner Name'),

                  _buildField(
                    controller: phoneController,

                    label: 'Phone Number',

                    keyboardType: TextInputType.phone,
                  ),

                  _buildField(
                    controller: emailController,

                    label: 'Email',

                    keyboardType: TextInputType.emailAddress,
                  ),

                  _buildField(controller: gstController, label: 'GST Number'),

                  _buildField(
                    controller: addressController,

                    label: 'Address',

                    maxLines: 3,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Bank Details',

                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 20),

                  _buildField(controller: bankController, label: 'Bank Name'),

                  _buildField(
                    controller: accountController,

                    label: 'Account Number',
                  ),

                  _buildField(controller: ifscController, label: 'IFSC Code'),

                  _buildField(controller: upiController, label: 'UPI ID'),

                  const SizedBox(height: 20),

                  Text(
                    'Invoice Footer',

                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 20),

                  _buildField(
                    controller: footerController,

                    label: 'Footer Message',

                    maxLines: 3,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,

                    height: 50,

                    child: ElevatedButton.icon(
                      onPressed: _saving ? null : _saveSettings,

                      icon: _saving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.save),

                      label: Text(_saving ? 'Saving...' : 'Save Settings'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }
}
