# GratefulMoments

SwiftUIで開発した感恩日記アプリです。毎日の感恩时刻を記録し、メモや写真を追加できます。記録の連続日数を確認し、成就バッジを獲得して積極的な思い出のコレクションを築きましょう。

![iOS](https://img.shields.io/badge/iOS-17%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![プラットフォーム](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgray)

[English](./README.en.md) | 日本語

## このプロジェクトについて

GratefulMomentsは毎日の感恩时刻を記録できる個人用感恩日記アプリです：

- **时刻の記録** — タイトル、メモ、オプションで写真を付けて感恩エントリーを作成
- **連続日数の追跡** — 連続して記録した日数を監視し、習慣を継続
- **バッジを獲得** — 感恩の旅で成就を達成
- **履歴を閲覧** — 視覚的に魅力的な六角形レイアウトで過去の时刻を表示

## このプロジェクトが役立つ理由

- **積極的な習慣を形成** — 毎日の感恩日記は身心健康の改善に関連
- **最新のSwiftUIパターン** — `@Observable`、SwiftData、環境注入を展示
- **カスタムUIコンポーネント** — 时刻を表示する独自の六角形グリッドレイアウト
- **バッジ激励システム** — アンロック可能な成就で日記体験をゲーミフィケーション

## 主な機能

| 機能 | 説明 |
|--------|-------------|
| 时刻記録 | タイトル、メモ、オプションで写真のエントリーを作成 |
| 写真サポート | `PhotosPicker`を使用してライブラリから画像を添付 |
| SwiftData永続化 | SwiftDataを使用してすべての时刻をローカルに保存 |
| 連続日数追跡 | 連続して記録した日数を計算 |
| バッジシステム | アクティビティに基づいて成就をアンロック |
| 六角形UI | 时刻の視覚的な表示のためのカスタム`HexagonLayout` |
| サンプルデータ | プレビューとテスト用の事前構築のサンプル时刻 |

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
├── Assets.xcassets/       # アセット
├── ContentView.swift      # メインテブビュー
└── GratefulMomentsApp.swift  # アプリエントリーポイント
```

## ヘルプの取得

- 問題や質問がある場合は、[GitHub Issue](https://github.com/yourusername/GratefulMoments/issues)を作成してください
- バグ報告や機能リクエストを歓迎します

## ライセンス

このプロジェクトはMITライセンスの下でライセンスされています - [LICENSE](../LICENSE)ファイルを参照してください。

## メンテナンスとコントリビューター

- 増田創 (Soh Masuda) — オリジナル開発者

コントリビューションを歓迎します！詳細については、[CONTRIBUTING.md](../CONTRIBUTING.md)（準備中）を参照してください。
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
