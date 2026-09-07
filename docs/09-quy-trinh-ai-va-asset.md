# 09 — Quy trình AI và asset

Trạng thái: quy ước cho giai đoạn thiết kế và sản xuất asset; chưa tạo asset production.
Ngày cập nhật: 07/09/2026.

## 1. Mục tiêu

AI hỗ trợ nghiên cứu, rà thiết kế, biên tập tài liệu và tạo phôi asset. Nó không tự quyết định bản sắc Việt, độ chính xác của lịch, cách thể hiện biểu tượng quốc gia hoặc quyền sử dụng nội dung.

Cấu hình được chia thành bốn lớp:

| Lớp | Vị trí | Vai trò |
|---|---|---|
| Chỉ dẫn chung | `AGENTS.md` | ranh giới sản phẩm, giai đoạn và luật bắt buộc |
| Kỹ năng cục bộ | `.agents/skills/` | hướng dẫn chuyên môn từ bên thứ ba |
| Quy trình dự án | `.agents/workflows/` | cách áp dụng kỹ năng cho Lịch Nhà |
| Rule cho Cursor | `.cursor/rules/` | nhắc tự động theo loại file và chủ đề |

Nguồn và phiên bản kỹ năng được chốt trong `.agents/SOURCES.md`. Không sửa bản vendored để tránh lẫn quy tắc dự án với mã của nhà cung cấp.

## 2. Rà văn bản

`avoid-ai-writing` được dùng khi viết hoặc sửa tài liệu hướng người đọc. Mục đích là loại phần mở đầu vòng vo, nhịp câu quá đều, kết luận lặp lại và từ trừu tượng không thêm thông tin.

Quy trình:

1. Chọn giọng `docs` hoặc `technical`.
2. Giữ nguyên dữ kiện, phạm vi, bảng, trích dẫn và URL.
3. Sửa cục bộ thay vì viết lại toàn bộ để “đổi giọng”.
4. Đọc lại như tiếng Việt, không thay từ theo danh sách tiếng Anh một cách máy móc.

Detector, nếu có, chỉ giúp tìm đoạn cần đọc lại. Nó không đủ để kết luận tác giả là người hay máy.

## 3. Rà UI/UX

`ui-ux-pro-max` là công cụ tra cứu, không phải bộ nhận diện của sản phẩm. Mỗi lượt nghiên cứu phải bắt đầu bằng câu hỏi hẹp và kết thúc bằng quyết định phù hợp với [Design Master](../design-system/lich-nha/MASTER.md).

Hai lượt tra cứu cho “cultural calendar tactile editorial” và “young cultural calendar cute pastel” đều trả về cả gợi ý hợp lẫn gợi ý dành cho web. Dự án giữ bố cục thoáng, tương phản, reduced motion, Soft UI Evolution và micro-interaction. Minimalism/Swiss, palette xanh dương–xanh lá, Outfit/Work Sans, Hero–Features–CTA, hover và GSAP bị loại. Tìm kiếm hẹp về pastel giữ bề mặt mềm nhưng loại claymorphism, neumorphism và tactile jelly vì quá giống đồ chơi.

Các nguyên tắc được nhận:

- gesture kéo/bóc cần action một chạm tương đương;
- chuyển động phải tôn trọng Reduce Motion và chỉ có một điểm chính;
- phần nhìn có thể custom hoàn toàn nhưng semantic layer vẫn phải thật;
- kiểm tra màn hình nhỏ, Dynamic Type, VoiceOver và vùng chạm 44 pt trước khi duyệt.

## 4. Quyết định bắt buộc cho Rodin

Lịch Nhà chỉ dùng luồng **ảnh tham chiếu → Image-to-3D**. Không dùng Text-to-3D và không tạo model từ prompt chữ đơn lẻ.

Lý do:

- concept sheet cho phép dự án kiểm soát silhouette, tỷ lệ, vật liệu và chi tiết văn hóa trước khi tạo model;
- người duyệt có thể đối chiếu output với một nguồn đã chốt thay vì một mô tả mở;
- provenance của ảnh rõ hơn, giúp xử lý quyền và tái tạo asset;
- giảm khả năng model tự thêm hoa văn, ký hiệu hoặc hình dáng không phù hợp.

