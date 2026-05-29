# GratefulMoments

[English](./README.en.md) | 日本語

---

## プロジェクト概要

**GratefulMoments** は、日々の「ありがとう」を日記のように残し、前向きな習慣を育てる SwiftUI 製の個人用アプリです。タイトル、メモ、写真付きでうれしかったできごとを書き留め、連続記録日数やバッジ獲得でモチベーションを維持できます。

![iOS](https://img.shields.io/badge/iOS-18.6%2B-blue)
![Swift](https://img.shields.io/badge/Swift-SwiftUI%20%7C%20SwiftData-orange)
![プラットフォーム](https://img.shields.io/badge/Platform-iOS-lightgray)

---

## 主な機能

- **ありがとう日記**: タイトル、メモ、写真でうれしかったできごとを残す
- **写真サポート**: `PhotosPicker` を使ってフォトライブラリから画像を添付
- **六角形UI**: カスタム `HexagonLayout` による視覚的なできごと表示
- **連続記録日数**: 毎日の記録習慣をストリークとして可視化
- **バッジシステム**: 達成条件に応じてバッジをアンロック
- **ふりかえり**: iOS 26 以降と Apple Intelligence 対応環境で、書いたできごとをもとにチャットを利用
- **SwiftData永続化**: できごととバッジをローカルに保存
- **サンプルデータ**: プレビューやテスト用のできごとを用意

### 利用可能なバッジ

- **はじめの一歩**: 最初のできごとを残す
- **5つのありがとう**: 5つのできごとを残す
- **写真の思い出**: 写真付きのできごとを3つ残す
- **ことばと写真**: 写真とことばのあるできごとを5つ残す
- **10のありがとう**: 他のすべてのバッジを集め、10件以上のできごとを残す

---

## 始め方

### 必要環境

- iOS 26 SDK を含む Xcode
- アプリのデプロイメントターゲット: iOS 18.6 以降
- ふりかえり機能: iOS 26 以降、Apple Intelligence 対応デバイス、Apple Intelligence の有効化

### インストール手順

1. リポジトリをクローン:
   ```bash
   git clone https://github.com/masuda-so/GratefulMoments.git
   cd GratefulMoments
   ```
2. Xcode で `GratefulMoments.xcodeproj` を開く
3. シミュレーターや実機を選択し、**Cmd+R** でビルドして実行

### Premium / StoreKit テスト

- 共有scheme `GratefulMoments` には `GratefulMoments.storekit` を設定しています。Xcodeからこのschemeを **Cmd+R** で実行すると、ローカルStoreKitの商品カタログでPremium画面を確認できます。
- `xcodebuild` や `simctl` で直接起動した場合は、XcodeのRun actionに紐付くローカルStoreKit設定が使われず、Sandbox/App Store Connect側の商品状態を見ることがあります。
- 実機の本番アプリは、App Store Connectで承認・配信されている商品だけを読み込めます。

### 使い方

1. 日記タブの `+` ボタンで新しいできごとを作成
2. タイトル、メモ、写真を入力して保存
3. 達成タブで連続記録日数やバッジを確認
4. 対応環境ではふりかえりタブで日記を振り返る

---

## プロジェクト構成

```text
GratefulMoments/
├── Custom Views/            # 再利用UIコンポーネント
├── Logic/                   # データコンテナ、ストリーク計算
├── Models/                  # Moment、Badge、バッジ管理
├── Tabs/
│   ├── Achievements/        # 達成・バッジ画面
│   ├── Assistant/           # Apple Intelligenceベースのふりかえりチャット
│   └── Moments/             # できごと一覧、入力、詳細
├── Resources/               # アセット、色、ローカライズ
├── ContentView.swift        # メインタブビュー
└── GratefulMomentsApp.swift # アプリエントリーポイント
```

---

## ヘルプ・サポート

- サポート情報: [Support](https://masuda-so.github.io/GratefulMoments/support/)
- プライバシーポリシー: [Privacy Policy](https://masuda-so.github.io/GratefulMoments/privacy/)
- 質問やバグ報告は [GitHub Issue](https://github.com/masuda-so/GratefulMoments/issues) へ

---

## ライセンス

このプロジェクトは Apache License 2.0 の下で公開されています。詳細は [LICENSE](./LICENSE) を参照してください。

---

## メンテナー・コントリビューション

- 増田創 (Soh Masuda) - オリジナル開発者
- コントリビューション歓迎です。コントリビューションガイドは準備中です。
