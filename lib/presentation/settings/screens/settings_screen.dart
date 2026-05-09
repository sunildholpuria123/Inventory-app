import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider/theme_provider.dart';
import '../provider/settings_provider.dart';

class SettingsScreen
    extends ConsumerWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final settings =
    ref.watch(settingsProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,

            children: [
              Text(
                'Application Settings',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium,
              ),

              const SizedBox(height: 30),

              buildSectionTitle(
                'Appearance',
              ),

              SwitchListTile(
                value: settings.darkMode,

                title:
                const Text('Dark Mode'),

                onChanged: (value) {
                  ref
                      .read(
                    themeModeProvider.notifier,
                  )
                      .state = value
                      ? ThemeMode.dark
                      : ThemeMode.light;

                  ref
                      .read(
                    settingsProvider.notifier,
                  )
                      .state = settings.copyWith(
                    darkMode: value,
                  );
                },
              ),

              const Divider(),

              buildSectionTitle(
                'Currency',
              ),

              DropdownButtonFormField(
                value:
                settings.currency,

                items: const [
                  DropdownMenuItem(
                    value: '₹',
                    child: Text(
                      'Indian Rupee ₹',
                    ),
                  ),

                  DropdownMenuItem(
                    value: '\$',
                    child:
                    Text('Dollar \$'),
                  ),

                  DropdownMenuItem(
                    value: '€',
                    child: Text(
                      'Euro €',
                    ),
                  ),
                ],

                onChanged: (value) {
                  ref
                      .read(
                    settingsProvider
                        .notifier,
                  )
                      .state = settings
                      .copyWith(
                    currency:
                    value!,
                  );
                },
              ),

              const SizedBox(height: 30),

              buildSectionTitle(
                'Tax Settings',
              ),

              TextFormField(
                initialValue: settings
                    .taxPercent
                    .toString(),

                decoration:
                const InputDecoration(
                  labelText:
                  'GST / Tax %',
                ),

                onChanged: (value) {
                  ref
                      .read(
                    settingsProvider
                        .notifier,
                  )
                      .state = settings
                      .copyWith(
                    taxPercent:
                    double.tryParse(
                      value,
                    ) ??
                        0,
                  );
                },
              ),

              const SizedBox(height: 30),

              buildSectionTitle(
                'Company Details',
              ),

              TextFormField(
                initialValue: settings
                    .companyName,

                decoration:
                const InputDecoration(
                  labelText:
                  'Company Name',
                ),

                onChanged: (value) {
                  ref
                      .read(
                    settingsProvider
                        .notifier,
                  )
                      .state = settings
                      .copyWith(
                    companyName:
                    value,
                  );
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                initialValue: settings
                    .companyAddress,

                decoration:
                const InputDecoration(
                  labelText:
                  'Company Address',
                ),

                onChanged: (value) {
                  ref
                      .read(
                    settingsProvider
                        .notifier,
                  )
                      .state = settings
                      .copyWith(
                    companyAddress:
                    value,
                  );
                },
              ),

              const SizedBox(height: 30),

              buildSectionTitle(
                'Invoice Settings',
              ),

              TextFormField(
                initialValue: settings
                    .invoicePrefix,

                decoration:
                const InputDecoration(
                  labelText:
                  'Invoice Prefix',
                ),

                onChanged: (value) {
                  ref
                      .read(
                    settingsProvider
                        .notifier,
                  )
                      .state = settings
                      .copyWith(
                    invoicePrefix:
                    value,
                  );
                },
              ),

              const SizedBox(height: 30),

              buildSectionTitle(
                'Backup & Restore',
              ),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading:
                      const Icon(Icons.backup),

                      title:
                      const Text('Backup Database'),

                      trailing: ElevatedButton(
                        onPressed: () {},

                        child: const Text(
                          'Backup',
                        ),
                      ),
                    ),

                    ListTile(
                      leading:
                      const Icon(Icons.restore),

                      title:
                      const Text('Restore Database'),

                      trailing: ElevatedButton(
                        onPressed: () {},

                        child: const Text(
                          'Restore',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Settings Saved',
                        ),
                      ),
                    );
                  },

                  icon:
                  const Icon(Icons.save),

                  label: const Text(
                    'Save Settings',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(
      String title,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 15,
      ),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }
}