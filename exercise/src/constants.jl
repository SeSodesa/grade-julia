### constants.jl
#
# Contains grading-related constants such as file paths, that any unit tests
# might take advantage of.
#

"""
	EXERCISE_FOLDER_ON_GRADER

The folder that stores the supporting files related to this exercise.
"""
const EXERCISE_FOLDER_ON_GRADER = joinpath("/", "exercise")

"""
	SUBMISSION_FOLDER_ON_GRADER

This is where the student submissions are stored on the grader.
"""
const SUBMISSION_FOLDER_ON_GRADER = joinpath("/", "submission", "user")

"""
	FEEDBACK_OUT_ON_GRADER

The file that student feedback should be written to. This should be in HTML
format.
"""
const FEEDBACK_OUT_ON_GRADER = joinpath("/", "feedback", "err")

"""
	FEEDBACK_ERR_ON_GRADER

The file that the testing errors should be written to.

"""
const FEEDBACK_ERR_ON_GRADER = joinpath("/", "feedback", "out")

"""
	FEEDBACK_POINTS_ON_GRADER

The file where the student points are written to. Valid format for the data is
`<points>/<max_points>` e.g. 5/10. You can use `points` to update this file.
Points are read by grade.

"""
const FEEDBACK_POINTS_ON_GRADER = joinpath("/", "feedback", "points")

"""
	FEEDBACK_GRADING_ERR_ON_GRADER

Errors that should be visible only to the staff. This file is added as a part
of grading_data with key errors and send to the grading service. Then, data
can be shown in the LMS to the course staff. Data is expected to be plain text
messages from run.sh and other tools. By default, /gw redirects stdout and
stderr from the run.sh to this file.

"""
const FEEDBACK_GRADING_ERR_ON_GRADER = joinpath("/", "feedback", "grading-script-errors")

"""
	FEEDBACK_SUBMISSION_SET_ERR_ON_GRADER

If this file contains `true`, then the submission is set in an error state in
the LMS. You can use set-error in your script to set this file.

"""
const FEEDBACK_SUBMISSION_SET_ERR_ON_GRADER = joinpath("/", "feedback", "submission-set-error")
