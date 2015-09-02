prove-bug:
	@echo " --> Cleaning previous build artifacts, if any"
	mix clean
	@echo " --> Compiling the project"
	mix compile
	@echo " --> That succeeded"
	@echo " --> Let's wait for a while"
	sleep 1
	@echo " --> Now let's just touch the proof of concept file"
	touch ./lib/bug_proof_of_concept.ex
	@echo " --> Let's compile again"
	mix compile
