# determine current SHELL
echo $SHELL # false postive
echo $BASH_VERSION; echo $ZSH_VERSION
echo $0     # clever
# cd to current __file__ path
cd "${0%/*}"

# pipe the output may eat the exit code, like tee
# https://stackoverflow.com/questions/6871859/piping-command-output-to-tee-but-also-save-exit-code-of-command

# eval command 
# https://unix.stackexchange.com/questions/23111/what-is-the-eval-command-in-bash
