# App Store Release Checklist

## Premium Products

- Subscription group: `GratefulMoments Premium`
- Monthly product ID: `smallthanksdiary.premium.monthly`
- Yearly product ID: `smallthanksdiary.premium.yearly`
- Starting prices: monthly `¥300`, yearly `¥2,000`
- Family Sharing: off for the MVP
- Submit both subscription products with the app if Premium is available in version `1.0`.
- Use `AppStoreConnectAssets/IAPReviewScreenshot-PremiumMonthly.png` as the IAP review screenshot.

## App Store Metadata

- Marketing URL: `https://masuda-so.github.io/GratefulMoments/`
- Support URL: `https://masuda-so.github.io/GratefulMoments/support/`
- Privacy Policy URL: `https://masuda-so.github.io/GratefulMoments/privacy/`
- Release option: manual release is safest for the first launch so the approved product page and IAPs can be checked before going live.
- GitHub Pages source: publish from the `main` branch `/docs` folder.

### Promotional Text

小さな感謝を写真とメモでやさしく記録。連続記録とバッジで続ける力を育てられます。広告なし、記録は端末内に保存されます。

### Keywords

感謝日記,写真日記,習慣化,継続記録,振り返り,達成バッジ,ライフログ,思い出記録,ポジティブ,セルフケア,ジャーナル

### Screenshot Follow-up

- iPhone 6.5-inch screenshots: keep the current three screenshots for `1.0`.
- iPad 13-inch screenshots: uploaded `AppStoreConnectAssets/iPad13/01-Moments.png`, `02-Achievements.png`, and `03-Entry.png` at `2064 x 2752`.
- For the next metadata refresh, replace English sample entry text with Japanese copy and add a fourth screenshot for Premium export/Assistant value.

## App Review Notes

GratefulMoments is a private gratitude journal. Free users can create up to 30 moments and can keep viewing or deleting their existing moments after that limit. GratefulMoments Premium unlocks unlimited moment creation, PDF/CSV export, and the Assistant reflection feature on devices where Apple Intelligence is available.

The In-App Purchase entry points are:

- the add button after the free 30-moment limit is reached
- the Assistant tab when Apple Intelligence is available
- the export button in the Moments tab

Journal entries and photos are stored locally with SwiftData. The app does not include ads. Export only happens when the user explicitly chooses PDF or CSV export.

Assistant requires iOS 26 or later, an Apple Intelligence-capable device, and Apple Intelligence enabled. When that is unavailable, the app does not advertise Assistant as a Premium benefit and shows the existing unavailable state in the Assistant tab.

Premium review shortcut: create at least one moment, then tap the export button in the Moments tab and choose PDF or CSV to display the subscription screen. The same subscription screen is shown after the free 30-moment limit is reached. On Apple Intelligence-capable devices, the Assistant tab also shows the subscription screen before purchase.

## Before Submission

- Accept the Paid Apps Agreement in App Store Connect.
- Complete tax and banking information.
- Enroll in the App Store Small Business Program if eligible.
- Create both subscription products in App Store Connect with matching product IDs.
- Add the app version and both subscription products to the same App Review submission.
- Keep Family Sharing disabled for the MVP.
- Select `GratefulMoments.storekit` in the Xcode scheme for local StoreKit testing.
- Test free limit, purchase, restore, subscription expiration, Assistant gating, and PDF/CSV export before submitting.
- Confirm the Settings tab opens support, email support, and the privacy policy.
- Confirm App Store Connect privacy details match the privacy policy: no developer data collection, no third-party analytics, no ads, and exports only by explicit user action.
- Confirm App Store Connect growth and marketing sections are intentionally unused for `1.0`: app events, custom product pages, product page optimization, promo codes, and Game Center.
