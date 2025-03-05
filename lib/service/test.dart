import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_ride_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

void main() {
  // Initialize the RidesService singleton with the repository
  RidesService ridesService = RidesService();
  ridesService.initialize(MockRidesRepository());

  // Create a RidePreference object
  RidePreference preference = RidePreference(
    departure: Location(name: "Battambang", country: Country.cambodia),
    departureDate: DateTime.now(),
    arrival: Location(name: "Siem Reap", country: Country.cambodia),
    requestedSeats: 1
  );

  // Use the RidesService singleton instance to get rides
  List<Ride> rides = ridesService.getRides(preference, null);

  // Print the results
  for (Ride ride in rides) {
    print('Ride from ${ride.departureLocation.name} to ${ride.arrivalLocation.name}');
    print('Departure: ${ride.departureDate}');
    print('Arrival: ${ride.arrivalDateTime}');
    print('Driver: ${ride.driver.firstName} ${ride.driver.lastName}');
    print('Available Seats: ${ride.availableSeats}');
    print('Price per Seat: \$${ride.pricePerSeat}');
    print('Duration: ${ride.duration}');
    print('Accept Pets: ${ride.acceptPets.acceptPets}');
    print('---');
  }
}
