import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/dashboard/model/comment_model.dart';
import '../features/dashboard/model/label_model.dart';
import '../features/dashboard/model/project_model.dart';

typedef BuildMethod = Widget Function(BuildContext context, WidgetRef ref);