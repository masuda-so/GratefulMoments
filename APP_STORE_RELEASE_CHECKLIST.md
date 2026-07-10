# App Store Release Checklist

## Premium Products

- Public subscription display name: `小さなありがとう日記 Premium` (ja-JP) / `Grateful Moments Journal Premium` (en-US)
- Product IDs remain internal and use the `smallthanksdiary` namespace.
- Monthly product ID: `smallthanksdiary.premium.monthly`
- Yearly product ID: `smallthanksdiary.premium.yearly`
- Starting prices: monthly `¥300`, yearly `¥2,000`
- Family Sharing: off for the MVP
- Submit both subscription products with the current app version `1.0.3`.
- Use `AppStoreConnectAssets/IAPReviewScreenshot-PremiumMonthly.png` as the IAP review screenshot.

## App Store Metadata

- Marketing URL: `https://masuda-so.github.io/GratefulMoments/`
- Support URL: `https://masuda-so.github.io/GratefulMoments/support/`
- Privacy Policy URL: `https://masuda-so.github.io/GratefulMoments/privacy/`
- Terms of Use in App Description: `利用規約（Apple標準EULA）: https://www.apple.com/legal/internet-services/itunes/dev/stdeula/`
- The app itself must also expose Terms of Use and Privacy Policy links. Settings shows both links, and the Premium screen shows StoreKit policy links.
- Release option: use automatic release after approval for `1.0.3` to minimize the purchase-unavailable window.
- GitHub Pages source: publish from the `main` branch `/docs` folder.

### Promotional Text

小さな感謝を写真とメモでやさしく記録。連続記録とバッジで続ける力を育てられます。広告なし、記録は端末内に保存されます。

### Keywords

感謝日記,写真日記,習慣化,継続記録,振り返り,達成バッジ,ライフログ,思い出記録,ポジティブ,セルフケア,ジャーナル

### Screenshot Follow-up

- iPhone 6.5-inch screenshots: keep the current three screenshots for `1.0.3` unless a refreshed unified visual set is uploaded.
- iPad 13-inch screenshots: uploaded `AppStoreConnectAssets/iPad13Polished/01-Moments.png`, `02-Achievements.png`, and `03-Entry.png` at `2064 x 2752`.
- For the next metadata refresh, replace English sample entry text with Japanese copy and add a fourth screenshot for Premium export/Assistant value.

## App Review Notes

小さなありがとう日記 is a private gratitude journal, localized in English as Grateful Moments Journal. Free users can create up to 30 moments and can keep viewing or deleting their existing moments after that limit. Premium unlocks unlimited moment creation, PDF/CSV export, and the Assistant reflection feature on devices where Apple Intelligence is available.

The In-App Purchase entry points are:

- the add button after the free 30-moment limit is reached
- the Assistant tab before purchase
- the export button in the Moments tab

Journal entries and photos are stored locally with SwiftData. The app does not include ads. Export only happens when the user explicitly chooses PDF or CSV export.

Assistant requires iOS 26 or later, an Apple Intelligence-capable device, and Apple Intelligence enabled. Before purchase, the Assistant tab displays the Premium screen. After purchase, unsupported or unprepared Apple Intelligence environments show the existing unavailable state.

Premium review shortcut: create at least one moment, then tap the export button in the Moments tab and choose PDF or CSV to display the subscription screen. The same subscription screen is shown after the free 30-moment limit is reached. The Assistant tab also shows the subscription screen before purchase.

Please review the first auto-renewable subscriptions with this app version:

- `smallthanksdiary.premium.monthly`
- `smallthanksdiary.premium.yearly`

## Before Submission

- Accept the Paid Apps Agreement in App Store Connect.
- Complete tax and banking information.
- Resolve the Ether LLC Business actions in App Store Connect:
  - Submitted `Ether合同会社定款.pdf` for the English legal-name compliance screening with company website `https://ether-llc.com/` and business activity region Japan only; monitor Apple approval.
  - EU DSA trader declaration is intentionally paused because the phone number should not be public; do not submit the app for EU distribution while this remains unresolved.
- Do not include the stray draft consumable IAP `gratefulmoments.premium.monthly` in the `1.0.3` submission; delete it from App Store Connect after explicit confirmation if cleanup is desired.
- Enroll in the App Store Small Business Program if eligible.
- Create both subscription products in App Store Connect with matching product IDs.
- Complete all missing subscription group and product metadata, pricing, localization, review screenshot, and availability until both products are `Ready to Submit`.
- Add the app version and both subscription products to the same App Review submission.
- Keep Family Sharing disabled for the MVP.
- Use the shared `GratefulMoments` scheme from Xcode for local StoreKit testing; direct `xcodebuild`/`simctl` launches may show Sandbox/App Store Connect product state instead.
- Test free limit, purchase, restore, subscription expiration, Assistant gating, and PDF/CSV export before submitting.
- Confirm the Settings tab opens support, email support, the privacy policy, and Terms of Use.
- Confirm App Store Connect privacy details match the privacy policy: no developer data collection, no third-party analytics, no ads, and exports only by explicit user action.
- Confirm App Store Connect growth and marketing sections are intentionally unused for `1.0.3`: app events, custom product pages, product page optimization, promo codes, and Game Center.

## Resubmission Notes for Guideline 2.1(b) and 3.1.2(c)

- Confirm Business > Agreements, Tax, and Banking has an `Active` Paid Apps Agreement.
- Confirm the two App Store Connect subscription product IDs exactly match the app:
  - `smallthanksdiary.premium.monthly`
  - `smallthanksdiary.premium.yearly`
- Confirm both subscriptions are attached to version `1.0.3` in the In-App Purchases or Subscriptions section before resubmitting.
- Paste the Terms of Use line into every active App Store locale description, or configure the EULA field in App Store Connect.
- Add this note to App Review: “The Paid Apps Agreement is active. Both auto-renewable subscriptions are configured, available, and attached to this app version. The app description includes the Apple standard EULA link, and the app includes Privacy Policy and Terms of Use links in Settings and on the Premium screen.”
