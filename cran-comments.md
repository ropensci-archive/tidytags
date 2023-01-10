# CRAN comments

## tidytags v1.1.1

**11/18/2022**

This is an update from tidytags v1.0.3 submitted on 10/14/2022. This version fixes a bug causing an error in the `get_upstream_tweets()` function and requires an updated version of the vcr package (>= 1.2).

---

## R CMD check results

`devtools::check()` result:

**Test environment:** local MacOS Version 11.7 install, R 4.2.1

**0 errors ✔ | 0 warnings ✔ | 0 notes ✔ **

---

## GitHub Actions result:

**Test environments:** 

- macOS-latest, R release
- windows-latest, R release
- ubuntu-latest, R devel
- ubuntu-latest, R release
- ubuntu-latest, R 4.2

**0 errors ✔ | 0 warnings ✔ | 0 notes ✔ **

---

`rhub::check_for_cran()` result:

**Test environment:** Windows Server 2022, R-devel, 64 bit

**0 errors ✔ | 0 warnings ✔ | 0 notes ✔ **

---

`rhub::check_for_cran()` result:

**Test environment:** Fedora Linux, R-devel, clang, gfortran

**0 errors ✔ | 0 warnings ✔ | 1 note * **

- checking HTML version of manual ... NOTE: Skipping checking HTML validation: no command 'tidy' found
  - Explanation: As noted in an [r-source check](https://github.com/wch/r-source/blob/trunk/src/library/tools/R/check.R), this seems like an issue related to macOS's old version of HTML Tidy and not related to the package being checked.

---

`rhub::check_on_windows()` result: 

**Test environment:** Windows Server 2022, R-release, 32/64 bit

**0 errors ✔ | 0 warnings ✔ | 0 notes ✔ **
