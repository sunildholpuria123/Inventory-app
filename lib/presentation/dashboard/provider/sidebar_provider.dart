import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sidebar_menu.dart';

final sidebarMenuProvider = StateProvider<SidebarMenu>((ref) {
  return SidebarMenu.dashboard;
});
