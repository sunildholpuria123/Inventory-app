import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../core/provider/network_provider.dart';
import '../model/database_statistics.dart';
import '../model/pending_sync_request.dart';
import '../model/sync_device.dart';
import '../model/sync_progress.dart';
import '../model/sync_result.dart';
import '../model/sync_role.dart';
import '../model/sync_status.dart';
import '../model/sync_table.dart';
import '../model/trusted_device.dart';
import '../provider/device_provider.dart';
import '../provider/sync_provider.dart';

class SyncScreen extends ConsumerStatefulWidget {
  const SyncScreen({super.key});

  @override
  ConsumerState<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends ConsumerState<SyncScreen> {
  //------------------------------------------------------------
  // Selected Tables
  //------------------------------------------------------------

  final Set<SyncTable> _selectedTables = {
    SyncTable.customers,
    SyncTable.suppliers,
    SyncTable.products,
    SyncTable.invoices,
    SyncTable.invoiceItems,
    SyncTable.payments,
    SyncTable.expenses,
    SyncTable.category,
    SyncTable.businessSetting,
  };

  //------------------------------------------------------------
  // State
  //------------------------------------------------------------

  List<SyncDevice> _devices = [];

  SyncDevice? _selectedDevice;

  SyncProgress _progress = SyncProgress.idle();

  bool _searching = false;

  bool _syncing = false;

  //------------------------------------------------------------
  // Subscriptions
  //------------------------------------------------------------

  StreamSubscription<List<SyncDevice>>? _deviceSubscription;

  StreamSubscription<SyncProgress>? _progressSubscription;

  StreamSubscription<PendingSyncRequest>? _requestSubscription;

  //------------------------------------------------------------
  // Init
  //------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  //------------------------------------------------------------
  // Initialize
  //------------------------------------------------------------

  Future<void> _initialize() async {
    final deviceService = ref.read(deviceServiceProvider);

    final syncService = ref.read(syncServiceProvider);

    //--------------------------------------------------------
    // Current Device
    //--------------------------------------------------------

    final currentDevice = await deviceService.getCurrentDevice(port: 40402);

    await syncService.start(currentDevice: currentDevice);

    //--------------------------------------------------------
    // Device Stream
    //--------------------------------------------------------

    _deviceSubscription = syncService.devices.listen((devices) {
      if (!mounted) return;

      setState(() {
        _devices = devices;
      });
    });

    //--------------------------------------------------------
    // Progress Stream
    //--------------------------------------------------------

    _progressSubscription = syncService.progress.listen((progress) {
      if (!mounted) return;

      setState(() {
        _progress = progress;
      });
    });

    //--------------------------------------------------------
    // Incoming Request
    //--------------------------------------------------------

    _requestSubscription = syncService.pendingRequests.listen((request) async {
      if (!mounted) return;

      await _showPermissionDialog(request);
    });

    //--------------------------------------------------------
    // Auto Search (Sender Only)
    //--------------------------------------------------------

    final role = ref.read(syncRoleProvider);

    if (role == SyncRole.sender) {
      await syncService.searchDevices();
    }
  }

  //------------------------------------------------------------
  // Dispose
  //------------------------------------------------------------

  @override
  void dispose() {
    _deviceSubscription?.cancel();

    _progressSubscription?.cancel();

    _requestSubscription?.cancel();

    super.dispose();
  }
  Future<void> _searchDevices() async {
    if (_searching) return;

    setState(() {
      _searching = true;
      _devices.clear();
      _selectedDevice = null;
    });

    try {
      final syncService = ref.read(syncServiceProvider);

      await syncService.searchDevices();

      // Wait for responses from nearby devices
      await Future.delayed(const Duration(seconds: 3));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Search failed: $e")));
    } finally {
      if (mounted) {
        setState(() {
          _searching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final statistics = ref.watch(syncStatisticsProvider);

    final role = ref.watch(syncRoleProvider);

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
          if (isDesktop) {
            return _buildDesktop(stats, role);
          }

          return _buildMobile(stats, role);
        },
      ),
    );
  }

  Widget _buildDesktop(DatabaseStatistics stats, SyncRole role) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (role == SyncRole.sender) _buildStatistics(stats),

              if (role == SyncRole.sender) const SizedBox(height: 20),

              if (role == SyncRole.sender) _buildModules(),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildRoleCard(role),

              const SizedBox(height: 20),

              _buildDeviceSection(),

              const SizedBox(height: 20),

              _buildProgress(),

              if (role == SyncRole.sender) ...[
                const SizedBox(height: 20),

                _buildSyncButton(),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(DatabaseStatistics stats, SyncRole role) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildRoleCard(role),

        const SizedBox(height: 16),

        if (role == SyncRole.sender) _buildStatistics(stats),

        if (role == SyncRole.sender) const SizedBox(height: 16),

        _buildDeviceSection(),

        if (role == SyncRole.sender) ...[
          const SizedBox(height: 16),

          _buildModules(),
        ],

        const SizedBox(height: 16),

        _buildProgress(),

        if (role == SyncRole.sender) ...[
          const SizedBox(height: 16),

          _buildSyncButton(),
        ],
      ],
    );
  }

