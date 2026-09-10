# Repository Guide (AGENTS.md)

## Project Overview & Structure
Multi-tier e-commerce system (online calendar shop) comprising:
- `backend_api/CalendarShop.Api`: ASP.NET Core Web API (.NET 8, C#).
- `mobile_flutter`: Mobile client (Flutter, Dart SDK `>=3.4.0 <4.0.0`, Riverpod, Freezed, GoRouter).
- `sql/CalendarShopDB.sql`: SQL Server database initialization and demo seed script.
- `docs/`: Detailed guides for development standards (`developer_guide.md`), business rules (`business_rules.md`), and catalog flow (`product_flow_guide.md`).

## Developer Commands & Tooling

### Backend (.NET 8 Web API)
- **Build**: `dotnet build backend_api/CalendarShop.Api/CalendarShop.Api.csproj`
- **Run**: `dotnet run --project backend_api/CalendarShop.Api/CalendarShop.Api.csproj`
- **Local Endpoints**: HTTP `http://localhost:51441`, HTTPS `https://localhost:51440` (Swagger UI at `http://localhost:51441/swagger`)
- **Database setup**: Execute `sql/CalendarShopDB.sql` in SQL Server (SSMS/sqlcmd) to create `CalendarShopDB` and seed test data.
- **Config**: Edit `backend_api/CalendarShop.Api/appsettings.Development.json` for connection strings, SMTP, VNPay, or Local LLM.

### Frontend (Flutter Client)
Execute inside the `mobile_flutter/` directory:
- **Dependencies**: `flutter pub get`
- **Code Generation** (Mandatory after creating/editing Freezed models or Riverpod providers):
  `dart run build_runner build --delete-conflicting-outputs`
- **Static Analysis**: `flutter analyze`
- **Run Application**: `flutter run`

## Architecture & Layering Rules

### Backend Layering
- **Flow**: `Controller -> Service -> Repository (IRepository<T>) -> AppDbContext -> SQL Server`.
- **Controllers** (`Controllers/`): HTTP endpoints only. Handle routing, authorization (`[Authorize]`), and dynamic OData query enablement (`[EnableQuery]`). **Never** inject `AppDbContext` or `IRepository<T>` into Controllers.
- **Services** (`Services/`): 100% business logic.
  - **Never** inject `AppDbContext` directly (use `IRepository<T>`).
  - **Never** return HTTP status codes; throw exceptions on failure (handled by `GlobalExceptionHandler` returning RFC 7807 `ProblemDetails`).
  - Return `IQueryable<TDto>` using AutoMapper `.ProjectTo<TDto>(_mapper.ConfigurationProvider)` for deferred OData execution.
- **Repositories** (`Repositories/`): Provide deferred queries via the `Entities` property (`IQueryable<T>`).
- **Validation**: FluentValidation classes in `Validators/` execute automatically on incoming requests.

### Frontend Architecture (Clean Architecture & Feature-First)
Features are located under `mobile_flutter/lib/features/<feature>/`:
- **Domain Layer** (`domain/`): Pure Dart entities (`entities/`), abstract repository interfaces (`repositories/`), and use cases (`usecases/`). Completely decoupled from Dio, JSON parsers, and external UI frameworks.
- **Data Layer** (`data/`): Remote datasources (`datasources/` using Dio `ApiClient`), DTO models (`models/` with `@freezed`), and repository implementations (`repositories/`).
  - **Boundary Rule**: Repository implementations **must** map DTO models to Domain Entities using `.toEntity()` before returning data to the presentation layer.
- **Presentation Layer** (`presentation/`): Riverpod providers (`providers/`), screens (`pages/`), and UI widgets (`widgets/`).
- **State Management**: State must be immutable, updated via Freezed `.copyWith()`, managed with Riverpod annotations (`@riverpod`).

## Operational Gotchas & Conventions

- **API Base URL Resolution**: `ApiConstants.baseUrl` dynamically routes `http://10.0.2.2:51441/api` for Android emulators and `http://localhost:51441/api` for iOS/Web/Desktop. Physical devices require host LAN IP.
- **Authentication & Email Flow**:
  - Newly registered users start in `Pending` status with `IsEmailConfirmed = false` and cannot log in until confirmed.
  - If `Email.Enabled = false` in `appsettings.Development.json`, tokens are logged to the console instead of dispatched via SMTP.
  - `ApiClient` Dio interceptor automatically handles JWT token attachment and HTTP 401 refresh token flow.
- **Default Seed Accounts**:
  - Admin: `admin@calendarshop.com` / `123456`
  - Customer: `customer@gmail.com` / `123456`
- **Soft Deletion & Visibility**:
  - Products and Reviews use soft deletion (`IsDeleted = true`, `Status = "Hidden"`).
  - Hiding or deleting a Category automatically cascades `Status = "Hidden"` to active products within that category.
- **Order Price Snapshots**:
  - Order items snapshot historical prices (`UnitPrice`, `TotalPrice`) and discounts at checkout.
  - VNPay orders pending payment automatically expire after 15 minutes via `VNPayPendingOrderCleanupService`.
