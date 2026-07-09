// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRemoteDataSourceHash() =>
    r'e4631a895194d2a40c472c241f00e7e5cc8f0bdd';

/// See also [orderRemoteDataSource].
@ProviderFor(orderRemoteDataSource)
final orderRemoteDataSourceProvider =
    AutoDisposeProvider<OrderRemoteDataSource>.internal(
  orderRemoteDataSource,
  name: r'orderRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderRemoteDataSourceRef
    = AutoDisposeProviderRef<OrderRemoteDataSource>;
String _$orderRepositoryHash() => r'77c8b92481f0b42f91837683ebded09a97aa5bca';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = AutoDisposeProvider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderRepositoryRef = AutoDisposeProviderRef<OrderRepository>;
String _$getMyOrdersUseCaseHash() =>
    r'cb5a84d5b373c9be06813f4f2b7fe22d40c91cf2';

/// See also [getMyOrdersUseCase].
@ProviderFor(getMyOrdersUseCase)
final getMyOrdersUseCaseProvider =
    AutoDisposeProvider<GetMyOrdersUseCase>.internal(
  getMyOrdersUseCase,
  name: r'getMyOrdersUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMyOrdersUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMyOrdersUseCaseRef = AutoDisposeProviderRef<GetMyOrdersUseCase>;
String _$getOrderDetailUseCaseHash() =>
    r'f6c6575732df64b563ac93333738ae9ec2095dbe';

/// See also [getOrderDetailUseCase].
@ProviderFor(getOrderDetailUseCase)
final getOrderDetailUseCaseProvider =
    AutoDisposeProvider<GetOrderDetailUseCase>.internal(
  getOrderDetailUseCase,
  name: r'getOrderDetailUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getOrderDetailUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetOrderDetailUseCaseRef
    = AutoDisposeProviderRef<GetOrderDetailUseCase>;
String _$cancelOrderUseCaseHash() =>
    r'fc8e6c04fa5848b664838936c853e31111f1d68c';

/// See also [cancelOrderUseCase].
@ProviderFor(cancelOrderUseCase)
final cancelOrderUseCaseProvider =
    AutoDisposeProvider<CancelOrderUseCase>.internal(
  cancelOrderUseCase,
  name: r'cancelOrderUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cancelOrderUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CancelOrderUseCaseRef = AutoDisposeProviderRef<CancelOrderUseCase>;
String _$orderNotifierHash() => r'3e5abfc5d556c3ddf9189cd7dd3f486be665dafa';

/// See also [OrderNotifier].
@ProviderFor(OrderNotifier)
final orderNotifierProvider =
    AutoDisposeNotifierProvider<OrderNotifier, OrderState>.internal(
  OrderNotifier.new,
  name: r'orderNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderNotifier = AutoDisposeNotifier<OrderState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
