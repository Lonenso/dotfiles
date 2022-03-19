# explain ignore
git check-ignore -v filename
# go to the root of the working tree
git rev-parse --show-toplevel
# shallow clone 
clone with depth=1 or --single-branch option presents
# show conflict filename 
git diff --name-only --diff-filter=U | xargs git status -s
# migrate commit history and migrate repo
git clone --mirror git@oldserver:oldproject.git
cd oldproject.git 
git remote add new git@newserver:newproject.git
git push --mirror new

#########################################################
see tool git-filter-repo for more info about migrate repo
# https://stackoverflow.com/questions/1365541/how-to-move-some-files-from-one-git-repo-to-another-not-a-clone-preserving-hi/61917589#61917589
# Create a new repo containing only the subdirectory:
git clone project2 project2_clone --no-local
cd project2_clone
git filter-repo --path sub/dir

# Merge the new repo:
cd ../project1
git remote add tmp ../project2_clone/
git fetch tmp master
git merge remotes/tmp/master --allow-unrelated-histories
git remote remove tmp
#########################################################
# show target's submodule status
git ls-tree $BRANCH | awk '{ if ($2 == "commit") { print substr($3,0,10), $4}}'
# turn off pager 
git --no-pager diff

# see what's in the stashs without applying it
git stash show -p

# create a patch from git diff and apply it.
git diff > save.patch
patch -p1 < save.patch

git diff --no-prefix > save.patch
patch -p0 < save.patch

# change remote's repo url
git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
