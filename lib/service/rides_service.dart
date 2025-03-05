import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';
import '../model/ride/ride_filter.dart';
import '../repository/ride_repository.dart';

class RidesService {
  
  // Singleton instance
  static final RidesService _instance = RidesService._internal();
  late RidesRepository _repository;
  late RidePreference _currentPreference;
  
  factory RidesService() {
    return _instance;
  }


  RidesService._internal();

  // Method to initialize the repository
  void initialize(RidesRepository repository) {
    _repository = repository;
    _currentPreference = RidePreference(
      departure: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now(),
      arrival: Location(name: "Siem Reap", country: Country.cambodia),
      requestedSeats: 1,
    );
  }

  RidePreference getCurrentPreference() {
    return _currentPreference;
  }

  List<Ride> getRides(RidePreference preference, RideFilter? filter) {
    return _repository.getRides(preference, filter);
  }
}