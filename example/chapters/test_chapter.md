# Install Ruby

After following many outdated and incomplete instructions for setting up a web development environment on a Mac (back in March 2012), and spending a lot of time finding solutions to the problems I encountered along the way, I decided to put together this detailed tutorial.

Over time, the tools got better, and ever since Mavericks, setting up a development environment on a Mac with Apple's standalone Command Line Tools, Homebrew, Git, a Ruby manager (such as chruby, rbenv, or RVM), Ruby, and Rails has been a fairly stress-free process that's no longer fraught with the issues I ran into in 2012.

**In fact, the whole process can now be automated via the [script](/ruby-script) that I wrote for you**. 

While it's certainly possible to set everything up manually, it's not as straightforward to explain because there are more options to consider in 2021. For example, the installation instructions will differ [depending on your shell](https://www.moncefbelyamani.com/which-shell-am-i-using-how-can-i-switch/) (Bash, zsh or fish), or if you are using a Mac with the [Apple Silicon (M1)](https://www.moncefbelyamani.com/how-to-install-homebrew-and-ruby-on-a-mac-with-the-m1-apple-silicon-chip/) chip versus an Intel chip.

**My script is smart enough to detect your current setup and install everything in the right place.**

If you prefer to do everything manually, keep reading. This tutorial is kept up to date and is guaranteed to work in 2021.

## Prerequisites

Supported macOS versions:

- Big Sur
- Catalina
- Mojave

### Your macOS software is up to date
Before you start, make sure you have the latest Apple software updates for your current macOS version. Check by going to System Preferences, then Software Update.

### Homebrew is ready to brew
You can skip this section if you know you haven't tried to install Homebrew yet. If you're not sure, check the contents of the `/usr/local` folder (also check `/opt/homebrew` if you're on a Mac with the Apple Silicon chip). Run this command in the `Terminal` app:

```shell
ls /usr/local
```
If there's nothing in the folder, then you don't have Homebrew.

If you've already installed Homebrew, you'll want to make sure that when you run `brew doctor`, it says `Your system is ready to brew`.

If it's not ready to brew, one of the most common issues, **and the first one you should fix**, is missing or outdated Command Line Tools. The outdated tools message looks like this:

```console
Warning: A newer Command Line Tools release is available.
Update them from Software Update in System Preferences or run:
  softwareupdate --all --install --force

If that doesn't show you any updates, run:
  sudo rm -rf /Library/Developer/CommandLineTools
  sudo xcode-select --install

Alternatively, manually download them from:
  https://developer.apple.com/download/more/.
```
Here are other variations of the outdated message:

```shell
Warning: Your Command Line Tools are too outdated.
```

```shell
Warning: Your Command Line Tools (CLT) does not support macOS 11.
It is either outdated or was modified.
Please update your Command Line Tools (CLT) or delete it if no updates are available.
```

The missing tools message looks like this:

```shell
Warning: No developer tools installed.
Install the Command Line Tools:
  xcode-select --install
```

Homebrew usually provides detailed instructions for fixing things, so read carefully and follow their instructions. Quit and restart Terminal once the CLT are installed.

If you get errors other than the ones above, read through the [Troubleshooting Homebrew](#troubleshooting-homebrew-warnings-and-errors) section at the bottom of this guide.

### You don't have RVM or rbenv installed
Back in 2012, I used to use RVM, but once I automated this process, RVM kept breaking my script, so I switched to the much simpler `chruby` and have been using it happily every since. `chruby` is not compatible with RVM and rbenv, so you'll need to uninstall them first.

#### Uninstall RVM
```shell
rvm implode
```

Then delete any lines related to RVM from these files if they exist:

- `~/.bash_profile`
- `~/.zshrc`
- `~/.zprofile`

#### Uninstall rbenv
Follow the [rbenv uninstallation instructions](https://github.com/rbenv/rbenv#uninstalling-rbenv), then delete any lines related to `rbenv` from these files if they exist:

- `~/.bash_profile`
- `~/.zshrc`
- `~/.zprofile`

If you don't know what the `~` means, or how to edit the files above, read my guide about [how to open and edit hidden files (or dotfiles) on a Mac](https://www.moncefbelyamani.com/5-ways-to-open-hidden-files-on-your-mac/).

## Installation

### Notes on Terminal
Most of the work you'll be doing in this tutorial will be in the "Terminal" application.
The easiest way to open an application in macOS is to search for it via [Spotlight](https://support.apple.com/en-us/HT204014). 

The default keyboard shortcut for invoking Spotlight is `command-Space`. Once Spotlight is up, start typing the first few letters of the app you are looking for, and once it appears, select it, and press `return` to launch it. 

**If you are on an M1 Mac, make sure Terminal is NOT in Rosetta mode.**

You can check by running this command once Terminal opens:

```shell
uname -m
```

It should say `arm64` if you are on an M1 Mac. If it says `x86_4`, that means Terminal is in Rosetta mode. The only way this could happen is if you changed the setting yourself, most likely after following incorrect or outdated advice. To turn off Rosetta, follow these instructions:

1. Quit Terminal if it's running
2. Go to the Finder
3. Go to the Utilities folder by pressing `shift-command-U` (or select "Go" from the menu bar, then select Utilities)
4. Select Terminal, but don't launch it. Just click once to select it.
5. Press `command-i` (or from the menu bar: "File", then "Get Info")
6. Uncheck the checkbox that says "Open using Rosetta"
7. Close the Terminal Info window
7. Launch Terminal
8. Run `uname -m`. It should now say `arm64` and you can proceed with the rest of this guide.

### Notes on your shell

This tutorials assumes you are using `zsh`. If you're not sure, read my guide to [find out which shell you are using](https://www.moncefbelyamani.com/which-shell-am-i-using-how-can-i-switch/), and replace any references to `.zshrc` in the steps below with `.bash_profile` if you are using Bash.

## Step 1: Install Homebrew and the Command Line Tools

[Homebrew](https://brew.sh/), "the missing package manager for macOS," allows you to easily install hundreds of open-source tools. The full installation instructions are available in the [Homebrew Documentation](https://docs.brew.sh/Installation), but you should only need to run the command that's listed at the top of the [Homebrew site](https://brew.sh/):

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Note that the command listed on the Homebrew site could change, so please make sure that what I have listed above is the same. If it isn't, please let me know and I'll update it.

Copy and paste the command into your Terminal window, press `return`, then read what appears in the Terminal, and pay attention to any instructions that require your input. For example, Homebrew will prompt for your macOS password. Note that Terminal does not provide visual feedback when you type your password. Just type it slowly and press return.

Homebrew also automatically installs the Apple Command Line Tools, and it usually installs them in the background, but in case this changes, pay attention if any windows appear that require your input.

Once the installation is successful, quit and restart Terminal, then check if Homebrew is ready to go:

```shell
brew doctor
```

If you get `Your system is ready to brew`, you can move on to [Step 2](#step-2-install-chruby-and-the-latest-ruby-with-ruby-install). Otherwise, read what Homebrew is saying very carefully. They usually provide great instructions that you should follow. If that doesn't help, go to the [Troubleshooting](#troubleshooting-homebrew-warnings-and-errors) section to learn how to fix errors and warnings you might run into.

On Apple Silicon Macs, Homebrew might tell you to run a few commands after the installation:

```shell
echo "eval $(/opt/homebrew/bin/brew shellenv)" >> ~/.zprofile
eval $(/opt/homebrew/bin/brew shellenv)
```

**Quit and restart Terminal**, then check if everything is working so far:

```shell
brew doctor
```

## Step 2: Install chruby and the latest Ruby with ruby-install 

Install `chruby` and `ruby-install`:

```shell
brew install chruby ruby-install
```

Install Ruby 2.7.2:

```shell
ruby-install ruby-2.7.2
```

> There is a newer version of Ruby (3.0.1), but it's not fully compatible with some gems such as Jekyll, so I recommend 2.7.2 to get started. You can always install any other available version of Ruby, in addition to 2.7.2. That's the advantage of using a Ruby manager like `chruby`. You can have multiple versions on your computer at the same time, and you can easily switch between them.

This will take a few minutes, and once it's done, configure your shell to automatically use `chruby`:

### For Intel Macs

```shell
echo "source /usr/local/share/chruby/chruby.sh" >> ~/.zshrc
echo "source /usr/local/share/chruby/auto.sh" >> ~/.zshrc
echo "chruby ruby-2.7.2" >> ~/.zshrc
```

### For Apple Silicon Macs

```shell
echo "source /opt/homebrew/opt/chruby/share/chruby/chruby.sh" >> ~/.zshrc
echo "source /opt/homebrew/opt/chruby/share/chruby/auto.sh" >> ~/.zshrc
echo "chruby ruby-2.7.2" >> ~/.zshrc
```

**Quit and relaunch Terminal**, then check that everything is working:

```shell
ruby -v
```

It should say `ruby 2.7.2p137`.

## Step 3: Configure Rubygems

Disable downloading documentation when install gems (for faster installation):

```shell
echo "gem: --no-document" >> ~/.gemrc
```

Make sure Rubygems is up to date:

```shell
gem update --system
```

## Step 4: Install and configure Bundler

Install Bundler:

```shell
gem install bundler
```

Configure Bundler to take advantage of your computer's cores:

```shell
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))
```

## Step 5: Install any other gem you want

Congrats! You now have a working Ruby development environment. You should now be able to installs Rails, or Jekyll, or whatever gem you've been trying to install for the past few days!

> If you got any value out of my tutorial, [join the 1400+ people](https://www.moncefbelyamani.com/newsletter/?utm_source=xcode) who are becoming confident coders through my quality guides and exclusive content in my free newsletter.

## Step 6: Install Git

[Git](https://git-scm.com/) is the [version control system](https://en.wikipedia.org/wiki/Revision_control) of choice among many web developers. With Homebrew, installing Git is as easy as this:

```shell
brew update
brew install git
```

Since we just installed Homebrew, we could have skipped `brew update`, but it's a good habit to run it before installing anything with Homebrew because Homebrew is updated regularly.

**Quit and relaunch Terminal**, then verify the Git installation:

```shell
git --version
```

You should get `git version 2.31.1` or later.

Next, you'll need to [configure Git with your name and email](https://www.moncefbelyamani.com/first-things-to-configure-before-using-git/), and other important settings.

## Next Steps

Once you start coding away on your computer, you will most likely need to install more tools with Homebrew. Before you do, remember to always run `brew update` and `brew doctor` to make sure your system is still ready to brew. To upgrade your existing packages, run `brew upgrade`. It's important to keep your development environment up to date, and Homebrew is just one of the tools you need to remember to update. 

Knowing when and how to automate is a sign of an effective engineer. Most things you do repeatedly will add up to a lot of wasted time if you don't find ways to speed them up.

That's why I recommend taking advantage of my [script](/ruby-script), which allows you to keep your system up to date by typing a single word in your Terminal. It does that by adding an alias, which is a shortcut for the longer command. If you're not familiar with aliases, read my guide about [how aliases can speed up your workflow](https://www.moncefbelyamani.com/create-aliases-in-bash-profile-to-assign-shortcuts-for-common-terminal-commands/).

## Troubleshooting Homebrew warnings and errors

### Consider starting over from scratch

Before you start looking through this list and trying to fix every warning and error, I would suggest a quick and easy solution: uninstall Homebrew and start over from scratch.

Before you do that, make a backup of everything you installed with Homebrew:

```shell
cd ~
mkdir backups
cd backups
brew bundle dump
```

This will create a `Brewfile` in your `~/backups` directory, which you can refer to later in case you're missing something you need. For now, I wouldn't worry about installing everything you used to have. It's better to start with a clean slate, and only add things that you absolutely need.

If you installed a database with Homebrew (such as Postgres), and stored data that you need, back it up first. It is unusual to have important data stored in a local database and nowehere else, but I'm mentioning it for completeness.

Then uninstall Homebrew:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

This will not completely remove all Homebrew folders, so you'll need to finish the job:

```shell
sudo rm -rf /usr/local
```

This will prompt you for your macOS password, and then it will say:

```shell
rm: /usr/local: Operation not permitted
```

This is expected because you can't delete the `/usr/local` folder itself, but you can delete anything inside it. On a brand new Mac, the `/usr/local` folder already exists, but it is empty.

To verify that Homebrew was completely removed, check the contents of the `/usr/local` folder:

```shell
ls /usr/local
```
It should be empty.

If you are on an M1 Mac, you'll also need to delete the `/opt/homebrew` directory:

```shell
sudo rm -rf /opt/homebrew
```
 
Verify that the `opt` folder no longer has anything inside it:

```shell
ls /opt 
```

Then go back to [step 1](#step-1-install-homebrew-and-the-command-line-tools), and after you complete this tutorial, if all your coding projects are still working, then you're good to go. Otherwise, if you get errors because tools are missing, install them as you need them with Homebrew.

### Fix brew issues one by one

In many cases, Homebrew will provide helpful instructions for dealing with warnings and errors, and I usually follow those instructions. I've tried to cover the most common sources of warnings and errors. 

If you run into an issue I haven't mentioned, try looking it up in the [Homebrew GitHub Issues](https://github.com/Homebrew/brew/issues), or search for the error message on [DuckDuckGo](https://duckduckgo.com). If that doesn't help, [subscribe to my newsletter](https://www.moncefbelyamani.com/newsletter/?utm_source=xcode) and I'll do my best to help you.

After you fix each issue, run `brew doctor` until you get `Your system is ready to brew`. Then go to [Step 2](#step-2-install-chruby-and-the-latest-ruby-with-ruby-install).

### PATH issues

If you get `Warning: /usr/bin occurs before /usr/local/bin`, run the command below (as recommended by Homebrew), and quit and relaunch Terminal:

```shell
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
```

Read my [guide about PATH](https://www.moncefbelyamani.com/troubleshooting-command-not-found-in-the-terminal/) to understand why this is important.

Other similar PATH issues you might see:

```shell
Warning: Homebrew's "sbin" was not found in your PATH but you have installed
formulae that put executables in /usr/local/sbin.
Consider setting your PATH for example like so:
  echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc
```

### Missing directory errors

```shell
Warning: The following directories do not exist:
/usr/local/Frameworks

You should create these directories and change their ownership to your user.
  sudo mkdir -p /usr/local/Frameworks
  sudo chown -R $(whoami) /usr/local/Frameworks
```

`sudo` allows you to run commands as a user with higher access rights, which is why it prompts you for your password, and `mkdir` stands for "make directory."

`chown` stands for "change owner," the `-R` flag applies this to all nested files and directories, and `whoami` is a variable that represents your macOS username. You should copy and paste the commands above as is.

### Permission errors

If you get `/usr/local/etc isn't writable` or `Cannot write to /usr/local/Cellar` or if it complains that any directories inside `/usr/local` aren't writable, fix it with this command:

```shell
sudo chown -R $(whoami) /usr/local
```

This makes you the owner of the `/usr/local` directory, in addition to all nested directories.

### Unbrewed files

Here are examples of common warnings about unbrewed files:

```shell
Warning: Unbrewed header files were found in /usr/local/include.
If you didn't put them there on purpose they could cause problems when
building Homebrew formulae, and may need to be deleted.
```

```shell
Warning: Unbrewed dylibs were found in /usr/local/lib
If you didn't put them there on purpose they could cause problems when
building Homebrew formulae, and may need to be deleted.
```

If you get a warning about any type of unbrewed file (such as `.pc` files, or static libraries), you may need to delete them as suggested by Homebrew (unless you put them there on purpose, which is unlikely). You'll have to delete each file it complains about one by one with the `rm` command. For example, to remove a file called `libgd.2.0.0.dylib` from `/usr/local/lib`, you would run this command:

```shell
rm /usr/local/lib/libgd.2.0.0.dylib
```

In some cases, it might list a bunch of files that are all in the same directory, as in this example where something went wrong when installing Node:

```shell
Unexpected header files:
  /usr/local/include/node/cppgc/allocation.h
  /usr/local/include/node/cppgc/common.h
  /usr/local/include/node/cppgc/custom-space.h
  /usr/local/include/node/cppgc/garbage-collected.h
  /usr/local/include/node/cppgc/heap.h
  ...
```

In this case, you can delete the entire directory that contains the unbrewed files:

```shell
rm -rf /usr/local/include/node
```

### Python warnings and config scripts

```shell
Warning: "config" scripts exist outside your system or Homebrew directories.
`./configure` scripts often look for *-config scripts to determine if
software packages are installed, and which additional flags to use when
compiling and linking.

Having additional scripts in your path can confuse software installed via
Homebrew if the config script overrides a system or Homebrew-provided
script of the same name. We found the following "config" scripts:
  /opt/anaconda3/bin/llvm-config
  /opt/anaconda3/bin/icu-config
  /opt/anaconda3/bin/krb5-config
  /opt/anaconda3/bin/freetype-config
  /opt/anaconda3/bin/xslt-config
  /opt/anaconda3/bin/libpng16-config
  /opt/anaconda3/bin/python3.7-config
  /opt/anaconda3/bin/libpng-config
  /opt/anaconda3/bin/xml2-config
  /opt/anaconda3/bin/python3.7m-config
  /opt/anaconda3/bin/python3-config
  /opt/anaconda3/bin/curl-config
  /opt/anaconda3/bin/ncursesw6-config
  /opt/anaconda3/bin/pcre-config
  /Library/Frameworks/Python.framework/Versions/3.7/bin/python3.7-config
  /Library/Frameworks/Python.framework/Versions/3.7/bin/python3.7m-config
  /Library/Frameworks/Python.framework/Versions/3.7/bin/python3-config
  /Library/Frameworks/Python.framework/Versions/3.8/bin/python3-config
  /Library/Frameworks/Python.framework/Versions/3.8/bin/python3.8-config
  /Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6m-config
  /Library/Frameworks/Python.framework/Versions/3.6/bin/python3-config
  /Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6-config
```

A related issue is:

```shell
Warning: Python is installed at /Library/Frameworks/Python.framework
```

These most likely mean you installed Python with a tool other than Homebrew. If you think you might need this version of Python, then just ignore those warnings. Otherwise, run the command below to remove that version of Python, but [read this thread first](https://github.com/Homebrew/homebrew/issues/27146).

```shell
sudo rm -rf /Library/Frameworks/Python.framework
```

In general, you want to install all development tools with Homebrew.

### Outdated or misconfigured Xcode

Unless you plan on building iOS or Mac applications, you don't need Xcode. All you need are the standalone Command Line Tools, which are installed when you follow this tutorial. If you already installed Xcode, you can safely delete it (again, assuming you haven't used it and don't plan to use it).

So, if you get any of the errors below, delete Xcode, then run `brew doctor`.

#### Outdated Xcode

```shell
Warning: Your Xcode (11.2.1) is outdated.
Please update to Xcode 12.3 (or delete it).
Xcode can be updated from the App Store.
```

#### Misconfigured Xcode

```shell
xcrun: error: active developer path 
("/Applications/Xcode.app/Contents/Developer") does not exist

Use `sudo xcode-select --switch path/to/Xcode.app` to specify the Xcode 
that you wish to use for command line developer tools, or use 
`xcode-select --install` to install the standalone command line developer tools.

See `man xcode-select` for more details.
```

### Linking keg-only formula

```shell
Warning: Some keg-only formula are linked into the Cellar.
Linking a keg-only formula, such as gettext, into the cellar with
`brew link <formula>` will cause other formulae to detect them during
the `./configure` step. This may cause problems when compiling those
other formulae.

Binaries provided by keg-only formulae may override system binaries
with other strange results.

You may wish to `brew unlink` these brews:

libxml2
```

Homebrew messages are generally very helpful and they let you know exactly what to do. In this case, it is telling you to fix the linking issue by running `brew unlink`, followed by the tools (or "brews") that need to be unlinked. Here, there is only one tool that needs to be unlinked. Therefore, you should run this command:

```shell
brew unlink libxml2
```

If it listed more than one tool, you would add them to the command separated by a space, like so:

```shell
brew unlink tool1 tool2 tool3
```

### Unlinked kegs

```shell
Warning: You have unlinked kegs in your Cellar.
Leaving kegs unlinked can lead to build-trouble and cause brews that 
depend on those kegs to fail to run properly once built. 
Run `brew link` on these:
  node
```

### Broken symlinks

Use `brew cleanup` to fix these types of warnings:

```shell
Warning: Broken symlinks were found. Remove them with `brew cleanup`:
  /usr/local/bin/apm
  /usr/local/bin/atom
  /usr/local/share/zsh/site-functions/_brew_cask
```

### Deprecated taps

```shell
Warning: You have the following deprecated, cask taps tapped:
  caskroom/cask
Untap them with `brew untap`.
```
In this case, you need to add the specific cask to the `brew untap` command, such as:

```shell
brew untap caskroom/cask
```

### Missing dependencies

The instructions here are straightforward:

```shell
Warning: Some installed formulae are missing dependencies.
You should `brew install` the missing dependencies:
  brew install libusbmuxd

Run `brew missing` for more details.
```

### Issues with the Git repo

Follow the instructions:

```shell
Warning: Some taps are not on the default git origin branch and may not receive
updates. If this is a surprise to you, check out the default branch with:
  git -C $(brew --repo homebrew/core) checkout master
```

### Prefix issues on Apple Silicon

```text
Warning: Your Homebrew's prefix is not /usr/local.
Some of Homebrew's bottles (binary packages) can only be used with the default
prefix (/usr/local).
You will encounter build failures with some formulae.
```
This is caused if you installed Homebrew while running your terminal in Rosetta mode, and are now running it in native mode, or if you used `arch -x86_64` while in native mode, or other types of mixing the two environments. 

Most things you need for Ruby web development are supported in native mode now, so there's no need to use Rosetta anymore. For more details and things to look out for, read my guide on [installing a development environment on Apple Silicon](https://www.moncefbelyamani.com/how-to-install-homebrew-and-ruby-on-a-mac-with-the-m1-apple-silicon-chip/).
