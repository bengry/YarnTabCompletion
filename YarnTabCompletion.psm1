Import-Module TabExpansionPlusPlus

function YarnCompletion {
  param($wordToComplete, $commandAst)

  Set-Alias -Name nct -Value New-CommandTree

  $commandTree = & {
    nct access 'Set access level on published packages' {
      nct public 'Set a package to be publicly accessible'
      nct restricted 'Set a package to be restricted'
      nct grant 'Grant the ability of users and teams to have read-only or read-write access to a package' {
        nct 'read-only' 'tt'
        nct 'read-write' 'tt'
        nct 'scope:' 'tt'
      }
      nct revoke "Revoke the ability of users and teams" {
        nct "scope:team" "the team"
      }
      nct ls-packages "Show all of the packages a user or a team is able to access, along with the access level, except for read-only public packages"
      nct ls-collaborators "Show all of the access privileges for a package. Will only show permissions for packages to which you have at least read access"
      nct edit 'Set the access privileges for a package at once using $EDITOR'
    }

    nct add 'install in package directory' {
      nct -Argument "--dev" "Package will appear in your devDependencies"
      nct -Argument "-D" "Package will appear in your devDependencies"
      nct -Argument "--optional" "Package will appear in your optionalDependencies"
      nct -Argument "-O" "Package will appear in your optionalDependencies"
      nct -Argument "--peer" "Package will appear in your peerDependencies"
      nct -Argument "-P" "Package will appear in your peerDependencies"
    }
    nct bin 'Display Yarn bin folder' {}
    nct build 'Build a package' {}
    nct cache 'Manipulates packages cache' {}
    nct config 'Manage the Yarn configuration files' {}
    nct test 'Test a package' {}
    nct remove 'Remove a package' {}
    nct version 'Bump a package version' {}
    nct help 'Get help on Yarn' {}
    nct init 'Interactively create a package.json file' {}
    nct link 'Symlink a package folder' {}
    nct unlink 'Unlink a package folder' {}
    nct pack 'Create a tarball from a package' {}
    nct publish 'Publish a package' {}
    nct install 'Install all dependencies for a project' {}
    nct prune 'Remove extraneous packages' {}
    nct list 'List installed packages' {}
    nct autoclean 'Frees up space by removing unnecessary files and folders from dependencies' {}
    nct check 'Verifies that versions of the package dependencies in the current project’s package.json matches that of yarn’s lock file' {}
    nct create 'Creates new projects from any `create-*` starter kits' {}
    nct global 'Prefix for commands like `add`, `bin`, `list`, `remove` and `upgrade`' {}
    nct import 'Generates `yarn.lock` from an existing npm-installed `node_modules` folder' {}
    nct info 'Show information about a package' {}
    nct licenses 'list, in alphabetical order all of the packages that were installed by yarn or yarn install, and give you the license (and URL to the source code) associated with each package' {}
    nct login 'prompt you for your username and email for the npm registry' {}
    nct logout 'remove your stored username and email for the npm registry as setup by `yarn login`' {}
    nct generate-lock-entry 'Generates a lock file entry. Note: This command is considered for advanced use-cases and tooling only. It generates a lock file entry given the current `package.json` manifest file.' {}
    nct outdated 'Checks for outdated package dependencies' {}
    nct owner 'Manage package owners' {}
    nct pack 'Creates a compressed gzip archive of package dependencies' {}
    nct self-update 'Updates Yarn to the latest version' {}
    nct self-update 'Updates Yarn to the latest version' {}
    nct tag 'Add, remove, or list tags on a package' {}
    nct team 'Maintain team memberships' {}
    nct test 'Runs the test script defined by the package' {}
    nct start 'Runs the start script defined by the package' {}
    nct upgrade 'Upgrades packages to their latest version based on the specified range' {}
    nct upgrade-interactive 'This is similar to npm-check interactive update mode. It provides an easy way to update outdated packages' {}
    nct versions 'Displays version information of the currently installed Yarn, Node.js, and its dependencies' {}
    nct why 'Show information about why a package is installed' {}

    nct run 'Run arbitrary package scripts' {
      nct {
        param($wordToComplete, $commandAst)

        $scripts = (Get-Content .\package.json | ConvertFrom-Json).scripts
        $scripts | Get-Member -MemberType NoteProperty |
          ForEach-Object {
          $target = $scripts.($_.Name)
          New-CompletionResult $_.Name "$($target)"
        }
      }
    }
  }

  Get-CommandTreeCompletion $wordToComplete $commandAst $commandTree
}

YarnCompletion

Register-ArgumentCompleter -Command 'yarn' -Native -ScriptBlock $function:YarnCompletion -Description 'Complete parameters and arguments to yarn.cmd'