  Widget _buildRoleCard(SyncRole role) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Synchronization Mode",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 12),

            RadioListTile<SyncRole>(
              value: SyncRole.sender,
              groupValue: role,
              title: const Text("Sender"),
              onChanged: (value) async {
                if (value == null) return;

                ref.read(syncRoleProvider.notifier).state = value;

                setState(() {
                  _selectedDevice = null;
                });

                if (value == SyncRole.sender) {
                  await _searchDevices();
                }
              },
            ),

            RadioListTile<SyncRole>(
              value: SyncRole.receiver,
              groupValue: role,
              title: const Text("Receiver"),
              onChanged: (value) {
                if (value == null) return;

                ref.read(syncRoleProvider.notifier).state = value;

                setState(() {
                  _selectedDevice = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(DatabaseStatistics stats) {
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
            _buildStatRow(Icons.category, "Categories", stats.category),
            _buildStatRow(Icons.inventory_2, "Products", stats.products),
            _buildStatRow(Icons.receipt_long, "Invoices", stats.invoices),
            _buildStatRow(Icons.list_alt, "Invoice Items", stats.invoiceItems),
            _buildStatRow(Icons.payments, "Payments", stats.payments),
            _buildStatRow(Icons.money_off, "Expenses", stats.expenses),
            _buildStatRow(
              Icons.business,
              "Business Settings",
              stats.businessSetting,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 22),

          const SizedBox(width: 12),

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
    final role = ref.watch(syncRoleProvider);

    if (role == SyncRole.receiver) {
      return Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const CircularProgressIndicator(),

              const SizedBox(height: 20),

              Text(
                "Receiver Mode",
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 12),

              const Text(
                "Waiting for synchronization requests...",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                "Keep this screen open.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }

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

            if (_searching) ...[
              const LinearProgressIndicator(),

              const SizedBox(height: 12),

              const Text("Searching nearby devices..."),
            ],

            if (!_searching && _devices.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.devices_other,
                        size: 64,
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
        leading: CircleAvatar(
          child: Icon(
            device.isDesktop ? Icons.desktop_windows : Icons.phone_android,
          ),
        ),

        title: Text(device.name),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(device.ip),

            Text(device.isDesktop ? "Desktop" : "Mobile"),
          ],
        ),

        trailing: selected
            ? const Icon(Icons.check_circle, color: Colors.green)
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

  Widget _buildModules() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modules to Synchronize",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 16),

            ...SyncTable.values.map((table) {
              return CheckboxListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                value: _selectedTables.contains(table),
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
      case SyncTable.category:
        return "Categories";
      case SyncTable.invoices:
        return "Invoices";
      case SyncTable.invoiceItems:
        return "Invoice Items";
      case SyncTable.payments:
        return "Payments";
      case SyncTable.expenses:
        return "Expenses";
      case SyncTable.businessSetting:
        return "Business Settings";
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

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _progress.progress,
                minHeight: 10,
              ),
            ),

            const SizedBox(height: 20),

            Text(_progress.message.isEmpty ? "Ready" : _progress.message),

            const SizedBox(height: 8),

            Text(
              "${(_progress.progress * 100).toStringAsFixed(0)}%",
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
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.sync),
        label: Text(_syncing ? "Synchronizing..." : "Start Synchronization"),
        onPressed:
            _syncing || _selectedDevice == null || _selectedTables.isEmpty
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
        throw Exception("No network connection");
      }

      final result = await ref
          .read(syncServiceProvider)
          .syncToDevice(
            device: _selectedDevice!,
            tables: _selectedTables.toList(),
          );

      if (!mounted) return;

      _showResult(result);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
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
      builder: (_) {
        return AlertDialog(
          icon: Icon(
            result.success ? Icons.check_circle : Icons.error,
            color: result.success ? Colors.green : Colors.red,
            size: 48,
          ),
          title: Text(
            result.success
                ? "Synchronization Completed"
                : "Synchronization Failed",
          ),
          content: Text(result.message),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPermissionDialog(PendingSyncRequest request) async {
    bool trust = false;

    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("${request.sender.name} wants to synchronize"),
              content: SizedBox(
                width: 350,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...request.tables.map(
                        (e) => ListTile(
                          dense: true,
                          leading: const Icon(Icons.check),
                          title: Text(e.name),
                        ),
                      ),

                      const Divider(),

                      CheckboxListTile(
                        value: trust,
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Always trust this device"),
                        onChanged: (v) {
                          setDialogState(() {
                            trust = v ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text("Reject"),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text("Accept"),
                ),
              ],
            );
          },
        );
      },
    );

    final syncService = ref.read(syncServiceProvider);

    if (accepted == true) {
      if (trust) {
        await ref
            .read(trustedDeviceServiceProvider)
            .addTrusted(
              TrustedDevice(
                deviceId: request.sender.id,
                deviceName: request.sender.name,
              ),
            );
      }

      await syncService.acceptRequest();
    } else {
      await syncService.rejectRequest();
    }
  }

}
