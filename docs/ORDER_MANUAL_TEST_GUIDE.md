# Order Feature Manual Test Guide

Tài liệu này cung cấp hướng dẫn chi tiết để setup môi trường và thực hiện kiểm thử thủ công (manual testing) cho tính năng **Order** trong dự án **Calendar Shop**.

---

## 1. Required Environment

| Component | Requirement |
|---|---|
| **Flutter version** | SDK ≥ 3.4.0 (Runtime 3.11.0) |
| **Dart version** | ≥ 3.4.0 |
| **Backend framework**| ASP.NET Core 8.0 Web API |
| **Database** | SQL Server |

### Required Tools
- Android Studio / VS Code (for Flutter development)
- Android Emulator / iOS Simulator / Physical Device
- Visual Studio / Rider (for Backend development)
- SQL Server Management Studio (SSMS) or Azure Data Studio

---

## 2. How To Start Backend

**Bước 1: Mở project backend**
- Mở thư mục `backend_api/CalendarShop.Api` bằng Visual Studio hoặc command line.

**Bước 2: Cấu hình Database**
- Kiểm tra file `appsettings.Development.json`.
- Đảm bảo `ConnectionStrings:DefaultConnection` trỏ đúng đến SQL Server local của bạn.
  - Ví dụ mặc định: `Server=ADMIN\SQL2022;Database=CalendarShopDB;Trusted_Connection=True;TrustServerCertificate=True`

**Bước 3: Chạy Migration (Nếu cần)**
Nếu database chưa được tạo, chạy lệnh sau:
```bash
dotnet ef database update
```
*(Lưu ý: Nếu file SQL đã có sẵn trong thư mục `sql/CalendarShopDB.sql`, bạn có thể chạy file này trực tiếp trong SSMS).*

**Bước 4: Khởi chạy API**
```bash
dotnet run --launch-profile Development
```

**Expected Result:**
```
API running at: http://localhost:5000 hoặc https://localhost:5001
```

---

## 3. How To Start Flutter

**Bước 1: Mở thư mục Flutter**
```bash
cd mobile_flutter
```

**Bước 2: Tải dependencies**
```bash
flutter pub get
```

**Bước 3: Chạy build_runner**
Tạo các file code-generation (cho Freezed, Riverpod, JSON Serializable):
```bash
dart run build_runner build --delete-conflicting-outputs
```

**Bước 4: Chạy ứng dụng**
Khởi chạy trên Emulator/Device đã bật:
```bash
flutter run
```

**Expected Result:**
App opens successfully trên thiết bị giả lập hoặc máy thật và hiển thị màn hình Login.

---

## 4. Test Account Setup

**Flow xác thực hiện tại:** App sử dụng JWT token cho API authentication.

**Cách 1: Đăng nhập bằng tài khoản có sẵn (Khuyên dùng)**
- Tại màn hình Login (Route `/login`), nhập email và password của tài khoản test đã được tạo sẵn trong Database (Bảng `Users`).
- *Lưu ý: Bạn có thể xem danh sách user trong bảng `dbo.Users` qua SSMS.*

**Cách 2: Đăng ký tài khoản mới**
- Chuyển sang màn hình Register (Route `/register`).
- Điền đầy đủ thông tin (Tên, Email, Phone, Password).
- Nhấn "Đăng ký". App sẽ tự động login và lưu token.

---

# ORDER FEATURE MANUAL TEST

Dưới đây là các kịch bản kiểm thử thủ công cho quy trình Order.

---

## TEST 1 — Create Order

**Pre-condition:** User đã đăng nhập thành công.

**Steps:**
1. Mở danh sách sản phẩm (Product List).
2. Chọn sản phẩm và nhấn **Add to cart**.
3. Chuyển đến giỏ hàng, chọn sản phẩm cần mua và nhấn **Checkout**.
4. Điền thông tin giao hàng, chọn phương thức thanh toán.
5. Nhấn **Confirm order** (Đặt hàng).

**Expected:**
- Ứng dụng thông báo "Order created successfully" hoặc chuyển sang màn hình chi tiết đơn hàng mới tạo.
- **Database check:**
  - `dbo.Orders`: Bản ghi mới được tạo với `Status = 'Pending'`.
  - `dbo.OrderItems`: Bản ghi chi tiết các sản phẩm tương ứng với `OrderId` vừa tạo.

---

## TEST 2 — Order History

**Steps:**
1. Login vào app.
2. Từ trang chủ / danh sách sản phẩm, nhấn vào icon **Profile / Tài khoản** (hoặc icon Receipt trên AppBar).
3. Chọn menu **Orders / Đơn hàng của tôi**.

