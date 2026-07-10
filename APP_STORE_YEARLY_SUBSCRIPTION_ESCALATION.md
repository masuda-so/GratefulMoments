# Premium Yearly Review Escalation

Last checked: 2026-06-11 JST

## Current App Store Connect State

- App: 小さなありがとう日記
- App Apple ID: 6766864082
- Team / legal entity: Ether LLC
- Public subscription display name should be 小さなありがとう日記 Premium (ja-JP) / Grateful Moments Journal Premium (en-US)
- Historical subscription group label: GratefulMoments Premium
- Subscription group ID: 22070991
- Monthly subscription:
  - Reference name: Premium Monthly
  - Product ID: smallthanksdiary.premium.monthly
  - Status: 承認済み
- Yearly subscription:
  - Reference name: Premium Yearly
  - Apple ID: 6769607869
  - Product ID: smallthanksdiary.premium.yearly
  - Duration: 1年
  - Status: 審査中

## Evidence Checked

- The iOS app review history shows completed app reviews:
  - iOS 1.0.1 submitted 2026-05-26 13:29, status 審査完了
  - iOS 1.0 submitted 2026-05-24 21:35, status 審査完了
- The monthly subscription in the same group is approved, but the yearly subscription remains in review.
- The yearly subscription detail page is not editable while in review:
  - Save button is disabled.
  - Review screenshot upload is disabled.
  - Review note field is disabled.
- Yearly subscription localizations are approved:
  - English (U.S.): Premium Yearly / Unlimited moments, reflection, and exports.
  - Japanese: Premium 年額 / 無制限の記録、ふりかえり、PDF / CSV エクスポートを年ごとに利用できます。
- Yearly subscription availability is set for all selected countries or regions.
- Paid Apps Agreement is active:
  - 2026-05-18 - 2027-01-27
- Bank account, U.S. tax forms, and DSA compliance all display as active.
- App Store Connect currently shows this account-level warning:
  - Apple Developer Programの使用許諾契約が更新されたため、確認する必要があります。
  - The Account Holder must sign in to developer.apple.com/account and accept the updated agreement before updating existing apps or submitting new apps.

## Local App Configuration Checked

- `GratefulMoments/Logic/PurchaseManager.swift` uses:
  - `smallthanksdiary.premium.monthly`
  - `smallthanksdiary.premium.yearly`
- `GratefulMoments.storekit` contains both products in the same premium group:
  - Monthly: P1M, display price 300
  - Yearly: P1Y, display price 2000
- No local product ID mismatch was found.

## Support Message Draft

Subject: Premium Yearly subscription remains In Review after app review completed

Hello Apple Developer Support,

I am requesting help with an auto-renewable subscription review that appears to be stuck.

App:
- Name: 小さなありがとう日記
- App Apple ID: 6766864082
- Team / legal entity: Ether LLC

Subscription group:
- Name: GratefulMoments Premium (historical/internal label; public display should be 小さなありがとう日記 Premium / Grateful Moments Journal Premium)
- Group ID: 22070991

Subscription requiring help:
- Reference name: Premium Yearly
- Apple ID: 6769607869
- Product ID: smallthanksdiary.premium.yearly
- Current status in App Store Connect: In Review / 審査中

The monthly subscription in the same group is already approved:
- Reference name: Premium Monthly
- Product ID: smallthanksdiary.premium.monthly
- Current status: Approved / 承認済み

The related iOS app review for version 1.0.1 was completed on 2026-05-26 at 13:29, but the yearly subscription remains In Review. The yearly subscription page is currently locked for editing while in review: the Save button, review screenshot upload, and review note field are disabled.

I checked the yearly subscription metadata, availability, and localizations. The English and Japanese localizations are approved, availability is set for all selected countries or regions, and the review note/screenshot were already provided. The app uses StoreKit with the exact product IDs `smallthanksdiary.premium.monthly` and `smallthanksdiary.premium.yearly`.

Business settings for Ether LLC show the Paid Apps Agreement, bank account, U.S. tax forms, and Digital Services Act compliance as active. App Store Connect also shows an account-level notice that the Apple Developer Program License Agreement has been updated and must be accepted by the Account Holder. Please let me know whether that account-level agreement is blocking the yearly subscription review, or if the subscription review can be manually completed/restarted.

Could you please investigate `smallthanksdiary.premium.yearly` and advise what action is needed to complete the review?

Thank you.
