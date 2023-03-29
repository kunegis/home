#
# The '.bashrc' file of Jérôme Kunegis.  '.bashrc' usually already
# contains something, so better source this file using '.'. 
#

PS1="\h:\w $ "

export EDITOR="vim"

# Made to work on a white background 
export LS_COLORS='ex=47;1:di=106;1:ln=target:or=41:ow=103;1'

# For screen(1)
[ "$STY" ] && PS1="[$STY] $PS1"

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

		if [ -e .git ] ; then
			label=$(git symbolic-ref --short HEAD)
			[ "$?" = 0 ] || return 1

##			# Show that we are in a branch, if we are not in 'master'
##			if [ -z "$jk_git_no_branch" ] ; then
##				if [ "$label" != master ] ; then
##					echo "In branch [43;37;1m $label [m"
##				fi
##			fi

			# Add this in front of the next two command in case git uses a
			# pager unnecessarily.
			## GIT_PAGER=cat
			
			# Things to push
			git log --oneline origin/"$label"..HEAD &&    

			# Things to add/commit
			git status -s -b

		else
			# If there is no .git directory, assume that we are in
			# ~/src, where all subdirectories are git directories.
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
		# When followed by a command, just execute Git
		command git "$@"
	fi
}

## ---------- I never use SVN anymore
## # Same for SVN.  (Well, almost.)
## svn() {
## 	if [ $# -eq 0 ] ; then
## 		svn status
## 	else
## 		command svn "$@"
## 	fi
## }

## --- subsumed under the "git" alias
## # Check all Git/SVN directories under ~/src/, which is where all my
## # work is.  
## work() {
## 	for dir in * ; do
## 		cd "$dir" 
## 		{
## 			[ -r .git ] && git
## 			[ -r .svn ] && svn
## 		} | sed -E -e 's,^,'"$dir"':	,'
## 		cd .. 
## 	done
## }

# Update/pull all repositories 
pull() {
	for dir in * ; do
		cd "$dir" 
		{
			[ -r .git ] && git pull 
			[ -r .svn ] && svn update
		} | sed -E -e 's,^,'"$dir"':	,'
		cd .. 
	done
}
