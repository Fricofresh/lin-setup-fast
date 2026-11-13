// Custom Thunderbird Configuration
// Keep the English UI but use the operating system's regional settings
// (German date, time and number formats) from setupGlobalLocale.sh.

user_pref("intl.locale.requested", "en-US");
user_pref("intl.accept_languages", "en-US, en");
user_pref("intl.regional_prefs.use_os_locales", true);

// Start the week on Monday and show date plus time in the message list.
user_pref("calendar.week.start", 1);
user_pref("mail.ui.display.dateformat.today", 2);
user_pref("mail.ui.display.dateformat.thisweek", 2);
user_pref("mail.ui.display.dateformat.default", 2);
