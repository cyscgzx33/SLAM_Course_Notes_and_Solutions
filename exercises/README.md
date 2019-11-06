# Exerices of Course

## Octave in Linux (Ubuntu16.04)
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