## Prerequisite

Download and install [Git](https://git-scm.com/) for your operating system.

> Windows users may wish to investigate the Windows Subsystem for Linux (V2 or higher) as most Linux distributions include Git as standard. 

## Configure git for the first time

There are 3 levels of Git configuration: system, global, and project. Project configuration overrides global configuration which overrides system configuration. Usually we only need to set configuration at global and project levels.

Project level configuration is only applied to the current project. To set a project level configuration, navigate to the project root directory and execute the following:

```shell
git config user.name "Your Name"
git config user.email "Your Email Address"
```

If there is configuration you want to apply to all projects, you can configure them at global level by executing the following:

```shell
git config --global user.name "Your Name"
git config --global user.email "Your Email Address"
```

You may also need to set up a network proxy for talking to GitHub:

```shell
git config --global http.proxy http://proxyuser:proxypwd@proxy.example.com:80
```

You will also need to install a certificate chain to avoid getting self-signed cert errors. **DO NOT** disable SSL verification - you _want_ git to ensure you're talking to the right servers!

## Working with code

Create a local directory where you want to put all your local Git repositories. For example, the directory can be:

```shell
pwd
/path/to/your/local/git/location
```

On Windows, the file path will look different, but the idea is the same.

### Clone an existing repo

```shell
cd /path/to/your/local/git/location

git clone https://github.sompeplace.com/some/cool/code-project.git
```

Check your local repository now:

```shell
cd code-project

ls # or dir on Windows
```

You should see all the project source code checked out in the `code-project` folder. To begin with, only the `master` branch is available.

### Work with an existing remote branch

List remote branches:

```shell
git branch -r
  origin/HEAD -> origin/master
  origin/master
  origin/branch-1
  origin/branch-2
```

Check out the remote branch you want to work on (i.e. `branch-2`):

```shell
git checkout branch-2
```

You are now on branch `“branch-2”`:

```shell
git branch --list
  master
* branch-2
```

After you have edited files, check the status of your local repository:

```shell
git status
On branch branch-2
...
```

Pull the latest changes from remote repository:

```shell
git pull
```

Stage all your changes at once:

```shell
git add --all
```

Or, stage them interactively:

```shell
git add -p
```

Commit all your local changes:

```shell
git commit -a -m "Comment for committing"
```

Note: if you commit without the `-m` flag git will drop you into whatever default editor you have configured. It is possible to configure many different text editors depending on your preference. Visual Studio Code, Notepad++, vim, and many others can be configured to work with git.

Push your local change to the remote repository branch. You'll almost always want to do a `git pull` before you push:

```shell
git push origin branch-2
```

### Start a new local branch to work on (using “new-branch” as example)

```shell
git checkout -b new-branch
```

See all branches:

```shell
git branch
  master
* new-branch
```

After you make changes to the branch, you can commit and push this new branch to the remote repository:

```shell
git add --all
```

```shell
git commit -a -m "Comment for committing"
```

```shell
git status
On branch new-branch
nothing to commit, working tree clean
```

Push your local branch to the remote repository:

```
git push origin new-branch
```

## Useful git commands

Find the URL of the remote repository

```
git remote show origin

# OR

git config --get remote.origin.url

# OR

git remote -v
```

List remote branches:

```
git branch -r
```

Switch to a different branch:

```shell
git checkout branch-name
```

List local changes which haven’t been committed:

```shell
git status
```

Show history of changes:

```shell
git log
```

## Understanding the difference between repository, index, and working tree

Learning git can be pretty confusing, especially if you've only used tools like CVS, SVN, Perforce, etc. Something that many people struggle with is git's content-addressable file system and the concept of the "index" where you stage changes for commit.

These links help illustrate the git mental model:
* [Git Working Tree and Index](https://backlog.com/git-tutorial/en/intro/intro1_4.html)
* [Understanding the Git index](http://alblue.bandlem.com/2011/10/git-tip-of-week-understanding-index.html)
* [Difference between HEAD and working tree - Stack Overflow](https://stackoverflow.com/questions/3689838/whats-the-difference-between-head-working-tree-and-index-in-git)

## References / Helpful Reading

These links may be valuable:

* [Official Reference Manual](https://git-scm.com/docs)
* [Git Book](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control)
* [Atlassian's Git Tutorial](https://www.atlassian.com/git/tutorials/)

