#
# The '.bashrc' file of Jérôme Kunegis.  '.bashrc' usually already
# contains something, so better source this file using '.'. 
#

PS1="\h:\w $ "

export EDITOR="vim"

# Made to work on a white background 
export LS_COLORS='ex=47;1:di=106;1:ln=target:or=41:ow=103;1'

# For screen(1)
[ "$PS1_OVERRIDE" ] && PS1="$PS1_OVERRIDE"

# Disable Tilde Expansion
_expand()
{
    return 0;
}

# Allows to just type 'git' and get a summary of important information
# about a repository.   My rule is:  "don't go home before 'git' outputs
# the empty string."  (Except for the branch information, when working
# on a branch.)
git() {
	if [ $# -eq 0 ] ; then 

		# Show that we are in a branch, if we are not in 'master'
		label="$(git symbolic-ref --short HEAD)"
		[ "$?" = 0 ] || return 1
		if [ "$label" != master ] ; then
			echo "[43;37;1mIn branch '$label'[m"
		fi

		# Things to push
		git log --oneline origin/"$label"..HEAD &&    

		# Things to add/commit
		git status -s 

	else
		# When followed by a command, just execute Git
		command git "$@"
	fi
}

# Same for SVN.  (Well, almost.)
svn() {
	if [ $# -eq 0 ] ; then
		svn status
	else
		command svn "$@"
	fi
}

# Check all Git/SVN directories under ~/work/, which is where all my
# work is.  
work() {
	for dir in * ; do
		cd "$dir" 
		{
			[ -r .git ] && git
			[ -r .svn ] && svn
		} | sed -E -e 's,^,'"$dir"':	,'
		cd .. 
	done
}

# Update/pull all repositories 
pull() {
	for dir in * ; do
		cd "$dir" 
		{
			[ -r .git ] && git pull -q
			[ -r .svn ] && svn update
		} | sed -E -e 's,^,'"$dir"':	,'
		cd .. 
	done
}
