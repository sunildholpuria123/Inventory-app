import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../core/provider/network_provider.dart';
import '../model/sync_device.dart';
import '../model/sync_progress.dart';
import '../model/sync_result.dart';
import '../model/sync_statistics.dart';
import '../model/sync_status.dart';
import '../model/sync_table.dart';
import '../provider/device_provider.dart';
import '../provider/sync_provider.dart';

class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  final Set<SyncTable> _selectedTables = {
    SyncTable.customers,
    SyncTable.suppliers,
    SyncTable.products,
    SyncTable.invoices,
    SyncTable.invoiceItems,
    SyncTable.payments,
    SyncTable.expenses,
  };

  List<SyncDevice> _devices = [];

  SyncDevice? _selectedDevice;

  SyncProgress _progress = SyncProgress.idle();

  StreamSubscription<List<SyncDevice>>? _deviceSubscription;

  StreamSubscription<SyncProgress>? _progressSubscription;

  bool _searching = false;

  bool _syncing = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    final network = ref.read(networkServiceProvider);
    final deviceService = ref.read(deviceServiceProvider);
    final syncService = ref.read(syncServiceProvider);

    /*final ip = await network.getLocalIp();

    if (ip == null) {
      return;
    }
*/
    final currentDevice = await deviceService.getCurrentDevice(
      port: 40402,
    );

    await syncService.start(currentDevice: currentDevice);

    _deviceSubscription = syncService.devices.listen((devices) {
      if (!mounted) return;

      setState(() {
        _devices = devices;
      });
    });

    _progressSubscription = syncService.progress.listen((progress) {
      if (!mounted) return;

      setState(() {
        _progress = progress;
      });
    });

    await syncService.searchDevices();
  }

  @override
  void dispose() {
    _deviceSubscription?.cancel();
    _progressSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statistics = ref.watch(syncStatisticsProvider);

    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Database Synchronization"),
        centerTitle: false,
      ),

      body: statistics.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),

        data: (stats) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          _buildStatistics(stats),
                          const SizedBox(height: 20),
                          _buildModules(),
                        ],
                      ),
                    ),

                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          _buildDeviceSection(),
                          const SizedBox(height: 20),
                          _buildProgress(),
                          const SizedBox(height: 20),
                          _buildSyncButton(),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildStatistics(stats),

                  const SizedBox(height: 16),

                  _buildDeviceSection(),

                  const SizedBox(height: 16),

                  _buildModules(),

                  const SizedBox(height: 16),

                  _buildProgress(),

                  const SizedBox(height: 16),

                  _buildSyncButton(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatistics(SyncStatistics stats) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Database Statistics",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            _buildStatRow(Icons.people, "Customers", stats.customers),

            _buildStatRow(Icons.local_shipping, "Suppliers", stats.suppliers),

            _buildStatRow(Icons.inventory_2, "Products", stats.products),

            _buildStatRow(Icons.receipt_long, "Invoices", stats.invoices),

            _buildStatRow(Icons.list_alt, "Invoice Items", stats.invoiceItems),

            _buildStatRow(Icons.payments, "Payments", stats.payments),

            _buildStatRow(Icons.money_off, "Expenses", stats.expenses),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 22),

          const SizedBox(width: 14),

          Expanded(child: Text(title)),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceSection() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Nearby Devices",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const Spacer(),

                FilledButton.icon(
                  onPressed: _searching ? null : _searchDevices,
                  icon: const Icon(Icons.search),
                  label: const Text("Search"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (_searching) const LinearProgressIndicator(),

            if (_devices.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.devices_other,
                        size: 60,
                        color: Colors.grey.shade400,
                      ),

                      const SizedBox(height: 16),

                      const Text("No nearby devices found."),
                    ],
                  ),
                ),
              ),

            ..._devices.map(_buildDeviceTile),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceTile(SyncDevice device) {
    final selected = _selectedDevice?.id == device.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: ListTile(
        leading: Icon(
          device.isDesktop ? Icons.desktop_windows : Icons.phone_android,
          size: 32,
        ),

        title: Text(device.name),

        subtitle: Text("${device.ip}:${device.port}"),

        trailing: selected
            ? const Icon(Icons.check_circle)
            : FilledButton(
                onPressed: () {
                  setState(() {
                    _selectedDevice = device;
                  });
                },
                child: const Text("Select"),
              ),
      ),
    );
  }

  Future<void> _searchDevices() async {
    setState(() {
      _searching = true;
      _devices.clear();
    });

    try {
      final network = ref.read(networkServiceProvider);

      final connected = await network.isConnected();

      if (!connected) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                icon: Icon(Icons.wifi_off),

                title: Text("Network Required"),

                content: Text(
                  "Please connect both devices to the same Wi-Fi network before searching.",
                ),

                actions: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }

        return;
      }

      await ref.read(syncServiceProvider).searchDevices();
    } finally {
      if (!mounted) return;

      setState(() {
        _searching = false;
      });
    }
  }

  Widget _buildModules() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Modules", style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: 16),

            ...SyncTable.values.map((table) {
              final selected = _selectedTables.contains(table);

              return CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                value: selected,
                title: Text(_tableTitle(table)),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedTables.add(table);
                    } else {
                      _selectedTables.remove(table);
                    }
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  String _tableTitle(SyncTable table) {
    switch (table) {
      case SyncTable.customers:
        return "Customers";

      case SyncTable.suppliers:
        return "Suppliers";

      case SyncTable.products:
        return "Products";

      case SyncTable.invoices:
        return "Invoices";

      case SyncTable.invoiceItems:
        return "Invoice Items";

      case SyncTable.payments:
        return "Payments";

      case SyncTable.expenses:
        return "Expenses";

    }
  }

  Widget _buildProgress() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Synchronization Progress",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: _progress.progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),

            const SizedBox(height: 16),

            Text(
              _progress.message.isEmpty
                  ? "Ready to synchronize"
                  : _progress.message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 8),

            Text(
              "${(_progress.progress * 100).toStringAsFixed(0)} %",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncButton() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        icon: _syncing
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.sync),

        label: Text(_syncing ? "Synchronizing..." : "Synchronize Database"),

        onPressed: _syncing
            ? null
            : _selectedDevice == null
            ? null
            : _selectedTables.isEmpty
            ? null
            : _sync,
      ),
    );
  }

  Future<void> _sync() async {
    setState(() {
      _syncing = true;
    });

    try {
      final network = ref.read(networkServiceProvider);

      if (!await network.isConnected()) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Network connection lost.")),
        );

        return;
      }
      final result = await ref
          .read(syncServiceProvider)
          .syncToDevice(
            device: _selectedDevice!,
            tables: _selectedTables.toList(),
          );

      if (!mounted) return;

      _showResult(result);
    } finally {
      if (mounted) {
        setState(() {
          _syncing = false;
        });
      }
    }
  }

  void _showResult(SyncResult result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        icon: Icon(
          result.success ? Icons.check_circle : Icons.error,
          color: result.success ? Colors.green : Colors.red,
          size: 48,
        ),
        title: Text(
          result.success
              ? "Synchronization Complete"
              : "Synchronization Failed",
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(result.message),

            const SizedBox(height: 12),

            Text("Duration: ${result.duration.inSeconds}s"),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
