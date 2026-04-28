# GratefulMoments

[English](./README.en.md) | 日本語

---

## プロジェクト概要

**GratefulMoments**は、日々の「感謝の時刻」を記録し、前向きな習慣を育てるSwiftUI製の個人用日記アプリです。タイトル・メモ・写真付きでエントリーを作成し、連続記録日数やバッジ獲得でモチベーションを維持できます。

![iOS](https://img.shields.io/badge/iOS-17%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![プラットフォーム](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgray)

---

## 主な特徴・利点

- **時刻の記録**：タイトル・メモ・写真で感謝エントリーを作成
- **連続日数トラッキング**：毎日の記録習慣を可視化
- **バッジ獲得**：達成度に応じて成就バッジをアンロック
- **六角形UI**：視覚的に楽しいカスタムグリッド表示
- **SwiftData永続化**：全データはローカルに安全保存
- **サンプルデータ**：プレビューやテスト用の時刻も用意

### 利用可能なバッジ
- 旅立ち（最初の時刻を記録）
- 5つ星（5つの時刻を記録）
- シャッターバグ（写真付きエントリー3つ）
- 表現者（写真＋テキスト5つ）
- パーフェクト10（全バッジ収集＆10件記録）

---

## 始め方

### 必要環境
- Xcode 15 以降
- iOS 17 以降SDK / macOS 14 以降

### インストール手順
1. リポジトリをクローン：
   ```bash
   git clone https://github.com/yourusername/GratefulMoments.git
   cd GratefulMoments
   ```
2. Xcodeで`GratefulMoments.xcodeproj`を開く
3. シミュレーターや実機を選択し、**Cmd+R**でビルド＆実行

### 使い方
1. Momentsタブの`+`ボタンで新規エントリー作成
2. タイトル・メモ・写真を入力し保存
3. Achievementsタブで連続日数やバッジを確認

---

## プロジェクト構成

```
GratefulMoments/
├── Custom Views/           # 再利用UIコンポーネント
├── Logic/                  # ビジネスロジック
├── Models/                 # データモデル
├── Tabs/                   # メインタブ画面
├── Assets.xcassets/        # 画像・バッジ等アセット
├── ContentView.swift       # メインタブビュー
└── GratefulMomentsApp.swift # アプリエントリーポイント
```

---

## ヘルプ・サポート
- 質問・バグ報告は[GitHub Issue](https://github.com/yourusername/GratefulMoments/issues)へ

---

## ライセンス
このプロジェクトはApache License 2.0の下で公開されています。詳細は[LICENSE](./LICENSE)を参照してください。

---

## メンテナー・コントリビューション
- 増田創 (Soh Masuda) — オリジナル開発者
- コントリビューション歓迎！詳細は[CONTRIBUTING.md](./CONTRIBUTING.md)（準備中）を参照
| 时刻記録 | タイトル、メモ、オプションで写真のエントリーを作成 |
| 写真サポート | `PhotosPicker`を使用してライブラリから画像を添付 |
| SwiftData永続化 | SwiftDataを使用してすべての时刻をローカルに保存 |
| 連続日数追跡 | 連続して記録した日数を计算 |
| バッジシステム | アクティビティに基づいて成就をアンロック |
| 六角形UI | 时刻の視覚的な表示のためのカスタム`HexagonLayout` |
| サンプルデータ | プレビューとテスト用の预先构建のサンプル时刻 |

### 利用可能なバッジ

- **旅立ち** — 最初の时刻を記録
- **5つ星** — 5つの时刻を記録
- **シャッターバグ** — 写真付きのエントリーを3つ追加
- **表現者** — 写真とテキストの両方を備えた5つの时刻を追加
- **パーフェクト10** — 他のすべてのバッジを収集しながら少なくとも10つの时刻を記録

## 始め方

### 必要環境

- **Xcode 15** 以降
- **iOS 17** 以降SDK
- **macOS 14** 以降（Macサポート用）

### インストール

1. リポジトリをクローン：
   ```bash
   git clone https://github.com/yourusername/GratefulMoments.git
   cd GratefulMoments
   ```

2. Xcodeでプロジェクトを開く：
   ```bash
   open GratefulMoments.xcodeproj
   ```

3. シミュレーター（例：iPhone 15 Pro）を選択し、**Cmd+R**でビルドして実行。

### 使い方

1. **时刻を追加** — Momentsタブの`+`ボタンをタップ
2. **詳細を入力** — タイトル、オプションのメモ、オプションで写真を選択
3. **保存** — 时刻は自動的に保存されます
4. **成就を表示** — Achievementsタブに切り替えて連続日数とバッジを確認

## プロジェクト構造

```
GratefulMoments/
├── Custom Views/           # 再利用可能なUIコンポーネント
│   ├── Hexagon.swift
│   ├── HexagonAccessoryView.swift
│   └── HexagonLayout.swift
├── Logic/                  # ビジネスロジック
│   ├── DataContainer.swift
│   └── StreakCalculator.swift
├── Models/                # データモデル
│   ├── Badge.swift
│   ├── BadgeDetails.swift
│   ├── BadgeManager.swift
│   └── Moment.swift
├── Tabs/                  # メインアプリのタブ
│   ├── Achievements/
│   │   ├── AchievementsView.swift
│   │   ├── BadgeDetailView.swift
│   │   ├── LockedBadgeView.swift
│   │   ├── StreakView.swift
│   │   └── UnlockedBadgeView.swift
│   └── Moments/
│       ├── MomentDetailView.swift
│       ├── MomentEntryView.swift
│       ├── MomentHexagonView.swift
│       └── MomentsView.swift
```

## ヘルプの取得

- 問題や質問がある場合は、[GitHub Issue](https://github.com/yourusername/GratefulMoments/issues)を作成してください
- バグ報告や機能リクエストを歓迎します

## ライセンス

このプロジェクトはMITライセンスの下でライセンスされています - [LICENSE](../LICENSE)ファイルを参照してください。

## メンテナンスとコントリビューター

- 増田創 (Soh Masuda) — オリジナル開発者

コントリビューションを歓迎します！詳細については、[CONTRIBUTING.md](../CONTRIBUTING.md)（準備中）を参照してください。

Built with ❤️ using SwiftUI and SwiftData
