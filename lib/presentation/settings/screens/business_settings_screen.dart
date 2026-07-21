import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../provider/settings_provider.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

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

  final merchantController = TextEditingController();

  String? _upiQrPath;

  bool _enableUpi = false;

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
    merchantController.dispose();

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
    merchantController.text = setting.upiMerchantName ?? '';

    _upiQrPath = setting.upiQrImagePath;

    _enableUpi = setting.enableUpiPayment;

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
          upiMerchantName: Value(merchantController.text.trim()),

          upiQrImagePath: Value(_upiQrPath),

          enableUpiPayment: Value(_enableUpi),
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

  Future<void> _pickQrImage() async {
    String? imagePath;

    if (Platform.isAndroid || Platform.isIOS) {
      final picker = ImagePicker();

      final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (image == null) return;

      imagePath = image.path;
    } else {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result == null) return;

      imagePath = result.files.single.path;
    }

    if (imagePath == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop QR Code',
          lockAspectRatio: true,
          hideBottomControls: false,
        ),
        IOSUiSettings(title: 'Crop QR Code', aspectRatioLockEnabled: true),
      ],
    );

    if (cropped == null) return;

    setState(() {
      _upiQrPath = cropped.path;
    });
  }

  void _removeQr() {
    setState(() {
      _upiQrPath = null;
    });
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
      appBar: AppBar(
        title: const Text("Business Settings"),
        centerTitle: false,
      ),
      body: settings.when(
        data: (setting) {
          _populateFields(setting);

          return LayoutBuilder(
            builder: (context, constraints) {
              final desktop = constraints.maxWidth > 900;

              if (desktop) {
                return _buildDesktopLayout();
              }

              return _buildMobileLayout();
            },
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
  Widget _buildDesktopLayout() {

    return SingleChildScrollView(

      padding: const EdgeInsets.all(24),

      child: Form(

        key: _formKey,

        child: Column(

          children: [

            Row(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: _companyCard(),

                ),

                const SizedBox(width:20),

                Expanded(

                  child: _paymentCard(),

                ),

              ],

            ),

            const SizedBox(height:20),

            _invoiceCard(),

            const SizedBox(height:30),

            _saveButton(),

          ],

        ),

      ),

    );

  }

  Widget _buildMobileLayout(){

    return SingleChildScrollView(

      padding:const EdgeInsets.all(16),

      child:Form(

        key:_formKey,

        child:Column(

          children:[

            _companyCard(),

            SizedBox(height:20),

            _paymentCard(),

            SizedBox(height:20),

            _invoiceCard(),

            SizedBox(height:30),

            _saveButton(),

          ],

        ),

      ),

    );

  }
  Widget _saveButton(){

    return SizedBox(

      width:double.infinity,

      height:55,

      child:FilledButton.icon(

        icon:_saving

            ?SizedBox(

          width:20,

          height:20,

          child:CircularProgressIndicator(

            strokeWidth:2,

            color:Colors.white,

          ),

        )

            :Icon(Icons.save),

        label:Text(

          _saving

              ?"Saving..."

              :"Save Business Settings",

        ),

        onPressed:_saving

            ?null

            :_saveSettings,

      ),

    );

  }
  Widget _companyCard() {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.business),
                const SizedBox(width: 8),
                Text(
                  "Company Information",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            const Divider(height: 30),

            Center(
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(60),
                    onTap: _pickLogo,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: _logoPath != null
                          ? FileImage(File(_logoPath!))
                          : null,
                      child: _logoPath == null
                          ? const Icon(Icons.camera_alt, size: 40)
                          : null,
                    ),
                  ),

                  const SizedBox(height: 12),

                  FilledButton.icon(
                    onPressed: _pickLogo,
                    icon: const Icon(Icons.upload),
                    label: const Text("Upload Logo"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _buildField(
              controller: companyController,
              label: "Company Name",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Company name is required";
                }
                return null;
              },
            ),

            _buildField(
              controller: ownerController,
              label: "Owner Name",
            ),

            _buildField(
              controller: phoneController,
              label: "Phone Number",
              keyboardType: TextInputType.phone,
            ),

            _buildField(
              controller: emailController,
              label: "Email Address",
              keyboardType: TextInputType.emailAddress,
            ),

            _buildField(
              controller: gstController,
              label: "GST Number",
            ),

            _buildField(
              controller: addressController,
              label: "Business Address",
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
  Widget _paymentCard() {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.payments),
                const SizedBox(width: 8),
                Text(
                  "Payment Settings",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            const Divider(height: 30),

            SwitchListTile(
              value: _enableUpi,
              contentPadding: EdgeInsets.zero,
              title: const Text("Enable UPI Payments"),
              subtitle: const Text(
                "Display QR code on invoice",
              ),
              onChanged: (value) {
                setState(() {
                  _enableUpi = value;
                });
              },
            ),

            const SizedBox(height: 10),

            _buildField(
              controller: bankController,
              label: "Bank Name",
            ),

            _buildField(
              controller: accountController,
              label: "Account Number",
            ),

            _buildField(
              controller: ifscController,
              label: "IFSC Code",
            ),

            if (_enableUpi) ...[
              const Divider(),

              _buildField(
                controller: merchantController,
                label: "Merchant Name",
              ),

              _buildField(
                controller: upiController,
                label: "UPI ID",
                validator: (value) {
                  if (!_enableUpi) return null;

                  if (value == null || value.trim().isEmpty) {
                    return "Enter UPI ID";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 10),

              _qrCard(),
            ],
          ],
        ),
      ),
    );
  }
  Widget _qrCard() {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_upiQrPath != null)
              Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.file(
                  File(_upiQrPath!),
                  fit: BoxFit.contain,
                ),
              )
            else
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.qr_code_2,
                    size: 70,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: _pickQrImage,
                  icon: const Icon(Icons.upload),
                  label: Text(
                    _upiQrPath == null
                        ? "Upload QR"
                        : "Replace QR",
                  ),
                ),

                if (_upiQrPath != null)
                  OutlinedButton.icon(
                    onPressed: _removeQr,
                    icon: const Icon(Icons.delete),
                    label: const Text("Remove"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _invoiceCard() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.receipt_long),
                const SizedBox(width: 8),
                Text(
                  "Invoice Settings",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            const Divider(height: 30),

            _buildField(
              controller: footerController,
              label: "Footer Message",
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

}
