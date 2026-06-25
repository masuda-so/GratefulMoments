# GratefulMoments

[English](README.en.md) · [日本語](README.ja.md)

![Platform](https://img.shields.io/badge/Platform-iOS%2018.6%2B-blue)
![Swift](https://img.shields.io/badge/Swift-SwiftUI%20%7C%20SwiftData-orange)
![License](https://img.shields.io/badge/License-Apache%202.0-lightgrey)

SwiftUI と SwiftData で作られたプライベートな感謝日記アプリ。タイトル・メモ・写真で小さなできごとを残し、連続記録とバッジで、ふりかえりをゆるやかな毎日の習慣にします。

---

## アプリについて

**GratefulMoments** は、SwiftUI と SwiftData で作られたプライベートな感謝日記アプリです。タイトル、メモ、写真で日々の「ありがとう」を記録し、連続記録日数やバッジ獲得で、ふりかえり習慣をゆるやかに育てられます。

## 主な機能

- **ありがとう日記**: タイトル、メモ、写真でうれしかったできごとを残す
- **写真サポート**: `PhotosPicker` を使ってフォトライブラリから画像を添付
- **六角形UI**: カスタム `HexagonLayout` による視覚的なできごと表示
- **連続記録日数**: 毎日の記録習慣をストリークとして可視化
- **バッジシステム**: 達成条件に応じてバッジをアンロック
- **Assistant**: iOS 26 以降と Apple Intelligence 対応環境で、書いたできごとをもとにチャットでふりかえる
- **SwiftData永続化**: できごととバッジをローカルに保存
- **Premiumサブスクリプション**: StoreKit による月額/年額プラン
- **PDF/CSVエクスポート**: Premium で日記を外部に書き出し

### 利用可能なバッジ

- **はじめの一歩**: 最初のできごとを残す
- **5つのありがとう**: 5つのできごとを残す
- **写真の思い出**: 写真付きのできごとを3つ残す
- **ことばと写真**: 写真とことばのあるできごとを5つ残す
- **10のありがとう**: 他のすべてのバッジを集め、10件以上のできごとを残す

## アーキテクチャ

### プロジェクト構成

```
GratefulMoments/
├── GratefulMoments/
│   ├── Custom Views/         # 再利用 UI コンポーネント
│   ├── Logic/                # データコンテナ、ストリーク計算、StoreKit
│   ├── Models/               # Moment、Badge、バッジ管理
│   ├── Resources/            # アセット、色、ローカライズ
│   ├── Tabs/
│   │   ├── Achievements/     # 達成・バッジ画面
│   │   ├── Assistant/        # Apple Intelligence ふりかえりチャット
│   │   ├── Moments/          # できごと一覧、入力、詳細
│   │   ├── Premium/          # StoreKit ペイウォールとマーケティング
│   │   └── Settings/         # 設定と法務リンク
│   ├── ContentView.swift     # メインタブビュー
│   └── GratefulMomentsApp.swift # アプリエントリーポイント
├── StreakCalculatorTests/    # ユニットテスト
└── Scripts/                  # ビルド・スクリーンショット自動化
```

## プライバシー

- できごとと写真は SwiftData で端末内にローカル保存されます。
- 記録は外部サーバーに送信されません。書き出しはユーザーが選択したときのみ行われます。
- Assistant は対応デバイス上で Apple Intelligence によりオンデバイスで動作します。
- 広告は表示されません。

## プラン

GratefulMoments は無料で始められ、StoreKit による Premium サブスクリプションを任意で利用できます。

- **無料**: できごと 30 件まで
- **Premium**（月額 / 年額）: できごと無制限、PDF・CSV 書き出し、ふりかえり Assistant

## 始め方

### 必要環境

- iOS 26 SDK を含む Xcode
- アプリのデプロイメントターゲット: iOS 18.6 以降
- Assistant 機能: iOS 26 以降、Apple Intelligence 対応デバイス、Apple Intelligence の有効化

### ビルドと実行

1. リポジトリをクローン:
   ```bash
   git clone https://github.com/masuda-so/GratefulMoments.git
   cd GratefulMoments
   ```
2. Xcode で `GratefulMoments.xcodeproj` を開く
3. シミュレーターや実機を選択し、**Cmd+R** でビルドして実行

### StoreKit テスト

- 共有 scheme `GratefulMoments` には `GratefulMoments.storekit` を設定しています。Xcode からこの scheme を **Cmd+R** で実行すると、ローカル StoreKit の商品カタログで Premium 画面を確認できます。
- `xcodebuild` や `simctl` で直接起動した場合は、Xcode の Run action に紐付くローカル StoreKit 設定が使われず、Sandbox/App Store Connect 側の商品状態を見ることがあります。
- 実機の本番アプリは、App Store Connect で承認・配信されている商品だけを読み込めます。

## 使い方

1. Moments タブの `+` ボタンで新しいできごとを作成
2. タイトル、メモ、写真を入力して保存
3. Achievements タブで連続記録日数やバッジを確認
4. 対応環境では Assistant タブで日記を振り返る
5. 無料 30 件の制限後は Premium 画面から制限解除やエクスポートを利用

## 現在の状態

App Store リリースの準備中です。提出の詳細はリポジトリ内の App Store チェックリストを参照してください。

## サポート

- サポート情報: <https://masuda-so.github.io/GratefulMoments/support/>
- プライバシーポリシー: <https://masuda-so.github.io/GratefulMoments/privacy/>
- 質問やバグ報告は [GitHub Issue](https://github.com/masuda-so/GratefulMoments/issues) へ
- メール: so.masuda.2003@pm.me

## ライセンス

このプロジェクトは Apache License 2.0 の下で公開されています。詳細は [LICENSE](./LICENSE) を参照してください。

## メンテナー

- **増田創 (Soh Masuda)** — オリジナル開発者

コントリビューション歓迎です。[CONTRIBUTING](./CONTRIBUTING.md) を参照してください。
