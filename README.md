# Publish

This package uses Latex to generate a PDF containing some file's code and output.
The result looks similar to that produced by MATLAB's `publish` function.
This is particularly useful if you have to submit code with problem sets.

## Basic Usage
```
using Publish
publish("code.jl")
```
Currently, this will generate a PDF called "code.pdf" that contains the code, any printed output, and any plots generated by the code.
The output and plots are generated by running the code itself.
Plotting is currently handled with PGFPlots.jl.

If you just want to print the code without running it, specify the optional `runcode` parameter:
```
publish("code.jl", runcode=false)
```

## Plotting
Plotting is currently handled with the Julia PGFPlots package.
Any time you use the `save` function with PGFPlots, that plot is saved to the PDF.


## Required Tex Packages
* `listings` to plot the code
* `caption` forgot why we need this
* `standalone` for plots
* `xcolor` for pgfplots, listings stuff
* `pgfplots` for plotting
* `geometry` to change margins

## Notes
If you publish a file in another folder, as in:
```
publish("folder/file.jl")
```
This will put the pdf and tex file in the directory named `folder`.

Any time you publish a file, a .pdf and a .tex file will be saved.

Any time your code saves a plot (using PGFPlots), a .tex file will be saved for it.

## TODO list
* Make some test julia files and stick them in the test folder
* Allow publishing of other languages (obviously, can't run that code)
* Include another publishing format that doesn't rely on Latex (md, html)
* improve listings language file (in julia_listings.tex)
* Robust to not having things like pgfplots. Just don't plot in that case
* Override display, so printing arrays can look pretty
* Make the Output style look better
* If a file includes another file, should that file be displayed too?


[![Build Status](https://travis-ci.org/dressel/Publish.jl.svg?branch=master)](https://travis-ci.org/dressel/Publish.jl)
