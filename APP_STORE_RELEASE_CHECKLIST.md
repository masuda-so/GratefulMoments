# App Store Release Checklist

## Premium Products

- Subscription group: `GratefulMoments Premium`
- Monthly product ID: `gratefulmoments.premium.monthly`
- Yearly product ID: `gratefulmoments.premium.yearly`
- Starting prices: monthly `¥300`, yearly `¥2,000`
- Family Sharing: off for the MVP

## App Review Notes

GratefulMoments is a private gratitude journal. Free users can create up to 30 moments and can keep viewing or deleting their existing moments after that limit. GratefulMoments Premium unlocks unlimited moment creation, PDF/CSV export, and the Assistant reflection feature on devices where Apple Intelligence is available.

The In-App Purchase entry points are:

- the add button after the free 30-moment limit is reached
- the Assistant tab when Apple Intelligence is available
- the export button in the Moments tab

Journal entries and photos are stored locally with SwiftData. The app does not include ads. Export only happens when the user explicitly chooses PDF or CSV export.

Assistant requires iOS 26 or later, an Apple Intelligence-capable device, and Apple Intelligence enabled. When that is unavailable, the app does not advertise Assistant as a Premium benefit and shows the existing unavailable state in the Assistant tab.

## Before Submission

- Accept the Paid Apps Agreement in App Store Connect.
- Complete tax and banking information.
- Enroll in the App Store Small Business Program if eligible.
- Create both subscription products in App Store Connect with matching product IDs.
- Keep Family Sharing disabled for the MVP.
- Select `GratefulMoments.storekit` in the Xcode scheme for local StoreKit testing.
- Test free limit, purchase, restore, subscription expiration, Assistant gating, and PDF/CSV export before submitting.
