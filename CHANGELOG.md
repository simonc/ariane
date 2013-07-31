# Changelog

## 0.1.0

* Now tested against Rails 4, Ruby 2 (#11 - @petergoldstein)
* Opt-in session based breadcrumb (#7 - @58bits)

## 0.0.3

* FIX: The HTMLList divider is now rendered correctly (@PatrickMa)
* FIX: #2 A Crumb should be able to store random data
* IMPROVED: Most of the code is now documented
* IMPROVED: The tests are now using subject (@PatrickMa)

## 0.0.2

* FIX: HTML#link and HTMLLink#link return a non html safe string when return
       crumb text
* FIX: HTML#item and HTMLLink#item are using divider instead of
       options[:divider]
