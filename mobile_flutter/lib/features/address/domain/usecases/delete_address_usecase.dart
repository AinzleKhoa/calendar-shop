import '../../domain/repositories/address_repository.dart';

// Lớp DeleteAddressUseCase giữ trách nhiệm chính của file này.
class DeleteAddressUseCase {
  final AddressRepository repository;
  DeleteAddressUseCase(this.repository);

  Future<void> call(int id) => repository.deleteAddress(id);
}
