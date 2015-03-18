# Publish

This package uses Latex to generate a PDF containing some file's code and output.
The result looks similar to that produced by MATLAB's `publish` function.
This is particularly useful if you have to submit code with problem sets.

## Usage
```
publish("code.jl")
```
Currently, this will generate a PDF called "code.pdf" that contains the code, any printed output, and any plots generated by the code.
The output and plots are generated by running the code itself.
Plotting is currently handled with PGFPlots.jl.

If you just want to print the code without running it, specify the optional `runcode` parameter:
```
publish("code.jl", runcode=false)
```

## Required Tex Packages
* `listings` to plot the code
* `caption` forgot why need this
* `standalone` for plots
* `xcolor` for pgfplots, listings stuff
* `pgfplots` for plotting
* `babel` to rectify quotes
* `geometry` to change margins

## TODO list
* Handle directory stuff (if user specifies "folder/test.jl")
* Check that the file to publish actually exists
* Make some test julia files and stick them in the test folder
* Allow publishing of other languages (obviously, can't run that code)
* Include another publishing format that doesn't rely on Latex (md, html)
* improve listings language file (in julia_listings.tex)
* Robust to not having things like pgfplots. Just don't plot in that case
* Override display, so printing arrays can look pretty
* Make the Plain style (output style) look better


[![Build Status](https://travis-ci.org/dressel/Publish.jl.svg?branch=master)](https://travis-ci.org/dressel/Publish.jl)
