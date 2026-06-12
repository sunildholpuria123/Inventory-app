import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) => 1);

final pageSizeProvider = StateProvider<int>((ref) => 20);
