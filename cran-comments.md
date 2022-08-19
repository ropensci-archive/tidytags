# CRAN comments

This is a revised submission from tidytags v1.0.1, originally submitted on 08/18/2022. Broken URLs have been fixed and the tarball size has been reduced to under 5MB.

---

## R CMD check results

`devtools::check()` result:

**Test environment:** local MacOS Version 11.6 install, R 4.2.1

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

**Test environment:** Windows Server 2022, R-release, 32/64 bit

**0 errors ✔ | 0 warnings ✔ | 0 notes ✔ **

---

`rhub::check_for_cran()` result:

**Test environment:** Windows Server 2022, R-devel, 64 bit

**0 errors ✔ | 0 warnings ✔ | 2 notes ✖ **

- checking CRAN incoming feasibility ... [18s] 
  - NOTE: Maintainer: 'K. Bret Staudt Willet <bret.staudtwillet@fsu.edu>' New submission
  - Explanation: This is my first time submitting **tidytags** to CRAN.

- checking for detritus in the temp directory ... 
  - NOTE: Found the following files/directories: 'lastMiKTeXException'
  - Explanation: As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.
  
---

`rhub::check_for_cran()` result:

**Test environment:** Fedora Linux, R-devel, clang, gfortran

**0 errors ✔ | 0 warnings ✔ | 2 notes ✖ **

- checking CRAN incoming feasibility ... [4s/12s]
  - NOTE: Maintainer: 'K. Bret Staudt Willet <bret.staudtwillet@fsu.edu>' New submission
  - Explanation: This is my first time submitting **tidytags** to CRAN.

- checking HTML version of manual ...
  - NOTE: Skipping checking HTML validation: no command 'tidy' found
  - Explanation: As noted in an [r-source check](https://github.com/wch/r-source/blob/trunk/src/library/tools/R/check.R), this seems like an issue related to macOS's old version of HTML Tidy and not related to the package being checked.

---

`rhub::check(platform = 'debian-gcc-devel')` result:

**Test environment:** Debian Linux, R-devel, GCC

**0 errors ✔ | 0 warnings ✔ | 0 notes ✔ **
