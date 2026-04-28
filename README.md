# GratefulMoments

[English](./README.en.md) | 日本語

---

## プロジェクト概要

**GratefulMoments** は、日々の「感謝のモーメント」を記録し、前向きな習慣を育てる SwiftUI 製の個人用日記アプリです。タイトル、メモ、写真付きでエントリーを作成し、連続記録日数やバッジ獲得でモチベーションを維持できます。

![iOS](https://img.shields.io/badge/iOS-18.6%2B-blue)
![Swift](https://img.shields.io/badge/Swift-SwiftUI%20%7C%20SwiftData-orange)
![プラットフォーム](https://img.shields.io/badge/Platform-iOS-lightgray)

---

## 主な機能

- **モーメント記録**: タイトル、メモ、写真で感謝エントリーを作成
- **写真サポート**: `PhotosPicker` を使ってフォトライブラリから画像を添付
- **六角形UI**: カスタム `HexagonLayout` による視覚的なモーメント表示
- **連続記録日数**: 毎日の記録習慣をストリークとして可視化
- **バッジシステム**: 達成条件に応じてバッジをアンロック
- **Assistant**: iOS 26 以降と Apple Intelligence 対応環境で、記録済みモーメントをもとに振り返りチャットを利用
- **SwiftData永続化**: モーメントとバッジをローカルに保存
- **サンプルデータ**: プレビューやテスト用のサンプルモーメントを用意

### 利用可能なバッジ

- **旅立ち**: 最初のモーメントを記録
- **5つ星**: 5つのモーメントを記録
- **シャッターバグ**: 写真付きエントリーを3つ追加
- **表現者**: 写真とテキストの両方を含むモーメントを5つ追加
- **パーフェクト10**: 他のすべてのバッジを集め、10件以上のモーメントを記録

---

## 始め方

### 必要環境

- iOS 26 SDK を含む Xcode
- アプリのデプロイメントターゲット: iOS 18.6 以降
- Assistant 機能: iOS 26 以降、Apple Intelligence 対応デバイス、Apple Intelligence の有効化

### インストール手順

1. リポジトリをクローン:
   ```bash
   git clone https://github.com/masuda-so/GratefulMoments.git
   cd GratefulMoments
   ```
2. Xcode で `GratefulMoments.xcodeproj` を開く
3. シミュレーターや実機を選択し、**Cmd+R** でビルドして実行

### 使い方

1. Moments タブの `+` ボタンで新規エントリーを作成
2. タイトル、メモ、写真を入力して保存
3. Achievements タブで連続記録日数やバッジを確認
4. 対応環境では Assistant タブで記録を振り返る

---

## プロジェクト構成

```text
GratefulMoments/
├── Custom Views/            # 再利用UIコンポーネント
├── Logic/                   # データコンテナ、ストリーク計算
├── Models/                  # Moment、Badge、バッジ管理
├── Tabs/
│   ├── Achievements/        # 実績・バッジ画面
│   ├── Assistant/           # Apple Intelligenceベースの振り返りチャット
│   └── Moments/             # モーメント一覧、入力、詳細
├── Resources/               # アセット、色、ローカライズ
├── ContentView.swift        # メインタブビュー
└── GratefulMomentsApp.swift # アプリエントリーポイント
```

---

## ヘルプ・サポート

- 質問やバグ報告は [GitHub Issue](https://github.com/masuda-so/GratefulMoments/issues) へ

---

## ライセンス

このプロジェクトは Apache License 2.0 の下で公開されています。詳細は [LICENSE](./LICENSE) を参照してください。

---

## メンテナー・コントリビューション

- 増田創 (Soh Masuda) - オリジナル開発者
- コントリビューション歓迎です。コントリビューションガイドは準備中です。
