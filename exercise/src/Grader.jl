"""
	Grader

A state machine that keeps track of accumulated points and knows how to write
itself to a set of feedback files.

"""
mutable struct Grader

	"""
		points

	The points that the student has accumulated thus far. This is incremented
	with the add_point function.

	"""
	points :: Int

	"""
		max_points

	This sets the maximum points for the exercise.
	"""
	const max_points :: Int

	"""
		out

	A HTML string specifying student-facing output.

	"""
	out :: String

	"""
		err

	A HTML string specifying student-facing error output.

	"""
	err :: String

	"""
		grading_errs

	A list of plain text error messages from the grading script.

	"""
	grader_errors :: Vector{String}

	"""
		working_dir

	The directory that this Grader is working in. Determines where feedback
	files get written to.

	"""
	const feedback_dir :: String

	"""
		feedback_items

	A list of FeedbackItems. If this is not empty, the grader will report an
	erraneous submission via the file submission-set-error.

	"""
	feedback_items :: Vector{FeedbackItem}

	"""
		Grader

	Inner constructor for this type. Always sets the initial `points` to 0 and
	`max_points` to the given `max_points`. Feedback strings and separate
	feedback items will be empty.

	"""
	function Grader(max_points::Int)

		feedback_dir = joinpath(PROJECT_FOLDER, "feedback")

		new(0, max_points, "", "", [], feedback_dir, [])

	end

end # Grader

"""
	add_point

Increments the `points` field of a given grader,
"""
function add_point(grader::Grader)

	if 0 ≤ grader.points < grader.max_points

		grader.points += 1

	end

end # function

"""
	add_points

To add multiple points at once, call this function.

"""
function add_points(grader::Grader, points::Int)

	if 0 ≤ grader.points + points < grader.max_points

		grader.points += points

	end

end # function

"""
	set_feedback_out

Sets the student-facing feedback string of the given grader.

"""
function set_feedback_out(grader::Grader, out)

	grader.out = out

end # function

"""
	add_hn

Surrounds a given string with HTML tags `h{1..6}` and appends it to
Grader.out.

"""
function add_hn(grader::Grader, title::T, level::Int; classes::Array{S}=String[]) where {
	T <: AbstractString,
	S <: AbstractString,
}

	grader.out = html_hn(grader.out, title, level, classes=classes)

end

"""
	add_positive_p

Surrounds the given paragraph in HTML `p` tags and appends it to Grader.out.
Allows giving positively tinted feedback in a grading script.

"""
function add_positive_p(grader::Grader, paragraph::T) where T <: AbstractString

	grader.out = html_p(grader.out, "✓ " * paragraph, classes = ["alert", "alert-success"])

end

"""
	add_negative_p

Surrounds the given paragraph in HTML `p` tags and appends it to Grader.out.
Allows giving negatively tinted feedback in a grading script.

"""
function add_negative_p(grader::Grader, paragraph::T) where T <: AbstractString

	grader.out = html_p(grader.out, "⚠ " * paragraph, classes = ["alert", "alert-danger"])

end

"""
	set_feedback_err

Sets the student-facing feedback error string of the given grader.

"""
function set_feedback_err(grader::Grader, err)

	grader.err = err

end # function

"""
	add_feedback_item

Adds a feedback item to the set of feedback items of the given grader.

"""
function add_feedback_item(grader::Grader, item::FeedbackItem)

	push!(grader.feedback_items, item)

end

"""
	add_grader_error

Add an error message to the set of grader errors.

"""
function add_grader_error(grader::Grader, message::String)

	push!(grader.grading_errors, message)

end

"""
	write_feedback

Writes a Grader object into a set of A+ feedback files. These can then be
copied or moved to the `/feedback` folder by a process that has the required
privileges.

"""
function write_feedback(grader::Grader)

	target_dir = joinpath(PROJECT_FOLDER, "feedback")

	# Make sure that the feedback target folder exists.

	if ! isdir(target_dir)

		mkdir(target_dir)

	end

	# Once the directory exists, write each feedback field to their designated
	# files.

	write_points(grader)

	write_feedback_out(grader)

	write_feedback_err(grader)

	write_grading_err(grader)

	set_submission_error(grader)

end # function

"""
	write_points

Writes the point ratio to the grader feedback points file.

"""
function write_points(grader::Grader)

	file = joinpath(grader.feedback_dir, "points")

	open(file, "w") do io

		write(io, "$(grader.points)/$(grader.max_points)")

	end

end # function

"""
	write_feedback_out

Writes given textual student feedback into its designated file. The
feedback needs to be valid HTML.

"""
function write_feedback_out(grader::Grader)

	file = joinpath(grader.feedback_dir, "out")

	open(file, "w") do io

		write(io, grader.out)

	end

end # function

"""
	write_feedback_err

Writes given textual student feedback into its designated file. The
feedback needs to be valid HTML.

"""
function write_feedback_err(grader::Grader)

	file = joinpath(grader.feedback_dir, "err")

	open(file, "w") do io

		write(io, grader.err)

	end

end # function

"""
	write_grading_err

Writes grading error messages to their designated file.

"""
function write_grading_err(grader::Grader)

	file = joinpath(grader.feedback_dir, "grading-script-errors")

	open(file, "w") do io

		for error_msg ∈ grader.grader_errors

			write(io, "\n\n" * error_msg)

		end

	end # do

end # function

"""
	set_submission_error

Writes the word `true` into a designated file, which tells the LMS that
the submission ended up in an erraneous state.

"""
function set_submission_error(grader::Grader)

	if isempty(grader.grader_errors)

		return

	end

	file = joinpath(grader.feedback_dir, "submission-set-error")

	open(file, "w") do io

		write(io, "true")

	end

end # function
