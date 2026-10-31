import 'package:flutter/material.dart';
import '../../modules/viewmodel/searchscreenviewmodel.dart';

class FilterSheet extends StatefulWidget {
  final Searchscreenviewmodel controller;
  const FilterSheet({super.key, required this.controller});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  static const navy = Colors.green;
  static const tabs = ['Divisions', 'Suppliers', 'Categories'];

  int tab = 0;
  late Set<String> divisions, suppliers, categories;

  @override
  void initState() {
    super.initState();
    final c = widget.controller;
    divisions = {...c.selectedDivisions};
    suppliers = {...c.selectedSuppliers};
    categories = {...c.selectedCategories};
  }

  // List<String> get _options {
  //   final c = widget.controller;
  //   switch (tab) {
  //     case 0:
  //       return c.divisionOptions;
  //     case 1:
  //       return c.suppliers.map((e) => e.name).toList();
  //     default:
  //       return c.categories.map((e) => e.name).toList();
  //   }
  // }
  List<String> get _options {
    final c = widget.controller;
    switch (tab) {
      case 0:
        return c.divisions.map((e) => e.name).toList();
      case 1:
        return c.suppliers.map((e) => e.name).toList();
      default:
        return c.categorieschips.map((e) => e.name).toList();
    }
  }

  Set<String> get _current =>
      tab == 0 ? divisions : (tab == 1 ? suppliers : categories);

  @override
  Widget build(BuildContext context) {
    final options = _options;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: [
          // header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Filters',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    divisions.clear();
                    suppliers.clear();
                    categories.clear();
                  }),
                  child: const Text('Clear all'),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // body: tabs on the left, options on the right
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 120,
                  color: const Color(0xFFF7F8FA),
                  child: ListView.builder(
                    itemCount: tabs.length,
                    itemBuilder: (_, i) {
                      final selected = tab == i;
                      return InkWell(
                        onTap: () => setState(() => tab = i),
                        child: Container(
                          color: selected ? Colors.white : null,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          child: Text(
                            tabs[i],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: selected ? navy : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: ListView(
                    children: [
                      CheckboxListTile(
                        value: _current.isEmpty,
                        activeColor: navy,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('All ${tabs[tab]}',
                            style: const TextStyle(fontWeight: FontWeight.w700)),
                        onChanged: (_) => setState(_current.clear),
                      ),
                      for (final o in options)
                        CheckboxListTile(
                          value: _current.contains(o),
                          activeColor: navy,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(o),
                          onChanged: (_) => setState(() {
                            _current.contains(o)
                                ? _current.remove(o)
                                : _current.add(o);
                          }),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // footer
          const Divider(height: 1),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    widget.controller.applyFilters(divisions, suppliers, categories);
                    Navigator.pop(context);
                  },
                  child: const Text('Show results',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}