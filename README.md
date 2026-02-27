# Complex Physics Scale

A comprehensive framework for scaling hardware that integrates complex physical domains—**Electronics (E)**, **Mechanics (M)**, **Thermodynamics (T)**, and **Fluids (F)**. Designed for mission-critical systems like mobilities, marine, and aerospace, it bridges the gap from high-fidelity prototyping to mass production through domain-specific screening and rigorous BOM governance.

## 位置づけ

- [universal-guideline](https://github.com/tanaakk/universal-guideline) のローカル適用として、**ハードウェアコーディング**に利用する。
- `tanaakk-universal-schema.mdc` および `tanaakk-mes-manufacturing.mdc` と併用すること。
- **5 層メタフレームワーク**の第 3 層（系の成立パターンのスクリーニング）に位置する。詳細は `00_Meta_Framework.md` を参照。

## 構成

| ファイル | 説明 |
|---------|------|
| `00_Meta_Framework.md` | 5 層メタフレームワーク（空間基底→散逸機構→本フレームワーク→残存・拡張→特異点突破）、モデルの利用方法（計算資源の節約・探索しない空間の定義） |
| `.cursorrules` | Cursor 用メインルール（全ファイル適用） |
| `.cursor/rules/tanaakk-complex-physics-scale.mdc` | ルール要約（alwaysApply） |
| `01_Screening.md` | 力学スクリーニング + Cross Industry Screening（3 段階フロー） |
| `01_Hardware_Mass_Production_Model.md` | PLOG / P&L / Competitive Margin / DFP の量産モデル体系 |
| `02_Regulatory_Compliance_US_JP_DE.md` | 検品後・出荷前の法令適合レイヤー（US / Japan / Germany） |
| `03_Verification_Checklist.md` | 力学・用途・BOM・テストケース・テスト計測器・許認可の定義完了検証 |

## 使い方

1. 本リポジトリをプロジェクトの `.cursor/rules/` にコピーするか、サブモジュールとして追加する。
2. `01_Screening.md` をプロジェクトに合わせて編集し、適用ドメインを定義する。
3. universal-guideline の `tanaakk-universal-schema.mdc` 等と併用する。

## License

GPL-3.0
