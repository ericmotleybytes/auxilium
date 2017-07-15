# Auxilium Developer Introduction

This manual provides information about helping to maintain and/or extend
the capabilities of the Auxilium open source project. The information on
how to just get and use Auxilium is avalable
at <https://ericmotleybytes.github.io/auxilium/>, which also has links
to the latest Auxilium User Guide in both
[html](https://ericmotleybytes.github.io/auxilium/auxilium-user-guide.html)
and
[pdf](https://ericmotleybytes.github.io/auxilium/auxilium-user-guide.pdf)
formats. Before attempting Auxilium development, or getting too deep into
this manual, it is probably wise to look over these end-user resources.

# Auxilium Primary GitHub Repository

The original and primary Auxilium GitHub repository site, which is developer
oriented, is at <https://github.com/ericmotleybytes/auxilium>.

# Recommended Collaborative Development Process

The GitHub recommended collaborative development process is also supported and
recommended for Auxilium. This is sometimes called the "fork and branch" workflow.
The basic workflow is as follows.

1.  Get a GitHub account if you do not already have one. The free account option is fine.

1.  "Fork" the main Auxilium repository at <https://github.com/ericmotleybytes/auxilium>.

1.  "Clone" the forked repository to your local system.

1.  Add a Git remote for the original repository.

1.  Create a feature branch in which to place your changes.

1.  Make your changes to the new branch.

1.  Commit the changes to the branch.

1.  Push the branch to GitHub.

1.  Open a pull request from the new branch to the original repo.

1.  Clean up after your pull request is merged.

A good tutorial for this process is available
at <http://blog.scottlowe.org/2015/01/27/using-fork-branch-git-workflow/>.
GitHub also has good documentation such as their repository fork
description at <https://help.github.com/articles/fork-a-repo/>.

# Tools

All runtime Auxilium programs are written in pure 
[Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) version 4.2 or higher.
So to just use Auxilium, Bash is the only absolute prerequisite.

For development several additional tools are required to support
development unit testing and documentation generation. These tools include:

* Bats. The Bash Automated Testing System.
  Avalable at <https://github.com/sstephenson/bats>.

* Pandoc. A universal document converter.
  See <http://pandoc.org/> and <https://github.com/jgm/pandoc>.

* LaTeX. Used by Pandoc to generate PDF files.
  *TeX Live* is recommended. See <http://www.tug.org/texlive/>.

* Pandoc Preprocessor. The "pp" Pandoc-oriented text preprocessor.
  See <http://cdsoft.fr/pp/> and <https://github.com/CDSoft/pp>.

# Platforms

!include(../include/auxilium-platforms.md)

# Authors

!include(../include/authors.md)

# Legal

## Copyright

!include(../include/copyright.ppi.md)

## Licensing

!include(../include/license.md)

# See Also

* <https://ericmotleybytes.github.io/auxilium/> : The Auxilium Information
  and Downloads site.

* <https://github.com/ericmotleybytes/auxilium> : The master auxilium
  GitHub repository. You can also report bugs, describe issues, and
  request enhancements here.

* <http://blog.scottlowe.org/2015/01/27/using-fork-branch-git-workflow/> : A
  good tutorial on the GitHub "fork and branch" workflow.

* <https://help.github.com/articles/fork-a-repo/> : GitHub documentation about
  how to "fork" a repository.

* <https://github.com/sstephenson/bats> :  Bats, the Bash Automated Testing System.

* <http://pandoc.org/> : Pandoc information page.

* <https://github.com/jgm/pandoc> : Pandoc GitHub page. 

* <http://www.tug.org/texlive/LaTeX> : The 'TeX Live' LaTeX system.

* <http://cdsoft.fr/pp/> : "pp", the pandoc preprocessor.

* <https://github.com/CDSoft/pp> : "pp", the pandoc preprocessor on GitHub.

* <https://testanything.org/> : A description of TAP,
  the unit testing Test Anything Protocol.
