#!/bin/sh

#
# Change the commit and/or author date of git commits.
#
# change-date [-f] commit-to-change [branch-to-rewrite [commit-date [author-date]]]
#
#     If -f is supplied it is passed to "git filter-branch".
#
#     If <branch-to-rewrite> is not provided or is empty HEAD will be used.
#     Use "--all" or a space separated list (e.g. "master next") to rewrite
#     multiple branches.
#

# Based on http://stackoverflow.com/questions/3042437/change-commit-author-at-one-specific-commit

force=''
if test "x$1" = "x-f"; then
    force='-f'
    shift
fi

die() {
    printf '%s\n' "$@"
    exit 128
}
targ="$(git rev-parse --verify "$1" 2>/dev/null)" || die "$1 is not a commit"
br="${2:-HEAD}"

TARG_COMMIT="$targ"
TARG_COMMIT_DATE="${3-}"
TARG_AUTHOR_DATE="${4-}"

export TARG_COMMIT TARG_COMMIT_DATE TARG_AUTHOR_DATE

if test -z "$TARG_COMMIT_DATE"; then
    echo "Commit date not set."
    exit 1
fi

filt='
    if test "$GIT_COMMIT" = "$TARG_COMMIT"; then
        GIT_COMMITTER_DATE="$TARG_COMMIT_DATE"
        export GIT_COMMITTER_DATE

        if test -n "$TARG_AUTHOR_DATE"; then
            GIT_AUTHOR_DATE="$TARG_AUTHOR_DATE"
        else
            GIT_AUTHOR_DATE="$TARG_COMMIT_DATE"
        fi
        export GIT_AUTHOR_DATE
    fi

'

git filter-branch $force --env-filter "$filt" -- $br