**Verify:**
- List đơn hàng xuất hiện.
- Trên mỗi card hiển thị đầy đủ:
  - Order ID (VD: #ORD001)
  - Date (Ngày đặt)
  - Total (Tổng tiền)
  - Status (Trạng thái với màu sắc tương ứng)

**Expected screenshot:** `order_history.png`

---

## TEST 3 — Order Detail

**Steps:**
1. Từ màn hình Order History, tap vào một order card bất kỳ.

**Verify:**
- Navigate mượt mà sang trang `/orders/{id}`.
- Order number hiển thị đúng.
- Customer info (Tên, SDT) hiển thị đúng.
- Shipping address chính xác.
- Product list (Danh sách sản phẩm): đúng tên, hình ảnh (nếu có).
- Quantity (Số lượng) và Price (Đơn giá) từng món chính xác.
- Payment summary (Tạm tính, phí ship, giảm giá, Tổng tiền cuối) chính xác.

**Expected screenshot:** `order_detail.png`

---

## TEST 4 — Order Tracking

**Steps:**
Test UI timeline thay đổi tương ứng với mỗi trạng thái đơn hàng. (Có thể dùng API Admin hoặc sửa trực tiếp DB field `Status`).

**Test each status:**
1. **Pending**: Mở chi tiết đơn, kiểm tra bước "Chờ xác nhận" đang active.
2. **Confirmed**: Đổi status -> Mở chi tiết -> Bước 2 active.
3. **Shipping**: Đổi status -> Mở chi tiết -> Bước 3 active.
4. **Delivered**: Đổi status -> Mở chi tiết -> Cả 4 bước màu xanh (completed).
5. **Cancelled**: Đổi status -> Mở chi tiết -> Hiển thị flow rút gọn (Pending -> Cancelled màu đỏ).

**Verify:**
- Timeline UI changes correctly and highlights the current status.

**Expected screenshots:**
`tracking_pending.png`, `tracking_shipping.png`, `tracking_delivered.png`, `tracking_cancelled.png`

---

## TEST 5 — Cancel Order

### Scenario A: Order status is Pending
**Steps:**
1. Mở detail của đơn hàng đang có trạng thái `Pending`.
2. Click nút **Hủy đơn hàng** (màu đỏ) ở dưới cùng.
3. Trong Dialog hiện lên, enter reason (VD: "Không cần nữa").
4. Nhấn **Xác nhận hủy**.

**Expected:**
- Status changes: `Pending` -> `Cancelled`.
- Thông báo snackbar "Hủy đơn hàng thành công".
- Tracking UI update sang dạng Cancelled.

### Scenario B: Order status is Shipping
**Steps:**
1. Mở detail của đơn hàng đang có trạng thái `Shipping` (hoặc `Confirmed`, `Delivered`).

**Expected:**
- Nút **Hủy đơn hàng** bị ẩn hoàn toàn (Cancel button hidden).

---

## TEST 6 — API Testing

Danh sách các API endpoints được sử dụng cho tính năng Order.

| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/api/orders` | Create new order (checkout) |
| `GET` | `/api/orders/mine` | Lấy danh sách đơn hàng của user |
| `GET` | `/api/orders/{id}` | Lấy chi tiết đơn hàng |
| `PUT` | `/api/orders/{id}/cancel` | Hủy đơn hàng (khi Pending) |

### Ví dụ API Cancel: `PUT /api/orders/{id}/cancel`
- **Request Headers:** `Authorization: Bearer <token>`
- **Request Body:**
  ```json
  {
    "reason": "Khách đổi ý"
  }
  ```
- **Expected Result:** Trả về HTTP Status `204 No Content` nếu thành công. `400 Bad Request` nếu trạng thái không phải Pending.

---

## TEST 7 — Database Verification

Sử dụng SSMS để truy vấn DB và verify data tính toàn vẹn dữ liệu.

**Tables:** `dbo.Orders`, `dbo.OrderItems`

**Check:**
1. **Created order exists:**
   ```sql
   SELECT TOP 1 * FROM Orders ORDER BY CreatedAt DESC;
   ```
2. **Status changed:** Sau khi thao tác Hủy, verify status update:
   ```sql
   SELECT Status, CancelReason FROM Orders WHERE OrderId = {Id};
   ```
   -> Trạng thái phải là `Cancelled` và `CancelReason` phải chứa lý do đã nhập.
3. **Items matched:**
   ```sql
   SELECT * FROM OrderItems WHERE OrderId = {Id};
   ```

---

## TEST 8 — Common Errors

| Issue | Cause | Solution |
|---|---|---|
| **API cannot connect** | Backend chưa chạy hoặc IP Emulator sai | Chạy lại `dotnet run`. Nếu dùng Android emulator, cấu hình API URL thành `10.0.2.2`. |
| **Token expired / 401 Unauthorized** | JWT đã hết hạn | App sẽ tự refresh token. Nếu không được, hãy Logout và Login lại. |
| **Empty order list** | Tài khoản chưa có đơn hàng nào | Màn hình sẽ hiện Empty State. Hãy quay lại trang Products để đặt hàng. |
| **Build runner error** | Conflict file code-generation | Chạy lại lệnh với cờ `--delete-conflicting-outputs`. |
| **Database connection error** | Tên Server SQL hoặc thông tin authen sai | Sửa chuỗi kết nối trong `appsettings.Development.json` cho phù hợp với máy local. |

---

## FINAL CHECKLIST

Vui lòng điền kết quả vào bảng dưới đây sau khi chạy test thủ công.

| Function | Result |
|---|---|
| Login | |
| Create Order | |
| Order History | |
| Order Detail | |
| Tracking | |
| Cancel Order | |
