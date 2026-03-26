import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DefaultSearchableDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String labelText;
  final String hintText;
  final String emptyText;
  final IconData prefixIcon;
  final String Function(T item) itemAsString;
  final bool Function(T item, T selected) compareFn;
  final void Function(T item) onChanged;
  final String? Function(T? item)? validator;
  final Color fillColor;
  final Color focusColor;

  const DefaultSearchableDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.labelText,
    required this.hintText,
    required this.emptyText,
    required this.prefixIcon,
    required this.itemAsString,
    required this.compareFn,
    required this.onChanged,
    this.validator,
    this.fillColor = const Color(0xFFF8FAFD),
    this.focusColor = const Color(0xFF2F80ED),
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      key: key,
      items: (filter, _) {
        if (filter.isEmpty) {
          return items;
        }

        return items
            .where(
              (item) => itemAsString(
                item,
              ).toLowerCase().contains(filter.toLowerCase()),
            )
            .toList();
      },
      selectedItem: selectedItem,
      itemAsString: itemAsString,
      compareFn: compareFn,
      onChanged: (item) {
        if (item != null) {
          onChanged(item);
        }
      },
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        emptyBuilder: (context, searchEntry) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(emptyText),
          ),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: focusColor, width: 1.4),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
