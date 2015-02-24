module Publish

export publish, publish_tex

function publish_tex(filename::String)
	#filename = f.filename
	tex = open("$(filename).tex", "w")
	println(tex, "\\documentclass{article}")
	println(tex, "\\usepackage{caption}")
	#println(tex, "\\usepackage{tikz}")
	#println(tex, td.pictures[1].preamble)
	println(tex, "\\begin{document}")
	println(tex, "Sample Document")
	println(tex, "\\end{document}")
	close(tex)
end

function publish(filename::String)

	# Generate the .tex file and make pass along any possible errors
	IX = rsearch(filename,'/')              # Find the last slash
	foldername = filename[1:IX-1]           # Everything before that is the folder name
	foldername = (IX == 0 ? "." : foldername) # If there was no slash, folder is "."
	#save(TEX(f.filename * ".tex"), tp)        # Save the tex file in the directory that was given
	publish_tex(filename)
                                            #   This will throw an error if the directory doesn't exist

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
		rm("$(filename).tex")
		rm("$(filename).aux")
		rm("$(filename).log")
	catch
		println("WARNING! Your intermediate files are not being deleted.")
	end
end

end # module
