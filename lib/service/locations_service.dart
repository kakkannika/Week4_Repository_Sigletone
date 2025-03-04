import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';
class LocationsService {
  final LocationsRepository repository;

  LocationsService(this.repository);

  List<Location> getAvailableLocations() {
    return repository.getLocations(); 
    // Fetch locations from the repository
  }
}
