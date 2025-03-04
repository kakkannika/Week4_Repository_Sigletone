import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';

import '../../service/locations_service.dart';
import '../../repository/mock/mock_location_repository.dart';
import '../../theme/theme.dart';

/// This full-screen modal is in charge of providing (if confirmed) a selected location.
class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation; 

  const BlaLocationPicker({super.key, this.initLocation});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filteredLocations = []; // Start with an empty list
  late LocationsService locationsService;

  // Initialize the Form attributes
  @override
  void initState() {
    super.initState();

    // Initialize LocationsService with MockLocationsRepository
    locationsService = LocationsService(MockLocationsRepository());

    // Initially empty list, but you can fetch locations if needed
    // filteredLocations = locationsService.getAvailableLocations(); // Optional: fetch all locations initially if you want
  }

  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void onSearchChanged(String searchText) {
    List<Location> newSelection = [];

    if (searchText.length > 1) {
      // Start searching after 2 characters
      newSelection = getLocationsFor(searchText);
      print("Search text: $searchText, Results: ${newSelection.length}");
    } else {
      print("Search text too short: $searchText");
    }

    setState(() {
      filteredLocations = newSelection;
    });
  }

  List<Location> getLocationsFor(String text) {
    var locations = locationsService.getAvailableLocations();
    print("Available locations: ${locations.length}");
    return locations
        .where((location) =>
            location.name.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          BlaSearchBar(
            onBackPressed: onBackSelected,
            onSearchChanged: onSearchChanged,
          ),

          Expanded(
            child: filteredLocations.isEmpty
                ? Center()
                : ListView.builder(
                    itemCount: filteredLocations.length,
                    itemBuilder: (ctx, index) => LocationTile(
                      location: filteredLocations[index],
                      onSelected: onLocationSelected,
                    ),
                  ),
          ),
        ],
      ),
    ));
  }
}

/// This tile represents an item in the list of past entered ride inputs
class LocationTile extends StatelessWidget {
  final Location location;
  final Function(Location location) onSelected;

  const LocationTile(
      {super.key, required this.location, required this.onSelected});

  String get title => location.name;

  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(title,
          style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
      subtitle: Text(subTitle,
          style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),
    );
  }
}

/// The Search bar combines the search input + the navigation back button
/// A clear button appears when search contains some text.
class BlaSearchBar extends StatefulWidget {
  const BlaSearchBar(
      {super.key, required this.onSearchChanged, required this.onBackPressed});

  final Function(String text) onSearchChanged;
  final VoidCallback onBackPressed;

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool get searchIsNotEmpty => _controller.text.isNotEmpty;

  void onChanged(String newText) {
    // Notify the listener
    widget.onSearchChanged(newText);

    // Update the cross icon
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius:
            BorderRadius.circular(BlaSpacings.radius), // Rounded corners
      ),
      child: Row(
        children: [
          // Left icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: widget.onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios,
                color: BlaColors.iconLight,
                size: 16,
              ),
            ),
          ),

          Expanded(
            child: TextField(
              focusNode: _focusNode, 
              onChanged: onChanged,
              controller: _controller,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none, 
                filled: false, 
              ),
            ),
          ),

          searchIsNotEmpty 
              ? IconButton(
                  icon: Icon(Icons.close, color: BlaColors.iconLight),
                  onPressed: () {
                    _controller.clear();
                    _focusNode.requestFocus(); 
                    onChanged("");
                  },
                )
              : SizedBox.shrink(), 
        ],
      ),
    );
  }
}
