# ⌨️ AULA S75 Pro Driver - Fixed 2.4GHz Wireless Connection

Bản driver / phần mềm điều khiển cho bàn phím cơ **AULA S75 Pro** (hoặc các phiên bản OEM tương đương trang bị màn hình TFT và núm xoay) đã được **sửa lỗi (fixed) để nhận diện và hoạt động đầy đủ qua đầu thu không dây 2.4GHz (USB Dongle)**.

---

## 📌 1. Tại sao lại cần bản Fix này? (Vấn đề & Nguyên nhân)

### ❌ Vấn đề thực tế (The Issue):
Khi sử dụng bàn phím **AULA S75 Pro** với phần mềm driver gốc từ nhà sản xuất:
* Cắm dây cáp USB Type-C thì phần mềm nhận diện bàn phím bình thường.
* Nhưng khi rút dây và **chuyển sang dùng cục thu không dây USB 2.4GHz**, phần mềm liên tục báo **"Device Disconnected"** (Thiết bị không kết nối), khiến người dùng không thể chỉnh LED RGB, remap phím hoặc thiết lập macro khi dùng không dây.

### 🔍 Nguyên nhân kỹ thuật (Technical Root Cause):
* Phần mềm driver gốc (`DeviceDriver.exe`) chỉ được cấu hình cứng để quét kết nối USB có dây với mã phần cứng:
  * `VID_0C45 & PID_800A` (Giao tiếp USB có dây mặc định).
* Trong khi đó, cục thu sóng USB 2.4GHz (Type-A Dongle) đi kèm bàn phím được nạp firmware nhận diện với thông số:
  * **Vendor ID (VID):** `05AC`
  * **Product ID (PID):** `024F`
  * **HID Interface:** `VID_05AC&PID_024F&MI_03`
  * **Device Name:** `2.4G Dongle`
* Do thiếu định nghĩa cho interface này trong file `config.xml`, phần mềm bỏ qua tín hiệu từ cục thu 2.4G và coi như không có bàn phím kết nối.

### ✅ Cách khắc phục trong bản này (The Solution):
Bản driver này đã được bổ sung khai báo interface 2.4GHz trực tiếp vào [`config.xml`](./config.xml):
```xml
<keyboard name="S75Pro" device_type="101" device_info="rgb-keyboard" img_connected="home_keyboard_connected.png" img_disconnected="home_keyboard_disconnected.png">
    <mode value="0" desc="USB" vid="0C45" pid="800A" product_name="AULA-S75Pro" hid_interface="VID_0C45&PID_800A&MI_00"/>
    <!-- ĐÃ FIX: Thêm nhận diện cho đầu thu không dây 2.4G -->
    <mode value="2" desc="2.4G TYPE-A" vid="05AC" pid="024F" product_name="2.4G Dongle" hid_interface="VID_05AC&PID_024F&MI_03"/>
</keyboard>
```
Nhờ đó, phần mềm nhận diện ngay lập tức bàn phím qua sóng 2.4G mà không cần phải cắm dây.

---

## ✨ 2. Các tính năng hoạt động qua 2.4GHz

Khi sử dụng không dây qua 2.4G, bạn có thể điều chỉnh toàn bộ các thông số:
* 🌈 **Chỉnh đèn LED RGB:** Đổi hiệu ứng, màu sắc, tốc độ, độ sáng và chế độ nháy theo điệu nhạc (Music Sync).
* ⌨️ **Remap phím:** Gán lại chức năng bất kỳ cho các phím, gán tổ hợp phím tắt, chức năng đa phương tiện (Media keys).
* ⚡ **Macro:** Tạo và gán chuỗi phím macro cho gaming hoặc công việc.
* ⏱️ **Cấu hình hệ thống:** Tùy chỉnh thời gian tự động ngủ tiết kiệm pin (Sleep time) và thời gian phản hồi phím (Key respond time).

---

## ⚠️ 3. Lưu ý quan trọng về Màn hình LCD & Nạp ảnh GIF

