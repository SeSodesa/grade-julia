"""
	exercise

This module functions as a wrapper project for the user submission. Contains
some useful constants and helper functions that the unit test framework can
invoke.

"""
module exercise

	## Export list.
	#
	# These functions become available after a "using exericse" at the start
	# of the grading script file.
	#

	export Grader
	export FeedbackItem
	export write_feedback
	export write_points
	export write_feedback_out
	export write_feedback_err
	export write_grading_err
	export set_submission_error
	export add_point
	export add_points
	export set_feedback_out
	export set_feedback_err
	export add_feedback_item
	export html_hn
	export html_p
	export html_i
	export html_b
	export html_pre
	export html_code
	export html_classes
	export add_positive_p
	export add_negative_p

	## Include module code from this directory.

	include("constants.jl")

	include("FeedbackItem.jl")

	include("Grader.jl")

	include("submission.jl")

	include("model_solution.jl")

	## Helper functions for grading.

	"""
		html_hn

	Appends a `hn`-tagged string to a given HTML string, where `hn` ∈ h{ 1, …,
	6 }. Throws an `AssertionError`, if the given title level is outside of
	this range.

	"""
	function html_hn(html::T1, str::T2, level::Int; classes::Array{T3}=String[]) where {
		T1 <: AbstractString,
		T2 <: AbstractString,
		T3 <: AbstractString,
	}

		@assert ( 1 ≤ level ≤ 6 ) "HTML title levels are in [1,6]"

		cc = html_classes(classes)

		html *= "<h$level$cc>$str</h$level>"

	end # function

	"""
		html_p

	Appends a `p`-tagged string to a given HTML string.

	"""
	function html_p(html::T1, str::T2; classes::Array{T3}=String[]) where {
		T1 <: AbstractString,
		T2 <: AbstractString,
		T3 <: AbstractString,
	}

		cc = html_classes(classes)

		html *= "<p$cc>$str</p>"

	end # function

	"""
		html_pre

	Appends a `pre`-tagged string to a given HTML string.

	"""
	function html_pre(html::T1, str::T2; classes::Array{T3}=String[]) where {
		T1 <: AbstractString,
		T2 <: AbstractString,
		T3 <: AbstractString,
	}

		cc = html_classes(classes)

		html *= "<pre$cc>$str</pre>"

	end # function

	"""
		html_code

	Appends a `pre`-tagged string to a given HTML string.

	"""
	function html_code(html::T1, str::T2; classes::Array{T3}=String[]) where {
		T1 <: AbstractString,
		T2 <: AbstractString,
		T3 <: AbstractString,
	}

		html *= "<code>$str</code>"

	end # function

	"""
		html_b

	Appends a `b`-tagged string to a given HTML string.

	"""
	function html_b(html::T1, str::T2; classes::Array{T3}=String[]) where {
		T1 <: AbstractString,
		T2 <: AbstractString,
		T3 <: AbstractString,
	}

		html *= "<b>$str</b>"

	end # function

	"""
		html_i

	Appends a `i`-tagged string to a given HTML string.

	"""
	function html_i(html::T1, str::T2; classes::Array{T3}=String[]) where {
		T1 <: AbstractString,
		T2 <: AbstractString,
		T3 <: AbstractString,
	}

		html *= "<b>$str</b>"

	end # function

	"""
		html_kbd

	Appends a `i`-tagged string to a given HTML string.

	"""
	function html_kbd(html::T1, str::T2; classes::Array{T3}=String[]) where {
		T1 <: AbstractString,
		T2 <: AbstractString,
		T3 <: AbstractString,
	}

		html *= "<kbd>$str</kbd>"

	end # function

	"""
		html_classes

	Constructs a class string from a given array of class names. This can be
	called by the other HTML tag functions to add classes to their start tag.

	"""
	function html_classes(classes::VecOrMat{T}) where T <: AbstractString

		if isempty(classes)

			""

		else

			" class = \"" * join(classes, " ") * "\""

		end

	end # function

end # module exercise
