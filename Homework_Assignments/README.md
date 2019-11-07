# Homework Assignments of Course

## Assignment Sheet w/ Answers
### All the Answers are from me myself...
* Please don't hesitate to let me know if any of them *doesn't make sense* or simply seems to be *stupid*
    * Put it as **Issues** or 
    * contact me via **email** (shown in my [Homepage](https://github.com/cyscgzx33) )
* Discussion in any aspect is highly appreciated!

## Octave in Linux (Ubuntu 16.04)
### Useful Websites
* Installation of [Flatpak](https://flatpak.org/setup/Ubuntu/)
* How to run [Octave with GUI](https://fredfire1.wordpress.com/2015/03/07/install-and-start-octave-with-gui-in-ubuntu-ubuntu/)
### Useful commands
* Installation of specific pkg using `-forge`
    * e.g., `pkg install -forge geometry`
    * after installation, it is important to **`load`** such pkg before using it
* Run Octave within Flatpak framework
    * w/ GUI: `flatpak run --arch=x86_64 org.octave.Octave --gui`
    * w/o GUI: `flatpak run org.octave.Octave`
### Known Issues
* Every time entering Octave, need to `load` some necessary `pkg`s:
    * for example, `pkg load statistics`
    * I was trying to find an **auto load mechanics**, but I couldn't find one with *Flatpak*