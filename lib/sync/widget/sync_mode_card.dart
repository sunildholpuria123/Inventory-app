import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/sync_operation.dart';

class SyncModeCard extends ConsumerStatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final SyncOperation operation;

  const SyncModeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.operation,
  });

  @override
  ConsumerState<SyncModeCard> createState() => _SyncModeCardState();
}

class _SyncModeCardState extends ConsumerState<SyncModeCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 700;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (isDesktop) {
          setState(() => _hover = true);
        }
      },
      onExit: (_) {
        if (isDesktop) {
          setState(() => _hover = false);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            _hover ? -4.0 : 0.0,
          ),
        child: Card(
          elevation: _hover ? 8 : 1,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: InkWell(
            onTap: () {
              switch (widget.operation) {
                case SyncOperation.send:
                // TODO:
                // Navigator.push(...)
                  break;

                case SyncOperation.receive:
                // TODO:
                // Navigator.push(...)
                  break;

                case SyncOperation.twoWay:
                // TODO:
                // Navigator.push(...)
                  break;
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration:
                    const Duration(milliseconds: 180),
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(.12),
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.color,
                      size: 30,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                          color: widget.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Icon(
                        Icons.arrow_forward,
                        color: widget.color,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}