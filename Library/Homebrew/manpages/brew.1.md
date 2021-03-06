brew(1) -- The missing package manager for OS X
===============================================

## SYNOPSIS

`brew` --version<br>
`brew` command [--verbose|-v] [options] [formula] ...

## DESCRIPTION

Tigerbrew is the easiest and most flexible way to install the UNIX tools Apple
didn't include with OS X.

## ESSENTIAL COMMANDS

For the full command list, see the COMMANDS section.

With `--verbose` or `-v`, many commands print extra debugging information.
Note that these flags should only appear after a command.

  * `install` <formula>:
    Install <formula>.

  * `remove` <formula>:
    Uninstall <formula>.

  * `update`:
    Fetch the newest version of Tigerbrew from GitHub using `git`(1).

  * `list`:
    List all installed formulae.

  * `search` <text>|/<text>/:
    Perform a substring search of formula names for <text>. If <text> is
    surrounded with slashes, then it is interpreted as a regular expression.
    The search for <text> is extended online to some popular taps.
    If no search term is given, all locally available formulae are listed.

## COMMANDS

  * `audit` [--strict] [<formulae>]:
    Check <formulae> for Tigerbrew coding style violations. This should be
    run before submitting a new formula.

    If no <formulae> are provided, all of them are checked.

    If `--strict` is passed, additional checks are run. This should be used
    when creating for new formulae.

    `audit` exits with a non-zero status if any errors are found. This is useful,
    for instance, for implementing pre-commit hooks.

  * `cat` <formula>:
    Display the source to <formula>.

  * `cleanup [--force] [--prune=<days>] [-ns]` [<formulae>]:
    For all installed or specific formulae, remove any older versions from the
    cellar. By default, does not remove out-of-date keg-only brews, as other
    software may link directly to specific versions. In addition old downloads from
    the Tigerbrew download-cache are deleted.

    If `--force` is passed, remove out-of-date keg-only brews as well.

    If `--prune=<days>` is specified, remove all cache files older than <days>.

    If `-n` is passed, show what would be removed, but do not actually remove anything.

    If `-s` is passed, scrubs the cache, removing downloads for even the latest
    versions of formula. Note downloads for any installed formula will still not be
    deleted. If you want to delete those too: `rm -rf $(brew --cache)`

  * `commands`:
    Show a list of built-in and external commands.

  * `config`:
    Show Tigerbrew and system configuration useful for debugging. If you file
    a bug report, you will likely be asked for this information if you do not
    provide it.

  * `create <URL> [--autotools|--cmake] [--no-fetch] [--set-name <name>] [--set-version <version>]`:
    Generate a formula for the downloadable file at <URL> and open it in the editor.
    Tigerbrew will attempt to automatically derive the formula name
    and version, but if it fails, you'll have to make your own template. The wget
    formula serves as a simple example. For a complete cheat-sheet, have a look at

    `$(brew --repository)/Library/Contributions/example-formula.rb`

    If `--autotools` is passed, create a basic template for an Autotools-style build.
    If `--cmake` is passed, create a basic template for a CMake-style build.

    If `--no-fetch` is passed, Tigerbrew will not download <URL> to the cache and
    will thus not add the SHA-1 to the formula for you.

    The options `--set-name` and `--set-version` each take an argument and allow
    you to explicitly set the name and version of the package you are creating.

  * `deps [--1] [-n] [--union] [--tree] [--all] [--installed] [--skip-build] [--skip-optional]` <formulae>:
    Show dependencies for <formulae>. When given multiple formula arguments,
    show the intersection of dependencies for <formulae>, except when passed
    `--tree`, `--all`, or `--installed`.

    If `--1` is passed, only show dependencies one level down, instead of
    recursing.

    If `-n` is passed, show dependencies in topological order.

    If `--union` is passed, show the union of dependencies for <formulae>,
    instead of the intersection.

    If `--tree` is passed, show dependencies as a tree.

    If `--all` is passed, show dependencies for all formulae.

    If `--installed` is passed, show dependencies for all installed formulae.

    By default, `deps` shows dependencies for <formulae>. To skip the `:build`
    type dependencies, pass `--skip-build`. Similarly, pass `--skip-optional`
    to skip `:optional` dependencies.

  * `diy [--name=<name>] [--version=<version>]`:
    Automatically determine the installation prefix for non-Tigerbrew software.

    Using the output from this command, you can install your own software into
    the Cellar and then link it into Tigerbrew's prefix with `brew link`.

    The options `--name=<name>` and `--version=<version>` each take an argument
    and allow you to explicitly set the name and version of the package you are
    installing.

  * `doctor`:
    Check your system for potential problems. Doctor exits with a non-zero status
    if any problems are found.

  * `edit`:
    Open all of Tigerbrew for editing.

  * `edit` <formula>:
    Open <formula> in the editor.

  * `fetch [--force] [-v] [--devel|--HEAD] [--deps] [--build-from-source|--force-bottle]` <formulae>:
    Download the source packages for the given <formulae>.
    For tarballs, also print SHA1 and SHA-256 checksums.

    If `--HEAD` or `--devel` is passed, fetch that version instead of the
    stable version.

    If `-v` is passed, do a verbose VCS checkout, if the url represents a CVS.
    This is useful for seeing if an existing VCS cache has been updated.

    If `--force` is passed, remove a previously cached version and re-fetch.

    If `--deps` is passed, also download dependencies for any listed <formulae>.

    If `--build-from-source` is passed, download the source rather than a
    bottle.

    If `--force-bottle` is passed, download a bottle if it exists for the current
    version of OS X, even if it would not be used during installation.

  * `home`:
    Open Tigerbrew's own homepage in a browser.

  * `home` <formula>:
    Open <formula>'s homepage in a browser.

  * `info` <formula>:
    Display information about <formula>.

  * `info --github` <formula>:
    Open a browser to the GitHub History page for formula <formula>.

    To view formula history locally: `brew log -p <formula>`.

  * `info --json=<version>` (--all|--installed|<formulae>):
    Print a JSON representation of <formulae>. Currently the only accepted value
    for <version> is `v1`.

    Pass `--all` to get information on all formulae, or `--installed` to get
    information on all installed formulae.

    See the docs for examples of using the JSON:
    <https://github.com/mistydemeo/tigerbrew/blob/master/share/doc/homebrew/Querying-Brew.md>

  * `install [--debug] [--env=<std|super>] [--ignore-dependencies] [--only-dependencies] [--cc=<compiler>] [--build-from-source] [--devel|--HEAD]` <formula>:
    Install <formula>.

    <formula> is usually the name of the formula to install, but it can be specified
    several different ways. See [SPECIFYING FORMULAE][].

    If `--debug` is passed and brewing fails, open an interactive debugging
    session with access to IRB or a shell inside the temporary build directory.

    If `--env=std` is passed, use the standard build environment instead of superenv.

    If `--env=super` is passed, use superenv even if the formula specifies the
    standard build environment.

    If `--ignore-dependencies` is passed, skip installing any dependencies of
    any kind. If they are not already present, the formula will probably fail
    to install.

    If `--only-dependencies` is passed, install the dependencies with specified
    options but do not install the specified formula.

    If `--cc=<compiler>` is passed, attempt to compile using <compiler>.
    <compiler> should be the name of the compiler's executable, for instance
    `gcc-4.2` for Apple's GCC 4.2, or `gcc-4.9` for a Tigerbrew-provided GCC
    4.9.

    If `--build-from-source` is passed, compile from source even if a bottle
    is provided for <formula>.

    If `--devel` is passed, and <formula> defines it, install the development version.

    If `--HEAD` is passed, and <formula> defines it, install the HEAD version,
    aka master, trunk, unstable.

    To install a newer version of HEAD use
    `brew rm <foo> && brew install --HEAD <foo>`.

  * `install --interactive [--git]` <formula>:
    Download and patch <formula>, then open a shell. This allows the user to
    run `./configure --help` and otherwise determine how to turn the software
    package into a Tigerbrew formula.

    If `--git` is passed, Tigerbrew will create a Git repository, useful for
    creating patches to the software.

  * `irb [--example]`:
    Enter the interactive Tigerbrew Ruby shell.

    If `--example` is passed, several examples will be shown.

  * `leaves`:
    Show installed formulae that are not dependencies of another installed formula.

  * `ln`, `link [--overwrite] [--dry-run] [--force]` <formula>:
    Symlink all of <formula>'s installed files into the Tigerbrew prefix. This
    is done automatically when you install formula, but can be useful for DIY
    installations.

    If `--overwrite` is passed, Tigerbrew will delete files which already exist in
    the prefix while linking.

    If `--dry-run` or `-n` is passed, Tigerbrew will list all files which would
    be linked or which would be deleted by `brew link --overwrite`, but will not
    actually link or delete any files.

    If `--force` is passed, Tigerbrew will allow keg-only formulae to be linked.

  * `linkapps [--local]` [<formulae>]:
    Find installed formulae that have compiled `.app`-style "application"
    packages for OS X, and symlink those apps into `/Applications`, allowing
    for easier access.

    If no <formulae> are provided, all of them will have their .apps symlinked.

    If provided, `--local` will move them into the user's `~/Applications`
    folder instead of the system folder. It may need to be created, first.

  * `ls, list [--unbrewed] [--versions [--multiple]] [--pinned]` [<formulae>]:
    Without any arguments, list all installed formulae.

    If <formulae> are given, list the installed files for <formulae>.
    Combined with `--verbose`, recursively list the contents of all subdirectories
    in each <formula>'s keg.

    If `--unbrewed` is passed, list all files in the Tigerbrew prefix not installed
    by Tigerbrew.

    If `--versions` is passed, show the version number for installed formulae,
    or only the specified formulae if <formulae> are given. With `--multiple`,
    only show formulae with multiple versions installed.

    If `--pinned` is passed, show the versions of pinned formulae, or only the
    specified (pinned) formulae if <formulae> are given.
    See also `pin`, `unpin`.

  * `log [git-log-options]` <formula> ...:
    Show the git log for the given formulae. Options that `git-log`(1)
    recognizes can be passed before the formula list.

  * `missing` [<formulae>]:
    Check the given <formulae> for missing dependencies.

    If no <formulae> are given, check all installed brews.

  * `options [--compact] [--all] [--installed]` <formula>:
    Display install options specific to <formula>.

    If `--compact` is passed, show all options on a single line separated by
    spaces.

    If `--all` is passed, show options for all formulae.

    If `--installed` is passed, show options for all installed formulae.

  * `outdated [--quiet|--verbose]`:
    Show formulae that have an updated version available.

    By default, version information is displayed in interactive shells, and
    suppressed otherwise.

    If `--quiet` is passed, list only the names of outdated brews (takes
    precedence over `--verbose`).

    If `--verbose` is passed, display detailed version information.

  * `pin` <formulae>:
    Pin the specified <formulae>, preventing them from being upgraded when
    issuing the `brew upgrade` command without arguments. See also `unpin`.

  * `prune`:
    Remove dead symlinks from the Tigerbrew prefix. This is generally not
    needed, but can be useful when doing DIY installations.

  * `reinstall` <formula>:
    Uninstall then install <formula>

  * `rm`, `remove`, `uninstall [--force]` <formula>:
    Uninstall <formula>.

    If `--force` is passed, and there are multiple versions of <formula>
    installed, delete all installed versions.

  * `search`, `-S`:
    Display all locally available formulae for brewing (including tapped ones).
    No online search is performed if called without arguments.

  * `search`, `-S` <text>|/<text>/:
    Perform a substring search of formula names for <text>. If <text> is
    surrounded with slashes, then it is interpreted as a regular expression.
    The search for <text> is extended online to some popular taps.

  * `search --debian`|`--fedora`|`--fink`|`--macports`|`--opensuse`|`--ubuntu` <text>:
    Search for <text> in the given package manager's list.

  * `sh [--env=std]`:
    Instantiate a Tigerbrew build environment. Uses our years-battle-hardened
    Tigerbrew build logic to help your `./configure && make && make install`
    or even your `gem install` succeed. Especially handy if you run Tigerbrew
    in a Xcode-only configuration since it adds tools like make to your PATH
    which otherwise build-systems would not find.

  * `switch` <name> <version>:
    Symlink all of the specific <version> of <name>'s install to Tigerbrew prefix.

  * `tap` [<tap>]:
    Tap a new formula repository from GitHub, or list existing taps.

    <tap> is of the form <user>/<repo>, e.g. `brew tap homebrew/dupes`.

  * `tap --repair`:
    Ensure all tapped formulae are symlinked into Library/Formula and prune dead
    formulae from Library/Formula.

  * `test` [--devel|--HEAD] [--debug] <formula>:
    A few formulae provide a test method. `brew test <formula>` runs this
    test method. There is no standard output or return code, but it should
    generally indicate to the user if something is wrong with the installed
    formula.

    To test the development or head version of a formula, use `--devel` or
    `--HEAD`.

    If `--debug` is passed and the test fails, an interactive debugger will be
    launched with access to IRB or a shell inside the temporary test directory.

    Example: `brew install jruby && brew test jruby`

  * `unlink` <formula>:
    Remove symlinks for <formula> from the Tigerbrew prefix. This can be useful
    for temporarily disabling a formula:
    `brew unlink foo && commands && brew link foo`.

  * `unlinkapps [--local]` [<formulae>]:
    Removes links created by `brew linkapps`.

    If no <formulae> are provided, all linked app will be removed.

  * `unpack [--git|--patch] [--destdir=<path>]` <formulae>:
    Unpack the source files for <formulae> into subdirectories of the current
    working directory. If `--destdir=<path>` is given, the subdirectories will
    be created in the directory named by `<path>` instead.

    If `--patch` is passed, patches for <formulae> will be applied to the
    unpacked source.

    If `--git` is passed, a Git repository will be initalized in the unpacked
    source. This is useful for creating patches for the software.

  * `unpin` <formulae>:
    Unpin <formulae>, allowing them to be upgraded by `brew upgrade`. See also
    `pin`.

  * `untap` <tap>:
    Remove a tapped repository.

  * `update [--rebase]`:
    Fetch the newest version of Tigerbrew and all formulae from GitHub using
     `git`(1).

    If `--rebase` is specified then `git pull --rebase` is used.

  * `upgrade [--all] [install-options]` [<formulae>]:
    Upgrade outdated, unpinned brews.

    Options for the `install` command are also valid here.

    If `--all` is passed, upgrade all formulae. This is currently the same
    behaviour as without `--all` but soon `--all` will be required to upgrade
    all formulae.

    If <formulae> are given, upgrade only the specified brews (but do so even
    if they are pinned; see `pin`, `unpin`).

  * `uses [--installed] [--recursive] [--skip-build] [--skip-optional] [--devel|--HEAD]` <formulae>:
    Show the formulae that specify <formulae> as a dependency. When given
    multiple formula arguments, show the intersection of formulae that use
    <formulae>.

    Use `--recursive` to resolve more than one level of dependencies.

    If `--installed` is passed, only list installed formulae.

    By default, `uses` shows all formulae that specify <formulae> as a dependency.
    To skip the `:build` type dependencies, pass `--skip-build`. Similarly, pass
    `--skip-optional` to skip `:optional` dependencies.

    By default, `uses` shows usages of `formula` by stable builds. To find
    cases where `formula` is used by development or HEAD build, pass
    `--devel` or `--HEAD`.

  * `--cache`:
    Display Tigerbrew's download cache. See also `HOMEBREW_CACHE`.

  * `--cache` <formula>:
    Display the file or directory used to cache <formula>.

  * `--cellar`:
    Display Tigerbrews's Cellar path. *Default:* `/usr/local/Cellar`

  * `--cellar` <formula>:
    Display the location in the cellar where <formula> would be installed,
    without any sort of versioned directory as the last path.

  * `--env`:
    Show a summary of the Tigerbrews build environment.

  * `--prefix`:
    Display Tigerbrews's install path. *Default:* `/usr/local`

  * `--prefix` <formula>:
    Display the location in the cellar where <formula> is or would be installed.

  * `--repository`:
    Display where Tigerbrews's `.git` directory is located. For standard installs,
    the `prefix` and `repository` are the same directory.

  * `--version`:
    Print the version number of brew to standard error and exit.

