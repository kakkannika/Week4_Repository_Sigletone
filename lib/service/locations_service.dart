import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/location_repository.dart';

class LocationsService {
  static final LocationsService _instance = LocationsService._internal();
  late LocationsRepository _repository;

  LocationsService._internal();

  factory LocationsService() {
    return _instance;
  }

  void initialize(LocationsRepository repository) {
    _repository = repository;
  }

  List<Location> getAvailableLocations() {
    return _repository.getLocations(); 
    // Fetch locations from the repository
  }
}