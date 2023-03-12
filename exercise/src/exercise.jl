"""
	exercise

This module functions as a wrapper project for the user submission. Contains
some useful constants and helper functions that the unit test framework can
invoke.

"""
module exercise

	export write_points
	export write_feedback_out
	export write_feedback_err
	export write_grading_err
	export set_submission_error

	## Include file names and other useful constants.

	include("constants.jl")

	include("submission.jl")

	## Helper functions for grading

	"""
		write_points

	Writes the point ratio to the grader feedback points file.
	"""
	function write_points(points :: Int, max_points :: Int)

		open(FEEDBACK_POINTS_ON_GRADER, "w") do io

			write(io, "$points/$max_points")

		end

	end # function

	"""
		write_feedback_out

	Writes given textual student feedback into its designated file. The
	feedback needs to be valid HTML.

	"""
	function write_feedback_out(feedback :: T) where { T <: AbstractString }

		open(FEEDBACK_OUT_ON_GRADER, "w") do io

			write(io, feedback)

		end

	end # function

	"""
		write_feedback_out

	Writes given textual student feedback into its designated file. The
	feedback needs to be valid HTML.

	"""
	function write_feedback_err(error_msg :: T) where { T <: AbstractString }

		open(FEEDBACK_ERR_ON_GRADER, "w") do io

			write(io, error_msg)

		end

	end # function

	"""
		write_grading_err

	Writes grading error messages to their designated file.

	"""
	function write_grading_err(error_msg :: T) where { T <: AbstractString }

		open(FEEDBACK_GRADING_ERR_ON_GRADER, "w") do io

			write(io, error_msg)

		end

	end # function

	"""
		set_submission_error

	Writes the word `true` into a designated file, which tells the LMS that
	the submission ended up in an erraneous state.

	"""
	function set_submission_error()

		open(FEEDBACK_SUBMISSION_SET_ERR_ON_GRADER, "w") do io

			write(io, "true")

		end

	end # function

end # module exercise
