import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'actions.freezed.dart';

@freezed
abstract class SelectMenuItemAction with _$SelectMenuItemAction {
  const factory SelectMenuItemAction(int selectedMenuItem) =
      _SelectMenuItemAction;
}
