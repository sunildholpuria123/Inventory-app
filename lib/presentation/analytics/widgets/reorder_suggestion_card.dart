import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/smart_reorder_provider.dart';

class ReorderSuggestionCard
    extends ConsumerWidget {
  const ReorderSuggestionCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final reorder =
    ref.watch(
      smartReorderProvider,
    );

    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: reorder.when(
          data: (items) {
            if (items.isEmpty) {
              return Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Smart Reorder Suggestions',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Center(
                    child: Text(
                      'No Products Need Reordering',
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Reorder Suggestions',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge,
                ),

                const SizedBox(
                  height: 20,
                ),

                ...items
                    .take(5)
                    .map(
                      (item) => Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: Container(
                      padding:
                      const EdgeInsets.all(
                        12,
                      ),
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                          12,
                        ),
                        color:
                        Colors.orange
                            .withOpacity(
                          0.08,
                        ),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(
                              Icons
                                  .inventory_2,
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Text(
                                  item.productName,
                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                Text(
                                  'Current Stock : ${item.stock}',
                                ),

                                Text(
                                  'Suggested Order : ${item.suggestedQty}',
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            Icons
                                .warning_amber_rounded,
                            color:
                            Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },

          loading:
              () => const SizedBox(
            height: 120,
            child: Center(
              child:
              CircularProgressIndicator(),
            ),
          ),

          error: (e, _) {
            return SizedBox(
              height: 120,
              child: Center(
                child: Text(
                  e.toString(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}