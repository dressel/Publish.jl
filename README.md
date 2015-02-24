# Publish

The idea behind this package is to make something that prints your code. I'm kinda sick of using VIM to print to ps and then converting via ps2pdf to a pdf. I will use Latex to make classy looking code and incorporate the output. The inspiration for this package comes from the TikzPictures package.

## Usage
```
publish("juliacodetopublish.jl")
```
Currently, this only outputs a sample pdf document. Note that you need latex installed on your machine.

## Near Term TODO list
* Check that the file to publish actually exists
* Actually copy the code into file
* Actually run the julia program and publish it and get the output somehow

[![Build Status](https://travis-ci.org/dressel/Publish.jl.svg?branch=master)](https://travis-ci.org/dressel/Publish.jl)
