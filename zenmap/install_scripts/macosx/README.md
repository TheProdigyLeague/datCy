# This is a description of all files in this directory. 
> All of which have to do with packaging on Mac OS X. 
Note: They are useful only for those wanting to build binary distributions of Zenmap for Mac OS X.
== Info.plist
> A properties list file template that is filled out by make-bundle.sh
`
== make-bundle.sh
> This script builds a .app bundle. It must be run from the root of the
Zenmap source tree. The finished bundle is put in dist/Zenmap.app.
`
== zenmap.icns
> The icon file for the bundle. It was created using the Icon Composer
utility (open -a "Icon Composer").
`
== zenmap_auth.c
> This is a simple wrapper program that attempts to run launcher.sh
with privileges.
`
== launcher.sh
> A launcher script that configures the environment for Zenmap, Python, and GTK
before launching the main Zenmap script file.
`
== zenmap.bundle
> An XML config file for gtk-mac-bundler which specifies files and metadata for
the application bundle. https://wiki.gnome.org/Projects/GTK%2B/OSX/Building
`
