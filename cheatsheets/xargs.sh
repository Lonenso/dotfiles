# clever solution 
find .  -type f ! -path "./.git/*" | xargs -L 1 -I{} bash -c 'mv $1 ${1%.*}' -- {}
