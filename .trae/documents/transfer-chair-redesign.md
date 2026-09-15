# Transfer Chair 页面重做计划

## 背景
供应商更换，旧页面 `transfer-device.html` 展示的是单个液压移位椅 + 3 色选择。新产品线有 3 款移位椅（手动/液压/电动），外加选配配件（起身器+餐盘）和标配配件（便桶）。需要全新页面展示完整产品线。

## 页面结构（单页 3 产品）

### 1. Hero 区
- 纯色品牌色 `#2C5F4E` 背景，白色文字，无图片
- 标题：`Patient Transfer Chairs`
- 副标题：`Manual · Hydraulic · Electric — 150 kg Capacity`
- CTA: Request Factory Quote

### 2. 三款产品对比卡
3 列网格，每款一张卡：
- **Manual** — `Manual patient lift.png` + 名称 + 关键参数 + "Hand-crank height adjustment"
- **Hydraulic** — `Hydraulic Patient Lift.png` + 名称 + 关键参数 + "Hydraulic pedal lift"
- **Electric** — `Electric patient lift.png` + 名称 + 关键参数 + "Electric hydraulic + wireless remote"

每张卡显示：承重 150kg、坐高范围、调节方式、毛重/净重

### 3. 配件区
两列布局：
- **标配 (Standard)**: Bedpan（`Bedpan.png`）— 可拆卸便桶
- **选配 (Optional Bundle)**: Stand Assist Aid（`Stand-assist aid.png` + `Stand-assist aid2.png` 两角度）+ Meal Tray（`Meal tray.png`）— 起身器与餐盘捆绑

### 4. 规格对比表
三列横向对比表（Manual / Hydraulic / Electric），行：
- 产品尺寸、坐高、坐宽、坐深、承重、调节方式、毛重、净重、包装尺寸、前轮、后轮
- Electric 额外行：电池、充电电压、充电时间

### 5. 共同特性
- 高碳钢主架、钢琴白烤漆、全自动焊接
- 靠背双卡扣、快拆式把手
- 亚麻软海绵坐垫 + 安全带
- 可上翻式脚踏板（Manual）
- 可拆卸便桶（标配）

### 6. CTA + Related Products（沿用现有）

## 文件改动

### 新建
- `solutions/transfer-chair.html` — 全新页面

### 旧文件处理
- `transfer-device.html` 直接删除
- `_redirects` 加规则：`/solutions/transfer-device /solutions/transfer-chair 301`

### 全局引用更新（transfer-device → transfer-chair）
- `index.html` — 产品卡链接 + 图片 + 描述
- `products.html` — 产品列表
- `contact.html` — 预选产品下拉
- `about.html` — 提及处
- `blog.html` — 博客卡片链接
- `sitemap.xml` — URL 更新
- `functions/api/submit.js` — 产品名映射
- `_redirects` — 新增 /solutions/transfer-chair → transfer-chair
- 导航栏（header/footer 在各 HTML 内联）：所有页面的 nav dropdown
- 博客文章内引用（6 篇）— 链接更新
- `terms-of-service.html` / `privacy-policy.html` — 引用更新

### 图片使用
| 图片 | 用途 |
|---|---|
| `Manual patient lift.png` | 手动款产品图 |
| `Hydraulic Patient Lift.png` | 液压款产品图 |
| `Electric patient lift.png` | 电动款产品图 |
| `Bedpan.png` | 标配便桶 |
| `Stand-assist aid.png` | 选配起身器角度1 |
| `Stand-assist aid2.png` | 选配起身器角度2 |
| `Meal tray.png` | 选配餐盘 |

旧图片已被用户删除。后续用户会补充实拍图，当前先用现有 PNG。

## 验证
1. 打开 `transfer-chair.html` 确认 3 款产品展示正确
2. 检查所有 transfer-device 链接已更新
3. 访问旧 URL 确认跳转生效
4. 提交询盘确认产品名正确
5. 移动端响应式检查
