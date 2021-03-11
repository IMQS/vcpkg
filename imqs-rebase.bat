@echo off
setlocal
if not '%1'=='' goto haveOld
  echo imqs-release imqs-old-YYYY-MM-DD
  goto :eof
:haveOld
git checkout master
git pull
git checkout -b %1
git push -u origin %1

echo "All good?"
pause

git checkout master
git remote add upstream https://github.com/Microsoft/vcpkg.git
git pull --rebase upstream master
call bootstrap-vcpkg.bat
git add vcpkg.exe
git commit --amend --reset-author

echo "All good?"
pause

git push --force

