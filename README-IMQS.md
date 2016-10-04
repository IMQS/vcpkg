Why fork vcpkg?

vcpkg needs to have the Windows 8.1 SDK installed in order to build itself,
and we don't want to impose that on everybody, so we keep a fork of vcpkg
that has vcpkg.exe already built.

How to update to latest:

    git remote add upstream https://github.com/Microsoft/vcpkg.git
    git pull --rebase upstream master
    powershell -exec bypass scripts\bootstrap.ps1    -- to rebuild vcpkg.exe 
    git add vcpkg.exe
    git commit --amend
    git push --force

The idea with the above workflow is that we're always just one commit ahead of Microsoft:master.