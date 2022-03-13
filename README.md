# pkgtools-extras
Additional pkgtool-like tools for Slackware Linux to enable scriptable
package searching in remote repositories, and easy package fetching from
remote repositories.

Can use slackpkg/slackpkg+ metadata if available, or provides its
own metadata update program as well.

While there is some overlap with slackpkg/slackpkg+, these tools are
intended to approach the problem from a "many small tools working together"
direction, rather than the "does it all with a flashy menu" approach
those tools take.  Credit to those programs for inspiration and guidance!
For many basic tasks such as keeping up with current, applying security
patches, etc., its probably easier to continue using those tools, but its
difficult to use pieces of those programs to find and/or fetch packages
programmatically, let alone do some of the kernel package management I prefer
(such as keeping around several older kernel versions, side-by-side, but
still allow using tools to retrieve and install the newer kernel versions
for evaluation).

