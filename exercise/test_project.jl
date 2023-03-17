### test_project.jl
#
# Runs the test suite of this project using Julia's package manager Pkg. A
# teacher is to write a file runtests.jl, which will get copied to
#
#     test/runtests.jl
#
# which computes the actual points of the student submission. If other tests
# files are needed, prefix them with "test_" to also have them copied into the
# test folder. The file runtests.jl should also include those files.
#

import Pkg

## Relevant constants.

const EXERCISE_FOLDER_ON_GRADER = joinpath("/", "exercise")

const TEST_FOLDER = joinpath(@__DIR__, "test")

const SOURCE_FOLDER = joinpath(@__DIR__, "src")

const TEST_PREFIX = "test_"

const JULIA_POSTFIX = ".jl"

const RUNTESTS_FILE = "runtests.jl"

const STUDENT_SUBMISSION_DIR = joinpath("/", "submission", "user")

# Copy exercise files to their designated locations. Julia files are either
# test files or source files, and placed into test/ or src/ respectively.

exercise_directory_contents = readdir(EXERCISE_FOLDER_ON_GRADER)

for name ∈ exercise_directory_contents

	full_path = joinpath(EXERCISE_FOLDER_ON_GRADER, name)

	is_test_file = (
		isfile(full_path)
		&&
		endswith(name, JULIA_POSTFIX)
		&&
		( startswith(name, TEST_PREFIX) || ( name == RUNTESTS_FILE ) )
	)

	is_src_file = (
		isfile(full_path)
		&&
		! ( name == RUNTESTS_FILE )
		&&
		! startswith(name, TEST_PREFIX)
		&&
		endswith(name, JULIA_POSTFIX)
	)

	if is_test_file

		new_path = joinpath(TEST_FOLDER, name)

		cp(full_path, new_path)

	elseif is_src_file

		new_path = joinpath(SOURCE_FOLDER, name)

		cp(full_path, new_path, force=true)

	else

		# Pass

	end

end

# Copy the student submission into src/.

for name ∈ readdir(STUDENT_SUBMISSION_DIR)

	submission_path = joinpath(STUDENT_SUBMISSION_DIR, name)

	new_path = joinpath(SOURCE_FOLDER, name)

	cp(submission_path, new_path, force=true)

end

# If and when files are in place, run tests.

if ! isfile( joinpath(TEST_FOLDER, RUNTESTS_FILE) )

	message = (
		"The runtests.jl file needed to run the tests was not found."
		+
		" Please inform the course staff about this."
	)

	err = ErrorException(message)

	throw( err )

end

Pkg.activate(@__DIR__)

Pkg.test()
