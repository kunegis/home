#
# The '.bashrc' file of Jérôme Kunegis.  '.bashrc' usually already
# contains something, so better source this file using '.'. 
#

umask 077

PS1="\[\e[1m\]\h:\w $ \[\e[m\]"

export EDITOR=vim

# Disable tilde expansion
_expand()
{
	return 0;
}

PATH="$HOME/bin:$HOME/src/home/bin:$PATH"

alias df='df -x squashfs -x tmpfs -x devtmpfs -T'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

export LS_COLORS='di=1;97:ex=0;34:ln=target:or=00;31:ow=1;97'

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
				printf 'In branch \e[35m%s\e[m\n' "$label"
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
				printf >&2 '\e[31m*** git(): Not a git directory\e[m\n'
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
