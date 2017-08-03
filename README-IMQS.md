Why fork vcpkg?

vcpkg needs to have the Windows 8.1 SDK installed in order to build itself,
and we don't want to impose that on everybody, so we keep a fork of vcpkg
that has vcpkg.exe already built.

In order to update to latest, just run `imqs-rebase.bat`.

If something goes wrong in that script, then the following instructions may be useful to understand what the script is trying to accomplish:

	-- First we save the current master branch, so that if we need to produce
	-- retro (ie patchfix) builds, we still have this revision lying around
	-- on github. If we don't do this, then github will GC this revision,
	-- and a build that references this old revision will fail.
	
	git checkout master
	git pull
	git checkout -b imqs-old-YYYY-MM-DD     -- Enter today's date for the branch name
	git push -u origin imqs-old-YYYY-MM-DD  -- Obviously use today's date here too

	-- Now we're ready to do the rebasing onto the latest Microsoft vcpkg
	
	git checkout master
    git remote add upstream https://github.com/Microsoft/vcpkg.git
    git pull --rebase upstream master
    bootstrap-vcpkg.bat                    -- to rebuild vcpkg.exe 
    git add vcpkg.exe
    git commit --amend --reset-author
    git push --force
    
    -- Finally, increment the version of the LATEST_VERSION_FILE variable inside maps/build/fetch-deps.bat

The idea with the above workflow is that we're always just one commit ahead of Microsoft:master.