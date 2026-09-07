# AI-needed — hồ sơ bàn giao cho tác vụ AI

Thư mục này chứa brief, ảnh tham chiếu, prompt, generation record và phiếu duyệt
cho những việc có thể dùng AI trong Lịch Nhà. Nó **không** phải nơi lưu API key,
secret, ảnh người dùng, dữ liệu gia đình hoặc binary chưa được kiểm quyền.

## Quy tắc bắt buộc

1. Đọc `AGENTS.md` và [quy trình AI/asset](../docs/09-quy-trinh-ai-va-asset.md)
   trước mỗi tác vụ.
2. Rodin chỉ được chạy **Image-to-3D từ ảnh tham chiếu đã duyệt**. Không dùng
   Text-to-3D, prompt chữ đơn độc hoặc output Rodin trực tiếp trong app.
3. Mỗi lượt tạo phải giữ `generation-manifest.md` gồm model/version, thời điểm,
   input image hash, tham số, output hash, người duyệt, license và trạng thái
   cleanup/LOD/poster.
4. ElevenLabs chỉ tạo phôi âm thanh trước release. Không gọi API trong app,
   không lặp clip ngắn nguyên trạng; phải ghi nguồn, plan/quyền thương mại,
   chỉnh sửa và người duyệt trong manifest.
5. Nội dung văn xuôi hướng người dùng phải qua quy trình `avoid-ai-writing`; bản
   scan chỉ là tín hiệu chỉnh văn phong, không phải bằng chứng về tác giả.
6. Synthetic persona/panel chỉ dùng để tìm lỗ hổng và tạo giả thuyết. Không ghi
   quote, tỷ lệ, consensus hay pass gate như thể có người dùng thật.
7. Asset Việt Nam nhạy cảm (Quốc kỳ, thờ cúng, lễ nghi) cần cultural review;
   nếu thiếu reviewer hoặc license thì giữ `HOLD` và không đưa vào production.

## Cấu trúc đề nghị

```text
ai-needed/
├── briefs/              # mục tiêu, audience, acceptance notes; không secret
├── references/          # ảnh tham chiếu có provenance/quyền rõ ràng
├── prompts/             # prompt đã version hóa, luôn ghi model/tool
├── generation-records/  # manifest cho từng lượt Rodin/ElevenLabs
└── reviews/             # cultural, visual, accessibility, license, performance
```

Chỉ tạo nhánh con khi có artifact thật. Ảnh tham chiếu tạm thời có thể nằm ngoài
Git; trong repo chỉ giữ manifest/hash và đường dẫn nội bộ đã được phép.

## Mẫu handoff tối thiểu

```yaml
id: AI-YYYYMMDD-XXX
purpose: "một câu mô tả tác vụ"
tool: rodin-image-to-3d | elevenlabs-sfx | text-edit
input_refs: []
model_version: "ghi chính xác hoặc null"
rights_status: pending | approved | rejected
reviewers: []
output_status: draft | hold | approved | rejected
notes: "fallback, accessibility, cultural và license"
```

`output_status: approved` không thay thế các gate trong `research/decisions/` và
`specs/001-lich-nha-v1/`. Nếu tài liệu không đủ dữ kiện, giữ `HOLD` thay vì đoán.
