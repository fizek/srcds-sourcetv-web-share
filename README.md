# srcds-sourcetv-web-share
Automatic share demo (SourceTV) via web for srcds (linux).


How to use it?
Put it to cron with interval 30 minutes.

What it does?
1. Checks if demka-dir includes files older than 15 days and delete them.
2. Checks if gamepath contains any %.dem files and move them to demka-dir (except currently recording - lsof part).
3. Makes a filelist, builds html file and copies it to webroot dir.
