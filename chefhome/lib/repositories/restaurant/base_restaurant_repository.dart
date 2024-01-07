import '/models/models.dart';

abstract class BaseRestaurantRepository {
  Future<void> addRestaurant(Restaurant restaurant);
  Future<void> editRestaurantSettings(Restaurant restaurant);
  Future<void> editProducts(List<Product> products);
  Stream<Restaurant> getRestaurant();
}
