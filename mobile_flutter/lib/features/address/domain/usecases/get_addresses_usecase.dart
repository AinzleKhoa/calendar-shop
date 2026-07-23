import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';

// Lớp GetAddressesUseCase giữ trách nhiệm chính của file này.
class GetAddressesUseCase {
  final AddressRepository repository;
  GetAddressesUseCase(this.repository);

  Future<List<Address>> call() => repository.getAddresses();
}
