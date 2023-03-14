"""
	FeedbackItem

A single feedback item. Corresponds to a set of files that would get written
to the `/feedback/<number>/` directory on the A+ grader running tests on a
student submission.

"""
mutable struct FeedbackItem

	"""
		title

	A title or name of this feedback item. Gets wrapped in HTML tags <hn></hn>
	when being written to a file.

	"""
	title

	"""
		status

	One of `skipped`, `passed`, `failed`, `error`.
	"""
	status

	"""
		points

	Points given for this item. Cannot be larger than `max_points`.
	"""
	points

	"""
		max_points

	The maximum points one can get from the exercise that this `FeedbackItem`
	corresponds to.

	"""
	const max_points

	"""
		std_out

	Standard output from the tests related to this `FeedbackItem`.

	"""
	std_out

	"""
		std_err

	Standard error from the tests related to this `FeedbackItem`.

	"""
	std_err

end # FeedbackItem


