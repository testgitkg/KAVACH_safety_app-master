import '../../../core/app_export.dart';

/// This class is used in the [chipview_item_widget] screen.
class ChipviewItemModel {
  ChipviewItemModel({
    this.history,
    this.isSelected,
  }) {
    history = history ?? "History";
    isSelected = isSelected ?? false;
  }

  String? history;

  bool? isSelected;
}