* Màn hình phụ của **AULA S75 Pro** có kích thước hiển thị chuẩn là **240x135 px** (hoặc 135x240).
* **Lưu ý:** Trong cấu hình driver (`menu_wireless screen="0"`), tính năng nạp ảnh động GIF lên màn hình LCD **bị vô hiệu hóa ở chế độ 2.4G**. Điều này nhằm tránh nghẽn băng thông truyền tải không dây và tránh rủi ro treo/lỗi màn hình bàn phím.
* 👉 **Giải pháp:** Nếu bạn muốn nạp ảnh động GIF mới vào màn hình, **hãy cắm cáp USB Type-C trực tiếp vào máy tính**. Sau khi nạp xong vào bộ nhớ bàn phím, bạn có thể rút dây ra và tiếp tục sử dụng 2.4G bình thường!
* *(Trong thư mục [`sample_gifs/`](./sample_gifs/) có sẵn ảnh mẫu đúng tỷ lệ 240x135 để bạn nạp thử).*

---

## 🚀 4. Hướng dẫn cài đặt & Sử dụng (Portable)

Bản driver này là dạng **Portable** (chạy trực tiếp không cần cài đặt rườm rà vào hệ điều hành):

### Cách 1: Tải về dùng ngay
1. Bấm nút **Code** -> **Download ZIP** ở góc trên trang GitHub này (hoặc tải từ mục Releases nếu có).
2. Giải nén file ZIP vào một thư mục bất kỳ trên máy bạn (ví dụ: `C:\S75Pro` hoặc trong thư mục `Programs`).
3. Cắm cục thu **2.4G Dongle** vào máy và bật công tắc bàn phím sang chế độ **2.4G**.
4. Chạy file **`DeviceDriver.exe`** để mở phần mềm tùy chỉnh bàn phím.

### Cách 2: Tạo lối tắt ngoài Desktop
Trong thư mục đã có sẵn file script tự động:
1. Nhấp đúp chuột vào file **`Tao-Shortcut-Desktop.bat`**.
2. Một lối tắt tên **`S75Pro (Fixed 2.4G)`** sẽ tự động xuất hiện ngoài màn hình Desktop để bạn mở nhanh bất cứ lúc nào.

---

## 🛠️ Tự sửa nếu bạn đã cài sẵn driver AULA trên máy

Nếu bạn đang có sẵn driver S75Pro cài từ trước và muốn tự sửa mà không cần tải lại:
1. Mở thư mục cài đặt phần mềm (thường ở `%LOCALAPPDATA%\Programs\S75Pro` hoặc `C:\Program Files (x86)\...`).
2. Mở file `config.xml` bằng Notepad hoặc trình soạn thảo code bất kỳ.
3. Tìm thẻ `<keyboard name="S75Pro" ...>` và chèn thêm dòng sau:
   ```xml
   <mode value="2" desc="2.4G TYPE-A" vid="05AC" pid="024F" product_name="2.4G Dongle" hid_interface="VID_05AC&PID_024F&MI_03"/>
   ```
4. Lưu file lại và khởi động lại phần mềm là xong!

---

## 🌐 English Summary

This repository contains the fixed driver software for the **AULA S75 Pro** mechanical keyboard (with TFT screen and knob). 

* **The Problem:** The stock software only recognizes the wired USB interface (`VID_0C45&PID_800A`). When connected via the 2.4GHz wireless dongle (`VID_05AC&PID_024F`), the software reports "Device Disconnected".
* **The Fix:** Added the 2.4GHz HID interface mapping (`VID_05AC&PID_024F&MI_03`) into [`config.xml`](./config.xml).
* **GIF Upload Note:** Uploading custom GIF animations to the LCD screen requires a direct USB Type-C cable connection due to wireless bandwidth limitations. RGB lighting, macros, and key remaps work seamlessly over 2.4GHz.
* **Usage:** Extract the folder, run `Tao-Shortcut-Desktop.bat` to create a desktop shortcut, or launch `DeviceDriver.exe` directly.
