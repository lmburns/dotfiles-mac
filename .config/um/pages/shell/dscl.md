# dscl --
{:data-section="shell"}
{:data-date="June 02, 2021"}
{:data-extra="Um Pages"}

## SYNOPSIS
Deal with users

## OPTIONS

`dscl . append /Groups/admin GroupMembership usershortname`
: add user

`dscl . delete /Groups/admin GroupMembership usershortname`
: remove user from group

`dscl . read /Groups/admin GroupMembership`
: read membership of admin group

`sudo dseditgroup -o edit -a lucasburns -t user admin`
: add user to group admin
