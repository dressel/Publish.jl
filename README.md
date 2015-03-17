# Publish

The idea behind this package is to make something that prints your code. I'm kinda sick of using VIM to print to ps and then converting via ps2pdf to a pdf. I will use Latex to make classy looking code and incorporate the output. The inspiration for this package comes from the TikzPictures package.

## Usage
```
publish("juliacodetopublish.jl")
```
Currently, this will print the code, run it, print any output, and add any plots.
Plots are currently handled by a wrapper of PGFPlots.
The idea is to make plotting more like MATLAB.

## Required Tex Packages
* `listings` to plot the code
* `caption` forgot why need this
* `standalone` for plots
* `xcolor` for pgfplots, listings stuff
* `pgfplots` for plotting
* `babel` to rectify quotes
* `geometry` to change margins

## TODO list
* Check that the file to publish actually exists
* Make some test julia files and stick them in the test folder
* Give user option not to run code; just publish the code itself
* Allow publishing of other languages (obviously, can't run that code)
* Maybe not rely solely on LaTeX... do something like html or md?
* improve listings language file (in julia_listings.tex)
* delete tex files created by plotting
* Maybe not even use separate tex files when plotting
* add a lot more functionality to plotting
* Override save or Axis function in PGFPlots?
* Robust to not having things like pgfplots. Just don't plot in that case
* Make the output look prettier (headers, footers, spacing)
* Maybe override display? Display is nicer for things like Arrays
* Make the Plain style ready (maybe call it output?)
* Remove temp_publish_1.tex files created for plotting
* save function that takes no name, like save(plot)


[![Build Status](https://travis-ci.org/dressel/Publish.jl.svg?branch=master)](https://travis-ci.org/dressel/Publish.jl)
