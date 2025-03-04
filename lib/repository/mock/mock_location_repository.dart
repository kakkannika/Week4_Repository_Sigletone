import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';

class MockLocationsRepository implements LocationsRepository {
  @override
  List<Location> getLocations() {
    return [
      Location(name: 'Phnom Penh', country: Country.cambodia),
      Location(name: 'Siem Reap', country: Country.cambodia),
      Location(name: 'Battambang', country: Country.cambodia),
      Location(name: 'Sihanoukville', country: Country.cambodia),
      Location(name: 'Kampot', country: Country.cambodia),
    ];
 
    
  }
}