# Complex Physics Scale

A comprehensive framework for scaling hardware that integrates complex physical domains—**Electronics (E)**, **Mechanics (M)**, **Thermodynamics (T)**, and **Fluids (F)**. Designed for mission-critical systems like mobilities, marine, and aerospace, it bridges the gap from high-fidelity prototyping to mass production through domain-specific screening and rigorous BOM governance.

## 位置づけ

- [universal-guideline](https://github.com/tanaakk/universal-guideline) のローカル適用として、**ハードウェアコーディング**に利用する。
- `tanaakk-universal-schema.mdc` および `tanaakk-mes-manufacturing.mdc` と併用すること。

## 構成

| ファイル | 説明 |
|---------|------|
| `.cursorrules` | Cursor 用メインルール（全ファイル適用） |
| `.cursor/rules/tanaakk-complex-physics-scale.mdc` | ルール要約（alwaysApply） |
| `00_Screening.md` | プロジェクト適用物理ドメイン定義テンプレート |
| `01_Hardware_Mass_Production_Model.md` | PLOG / P&L / Competitive Margin / DFP の量産モデル体系 |

## 使い方

1. 本リポジトリをプロジェクトの `.cursor/rules/` にコピーするか、サブモジュールとして追加する。
2. `00_Screening.md` をプロジェクトに合わせて編集し、適用ドメインを定義する。
3. universal-guideline の `tanaakk-universal-schema.mdc` 等と併用する。

## License

GPL-3.0
