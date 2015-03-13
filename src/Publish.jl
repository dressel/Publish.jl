module Publish

export publish, publish_tex, setup, showit
export plot

import PGFPlots: Plots, Axis, save

export Plots, save

# 
_output_buffer = nothing
_num_plots = 0


# Creates the tex file
function publish_tex(filename::String)
	global _output_buffer = IOBuffer()

	#filename = f.filename
	tex = open("$(filename).tex", "w")
	println(tex, "\\documentclass{article}")
	println(tex, "\\usepackage{caption}")

	# Quote stuff: Cool, doesn't work in the lstlisting stuff though :(
	println(tex, "\\usepackage[english]{babel}")
	println(tex, "\\usepackage[autostyle, english = american]{csquotes}")
	println(tex, "\\MakeOuterQuote{\"}")

	# standalone stuff
	println(tex, "\\usepackage{standalone}")
	println(tex, "\\usepackage[usenames,dvipsnames]{xcolor}")
	println(tex, "\\usepackage{pgfplots}")
	println(tex, "\\pgfplotsset{compat=newest}")

	# listings stuff
	lst = readall(joinpath(Pkg.dir("Publish"), "src", "julia_listings.tex"))
	println(tex, lst)
	println(tex, "\\begin{document}")
	println(tex, "\\begin{lstlisting}[numbers=left]")

	# Open the source file and print it out
	source_file = open(filename, "r")
	while (currentline = readline(source_file)) != ""
		print(tex, currentline)
	end
	close(source_file)
	println(tex, "\\end{lstlisting}")

	# Run the test file
	include(filename)

	# We should now have a string of output
	output_string = takebuf_string(_output_buffer)
	if length(output_string) > 0
		println(tex, "Console Output\n")
		println(tex, output_string)
	end

	# We also have a bunch of tex plots
	global _num_plots
	for i = 1:_num_plots
		println(tex, "\\begin{figure}[!ht]")
		println(tex, "\\centering")
		println(tex, "\\input{temp_publish_$i.tex}")
		println(tex, "\\end{figure}")
	end
	_num_plots = 0

	# End the document and close
	println(tex, "\\end{document}")
	close(tex)
end


# Does the same thing as normal println function, 
#  but also prints to a buffer if it exists.
function Base.println(xs...)
	global _output_buffer
	if _output_buffer != nothing
		println(_output_buffer, xs...)
		println(_output_buffer, "")
	end
	println(STDOUT, xs...)
end

# Does the same thing as normal print function, 
#  but also prints to a buffer if it exists.
function Base.print(xs...)
	global _output_buffer
	if _output_buffer != nothing
		print(_output_buffer, xs...)
	end
	print(STDOUT, xs...)
end


function publish(filename::String)

	# TODO: check that the file exists
	# TODO: check that the file is of the correct type (.jl)

	# Generate the .tex file and make pass along any possible errors
	IX = rsearch(filename,'/')              # Find the last slash
	foldername = filename[1:IX-1]           # Everything before that is the folder name
	foldername = (IX == 0 ? "." : foldername) # If there was no slash, folder is "."
	#save(TEX(f.filename * ".tex"), tp)        # Save the tex file in the directory that was given

	# This also sets the global _output_buffer to a value (as in, not nothing)
	# When it is done, set the global _output_buffer back to nothing
	publish_tex(filename)
	global _output_buffer = nothing

	# We should add more to file

	# From the .tex file, generate a pdf within the specified folder
	latexCommand = ``
	# TODO: I'm not sure what enableWrite18 does. I asssume it is some latex feature
	#  I should talk to Dr. Kochenderfer about it. For now, I leave it out
	#if tp.enableWrite18
	#	latexCommand = `lualatex --enable-write18 --output-directory=$(foldername) $(f.filename)`
	#else
	#	latexCommand = `lualatex --output-directory=$(foldername) $(f.filename)`
	#end
	latexCommand = `lualatex --output-directory=$(foldername) $(filename)`
	isPdfThere = success(latexCommand)

	if !isPdfThere
		line1 = "ERROR: The pdf generation failed.\n"
		line2 = "   Be sure your latex libraries are fully up to date!\n"
		line3 = "   You tried: $(latexCommand)"
		error(line1 * line2 * line3)  # Throw an error
	end

	try
		# Shouldn't need to be try-catched anymore, but best to be safe
		# This failing is NOT critical either, so just make it a warning
		# Before, it checked for tikzDeleteIntermediate
		#if tikzDeleteIntermediate()
		#rm("$(filename).tex")
		rm("$(filename).aux")
		rm("$(filename).log")
	catch
		println("WARNING! Your intermediate files are not being deleted.")
	end
end

function plot(x, y; ymode=nothing, xmode=nothing)
	p = Plots.Linear(x,y)
	a = Axis(p, ymode=ymode, xmode=xmode)

	global _output_buffer
	global _num_plots
	if _output_buffer != nothing
		# This is being run to publish the file
		_num_plots += 1
		save("temp_publish_$(_num_plots).tex", a)
	else
		# Just plot it for our sake
		save("temp_publish_$(_num_plots).pdf", a)
	end
end

end # module