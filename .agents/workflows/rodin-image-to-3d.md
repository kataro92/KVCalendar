# Quy trình Rodin: ảnh tham chiếu → Image-to-3D

## Điều kiện đầu vào

1. Tạo concept sheet nguyên bản, tối thiểu có góc trước và 3/4; với vật thể lệch hoặc có mặt sau quan trọng, thêm cạnh và sau.
2. Chốt silhouette, tỷ lệ, bảng vật liệu và kích thước thật dự kiến trước khi gửi Rodin.
3. Kiểm tra quyền của từng ảnh. Không dùng ảnh tìm kiếm, ảnh lịch thương mại, giao diện đối thủ hoặc tác phẩm không rõ giấy phép.
4. Đánh dấu asset nhạy cảm. Quốc kỳ, ngôi sao, chữ Việt, logo và ký hiệu tín ngưỡng không được Rodin tự dựng.

## Tạo phôi

1. Mở tính năng **Image-to-3D**.
2. Tải 1–5 ảnh tham chiếu đã duyệt. Nếu dùng nhiều ảnh, ảnh đầu là nguồn vật liệu chính theo hướng dẫn hiện hành của Rodin; vì vậy chọn ảnh rõ màu và bề mặt nhất làm ảnh đầu.
3. Prompt chữ chỉ được dùng để làm rõ tỷ lệ, mặt khuất hoặc chất liệu đã thấy trong ảnh. Không dùng prompt làm đầu vào duy nhất và không chuyển sang Text-to-3D.
4. Chọn mức hình học vừa đủ cho phôi. Preset dịch vụ không phải ngân sách runtime của app.
5. Lưu ID ảnh, checksum nếu có, cấu hình, phiên bản mô hình, ngày tạo, output gốc và bằng chứng plan/điều khoản.

## Hoàn thiện

1. Đưa phôi vào Blender hoặc DCC tương đương để sửa silhouette, topology, normals, UV, pivot, scale và mặt khuất.
2. Giảm material, atlas texture, bake chi tiết và tạo LOD. Với vật thể chỉ cần chiều sâu nhẹ, ưu tiên render/bake thành 2.5D.
3. Tạo poster tĩnh cho Reduce Motion, Low Power và thiết bị yếu.
4. So với `design-system/lich-nha/MASTER.md`: vật liệu mờ, cạnh mềm, không bóng nhựa hoặc mang vẻ game asset đại trà.
5. Kiểm tra trên máy thật, rồi duyệt mỹ thuật, văn hóa, quyền và accessibility trước khi đưa vào asset pack.

Rodin là công cụ sản xuất trước phát hành. Ứng dụng không gọi dịch vụ lúc chạy và không chứa API key.