## EXTERNAL COMMANDS

Tigerbrews, like `git`(1), supports external commands. These are executable
scripts that reside somewhere in the PATH, named `brew-<cmdname>` or
`brew-<cmdname>.rb`, which can be invoked like `brew cmdname`. This allows you
to create your own commands without modifying Tigerbrews's internals.

Instructions for creating your own commands can be found in the docs:
<https://github.com/mistydemeo/tigerbrew/blob/master/share/doc/homebrew/External-Commands.md>

## SPECIFYING FORMULAE

Many Tigerbrew commands accept one or more <formula> arguments. These arguments
can take several different forms:

  * The name of a formula:
    e.g. `git`, `node`, `wget`.

  * The fully-qualified name of a tapped formula:
    Sometimes a formula from a tapped repository may conflict with one in mistydemeo/tigerbrew.
    You can still access these formulae by using a special syntax, e.g.
    `homebrew/dupes/vim` or `homebrew/versions/node4`.

  * An arbitrary URL:
    Tigerbrew can install formulae via URL, e.g.
    `https://raw.github.com/mistydemeo/tigerbrew/master/Library/Formula/git.rb`.
    The formula file will be cached for later use.

## ENVIRONMENT

  * AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY:
    When using the S3 download strategy, Tigerbrew will look in
    these variables for access credentials (see
    <https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-environment>
    to retrieve these access credentials from AWS).  If they are not set,
    the S3 download strategy will download with a public
    (unsigned) URL.

  * BROWSER:
    If set, and `HOMEBREW_BROWSER` is not, use `BROWSER` as the web browser
    when opening project homepages.

  * EDITOR:
    If set, and `HOMEBREW_EDITOR` and `VISUAL` are not, use `EDITOR` as the text editor.

  * GIT:
    When using Git, Tigerbrew will use `GIT` if set,
    a Tigerbrew-built Git if installed, or the system-provided binary.

    Set this to force Tigerbrew to use a particular git binary.

  * HOMEBREW_BROWSER:
    If set, uses this setting as the browser when opening project homepages,
    instead of the OS default browser.

  * HOMEBREW\_BUILD\_FROM\_SOURCE:
    If set, instructs Tigerbrew to compile from source even when a formula
    provides a bottle.

  * HOMEBREW\_CACHE:
    If set, instructs Tigerbrew to use the given directory as the download cache.

    *Default:* `~/Library/Caches/Homebrew` if it exists; otherwise,
    `/Library/Caches/Homebrew`.

  * HOMEBREW\_CURL\_VERBOSE:
    If set, Tigerbrew will pass `--verbose` when invoking `curl`(1).

  * HOMEBREW\_DEBUG:
    If set, any commands that can emit debugging information will do so.

  * HOMEBREW\_DEBUG\_INSTALL:
    When `brew install -d` or `brew install -i` drops into a shell,
    `HOMEBREW_DEBUG_INSTALL` will be set to the name of the formula being
    brewed.

  * HOMEBREW\_DEBUG\_PREFIX:
    When `brew install -d` or `brew install -i` drops into a shell,
    `HOMEBREW_DEBUG_PREFIX` will be set to the target prefix in the Cellar
    of the formula being brewed.

  * HOMEBREW\_DEVELOPER:
    If set, Tigerbrew will print warnings that are only relevant to Tigerbrew
    developers (active or budding).

  * HOMEBREW\_EDITOR:
    If set, Tigerbrew will use this editor when editing a single formula, or
    several formulae in the same directory.

    *NOTE*: `brew edit` will open all of Tigerbrew as discontinuous files and
    directories. TextMate can handle this correctly in project mode, but many
    editors will do strange things in this case.

  * HOMEBREW\_GITHUB\_API\_TOKEN:
    A personal GitHub API Access token, which you can create at
    <https://github.com/settings/applications>. If set, GitHub will allow you a
    greater number of API requests. See
    <https://developer.github.com/v3/#rate-limiting> for more information.
    Tigerbrew uses the GitHub API for features such as `brew search`.

  * HOMEBREW\_MAKE\_JOBS:
    If set, instructs Tigerbrew to use the value of `HOMEBREW_MAKE_JOBS` as
    the number of parallel jobs to run when building with `make`(1).

    *Default:* the number of available CPU cores.

  * HOMEBREW\_NO\_EMOJI:
    If set, Tigerbrew will not print the `HOMEBREW_INSTALL_BADGE` on a
    successful build.

    *Note:* Tigerbrew will only try to print emoji on Lion or newer.

  * HOMEBREW\_NO\_GITHUB\_API:
    If set, Tigerbrew will not use the GitHub API for e.g searches or
    fetching relevant issues on a failed install.

  * HOMEBREW\_INSTALL\_BADGE:
    Text printed before the installation summary of each successful build.
    Defaults to the beer emoji.

  * HOMEBREW\_SVN:
    When exporting from Subversion, Tigerbrew will use `HOMEBREW_SVN` if set,
    a Tigerbrew-built Subversion if installed, or the system-provided binary.

    Set this to force Tigerbrew to use a particular svn binary.

  * HOMEBREW\_TEMP:
    If set, instructs Tigerbrew to use `HOMEBREW_TEMP` as the temporary directory
    for building packages. This may be needed if your system temp directory and
    Tigerbrew Prefix are on different volumes, as OS X has trouble moving
    symlinks across volumes when the target does not yet exist.

    This issue typically occurs when using FileVault or custom SSD
    configurations.

  * HOMEBREW\_VERBOSE:
    If set, Tigerbrew always assumes `--verbose` when running commands.

  * VISUAL:
    If set, and `HOMEBREW_EDITOR` is not, use `VISUAL` as the text editor.

## USING TIGERBREW BEHIND A PROXY

Tigerbrew uses several commands for downloading files (e.g. curl, git, svn).
Many of these tools can download via a proxy. It's common for these tools
to read proxy parameters from environment variables.

For the majority of cases setting `http_proxy` is enough. You can set this in
your shell profile, or you can use it before a brew command:

    http_proxy=http://<host>:<port> brew install foo

If your proxy requires authentication:

    http_proxy=http://<user>:<password>@<host>:<port> brew install foo

## SEE ALSO

Tigerbrew Documentation: <https://github.com/mistydemeo/tigerbrew/blob/master/share/doc/homebrew/>

`git`(1), `git-log`(1)

## AUTHORS

Tigerbrew's current maintainer is Misty De Meo.

Homebrew was originally created by Max Howell.

## BUGS

See Issues on GitHub: <http://github.com/mistydemeo/tigerbrew/issues>
