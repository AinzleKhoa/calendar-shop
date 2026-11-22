import '../../domain/repositories/address_repository.dart';

// Lớp SetDefaultAddressUseCase giữ trách nhiệm chính của file này.
class SetDefaultAddressUseCase {
  final AddressRepository repository;
  SetDefaultAddressUseCase(this.repository);

  Future<void> call(int id) => repository.setDefaultAddress(id);
}