Rodin hiện cho phép nhiều ảnh đầu vào trong Image-to-3D; hướng dẫn của nhà cung cấp nêu ảnh đầu được dùng làm tham chiếu vật liệu khi có nhiều ảnh. Vì vậy concept sheet cần tách thành 1–5 ảnh sạch, và ảnh rõ màu/bề mặt nhất đặt đầu. Thông tin sản phẩm có thể thay đổi, nên kiểm tra lại [Rodin Gen-2.5 API](https://docs.hyper3d.ai/en/api-specification/rodin-gen2-5) trước mỗi đợt sản xuất.

Prompt chữ, nếu dùng, chỉ giải thích thông tin đã có trong ảnh: kích thước tương đối, bề mặt mờ, mặt khuất hoặc phần cần giữ. Prompt không được thay thế ảnh.

## 5. Chuỗi sản xuất asset 3D

1. Họa sĩ tạo concept sheet nguyên bản: trước, 3/4, cạnh và sau khi cần.
2. Art lead chốt silhouette, tỷ lệ thật, bảng vật liệu và vùng không được phép biến đổi.
3. Rights check xác nhận ảnh do dự án sở hữu hoặc có quyền sử dụng. Không lấy ảnh tìm kiếm hoặc sản phẩm đối thủ.
4. Người vận hành mở Image-to-3D, tải 1–5 ảnh đã duyệt và lưu cấu hình tạo.
5. Rodin tạo phôi. Output gốc được giữ để truy xuất, nhưng không được đưa thẳng vào app.
6. Artist sửa silhouette, topology, normals, UV, pivot, scale và mặt khuất trong Blender/DCC.
7. Tạo material gọn, texture atlas, bản LOD và poster tĩnh; cân nhắc bake 2.5D nếu live 3D không tạo khác biệt đáng kể.
8. Duyệt Mộc Son Dịu, văn hóa, quyền, accessibility và hiệu năng trên máy thật.
9. Chỉ asset có manifest đầy đủ mới được nhập vào pack offline.

Chi tiết thao tác nằm ở [workflow Rodin](../.agents/workflows/rodin-image-to-3d.md).

## 6. Phân công asset ban đầu

| Asset | Nguồn hình học | Cách ship ưu tiên | Ghi chú |
|---|---|---|---|
| Khánh gỗ | concept sheet → Rodin Image-to-3D → cleanup | mesh thấp hoặc bake normal | hình dáng phải riêng, không sao chép lịch thương mại |
| Ốc/cột đồng | ảnh/concept nguyên bản → Image-to-3D hoặc dựng tay | mesh rất thấp | kiểm roughness để không bóng nhựa |
| Cành đào/mai | botanical concept đã duyệt → Image-to-3D | 2.5D/bake trước, live 3D khi profile đạt | biến thể vùng do biên tập viên chốt |
| Đèn ông sao/đèn lồng | concept sheet → Image-to-3D → cleanup | low-poly hoặc sprite nhiều góc | không tự thêm chữ/ký hiệu |
| Trống đồng/họa tiết | artwork nguyên bản có reviewer | bake/relief kiểm soát | tránh mô phỏng tùy tiện hiện vật cụ thể |
| Quốc kỳ/ngôi sao | dựng tay theo nguồn pháp lý | mesh phẳng + animation kiểm soát | tuyệt đối không dùng Rodin |
| Pháo hoa/hoa rơi/mưa | hệ particle thiết kế riêng | 2D/Canvas/Metal | không phải asset Rodin |
| Tờ giấy | mesh/shader tương tác riêng | runtime custom | phải bám gesture và semantic UI |

## 7. Hồ sơ tối thiểu cho mỗi asset

| Trường | Nội dung |
|---|---|
| Asset ID | tên ổn định, không phụ thuộc filename tạm |
| Owner | người tạo, người phụ trách và reviewer |
| Reference | file, checksum, nguồn, giấy phép và ngày nhận |
| Công cụ | Rodin/version, Blender/DCC và cấu hình liên quan |
| Lượt tạo | ngày, seed nếu có, prompt phụ và output gốc |
| Biên tập | retopo, paint-over, bake, mix, trim, LOD |
| Quyền | plan, điều khoản tại ngày xuất và giới hạn sử dụng |
| Văn hóa | nguồn nội dung, vùng áp dụng và người duyệt |
| Kỹ thuật | triangle, material, texture, poster và device test |
| Phạm vi | effect ID, phiên bản app và trạng thái phát hành |

Theo chính sách hiện được công bố, dữ liệu của Rodin API có quy tắc lưu giữ riêng; không mặc định suy rộng sang mọi giao diện Hyper3D. Trước khi upload, kiểm lại [Data Retention Policy](https://docs.hyper3d.ai/en/legal/data-retention-policy), gói đang dùng và điều khoản hiện hành. Không upload ảnh người, nhà riêng hoặc artwork chưa đủ quyền.

## 8. Cổng duyệt

Một asset chỉ được dùng khi trả lời “có” cho tất cả câu sau:

- Reference có nguồn và quyền rõ không?
- Quy trình có đúng Image-to-3D, không có lượt Text-to-3D không?
- Output đã được con người sửa, không còn lỗi hình học hoặc chi tiết model tự bịa không?
- Vật liệu có hợp Mộc Son Dịu và không giống game asset đại trà không?
- Asset nhạy cảm đã qua reviewer văn hóa thích hợp chưa?
- Có LOD hoặc bản bake, poster tĩnh và kết quả thử trên thiết bị mục tiêu chưa?
- Manifest có đủ để một người khác lần lại nguồn, quyền và các bước sản xuất không?

## 9. Điều không đưa vào ứng dụng

- API key hoặc SDK gọi Rodin/ElevenLabs lúc runtime;
- prompt cho người dùng tự sinh cảnh;
- tải model theo ngày từ dịch vụ bên ngoài;
- asset không rõ nguồn hoặc chỉ còn output mà mất reference;
- model Rodin chưa cleanup;
- Quốc kỳ, ngôi sao, chữ Việt hoặc logo do mô hình tự sinh.

Các giới hạn này giữ lời hứa miễn phí, offline và giảm rủi ro về quyền, riêng tư, hiệu năng lẫn biểu đạt văn hóa.
