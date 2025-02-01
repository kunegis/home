#
# The '.bashrc' file of Jérôme Kunegis.  '.bashrc' usually already
# contains something, so better source this file using '.'. 
#

umask 077

PS1="\[\e[1m\]\h:\w $ \[\e[m\]"

export EDITOR=vim

# For screen(1)
[ "$STY" ] && PS1="[$STY] $PS1"

# Disable tilde expansion
_expand()
{
	return 0;
}

PATH="$HOME/bin:$HOME/src/home/bin:$PATH"

alias df='df -x squashfs -x tmpfs -x devtmpfs -T'
alias ls='ls --color=auto'

export LS_COLORS='di=1;97:ow=1;30;42:'

# Allows to just type 'git' and get a summary of important information
# about a repository.   My rule is:  "don't go home before 'git' outputs
# the empty string."  (Except for the branch information, when working
# on a branch.)  Everything output here is from old to new. 
git() {
	if [ $# -eq 0 ] ; then 
		if [ -e .git ] ; then
			label=$(git symbolic-ref --short HEAD)
			[ "$?" = 0 ] || return 1

			# Show that we are in a branch, if we are not in 'master'
			if [ -z "$jk_git_no_branch" -a "$label" != master ] ; then
				echo "In branch [35m$label[m"
			fi

			# In case git uses a pager unnecessarily
			# GIT_PAGER=cat
			
			# Things to push
			git log --oneline --reverse --no-decorate origin/"$label"..HEAD 

			# Things to add/commit
			git status -s 

		else
			# If there is no .git directory, assume that we are in
			# ~/src, where all subdirectories are git directories.
			if [ "$(basename $(pwd))" != src ] ; then
				echo >&2 "*** git(): Not a git directory"
				return 1
			fi 
			for dir in * ; do
				cd "$dir" 
				{
					[ -e .git ] && jk_git_no_branch=1 git
					# Do nothing if not a git directory
				} | sed -E -e 's,^,'"$dir"':	,'
				cd .. 
			done
		fi
	else
		command git "$@"
	fi
}

# Update/pull all repositories 
pull() {
	for dir in * ; do
		cd "$dir" 
		{
			[ -r .git ] && git pull 
		} | sed -E -e 's,^,'"$dir"':	,'
		cd .. 
	done
}
