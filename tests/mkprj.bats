#!/usr/bin/env bats

setup() {
	export PROJECTS_DIR=
	export TEMPLATES_DIR=

	TMP_DIR="$( mktemp -dt mkprj )"

	mkdir -p "$TMP_DIR/projects/"
	mkdir -p "$TMP_DIR/otherdir/"
	mkdir -p "$TMP_DIR/templates/blank"

	touch "$TMP_DIR/templates/blank/hello.txt"
}

teardown() {
	[ -d "$TMP_DIR" ] && rm -rf "$TMP_DIR"
}

@test "shows version" {
	local version="$( grep VERSION ./mkprj | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' )"

	run ./mkprj -v

	[ "$status" -eq 0 ]
	[ "$output" = "mkprj $version" ]
}

@test "shows help" {
	run ./mkprj -h

	[ "$status" -eq 0 ]
	[ "${output:0:6}" = "mkprj " ]
}

@test "generates project directory based on today's date in current directory" {
	local date="$( date +%Y%m%d )"

	export SCRIPT_PATH="$(pwd)"

	cd "$TMP_DIR"

	run "$SCRIPT_PATH/mkprj" test

	[ "$status" -eq 0 ]
	[ "$output" = "$TMP_DIR/$date test" ]
	[ -d "$TMP_DIR/$date test" ]

	cd - >/dev/null
}

@test "generates project directory based on a specified date in projects directory specified in arguments" {
	local date="2020-12-31"

	run ./mkprj -d "$date" -p "$TMP_DIR/projects" test

	[ "$status" -eq 0 ]
	[ "$output" = "$TMP_DIR/projects/20201231 test" ]
	[ -d "$TMP_DIR/projects/20201231 test" ]
}

@test "generates project directory based on a specified date in projects directory specified in environment" {
	local date="2020-12-31"

	export PROJECTS_DIR="$TMP_DIR/projects"
	run ./mkprj -d "$date" test

	[ "$status" -eq 0 ]
	[ "$output" = "$TMP_DIR/projects/20201231 test" ]
	[ -d "$TMP_DIR/projects/20201231 test" ]
}

@test "generates project directory using a template specified by full path" {
	local date="2020-12-31"

	run ./mkprj -d "$date" -p "$TMP_DIR/projects" -t "$TMP_DIR/templates/blank" test

	[ "$status" -eq 0 ]
	[ "$output" = "$TMP_DIR/projects/20201231 test" ]
	[ -d "$TMP_DIR/projects/20201231 test" ]
	[ -f "$TMP_DIR/projects/20201231 test/hello.txt" ]
}

@test "generates project directory using a template specified by name" {
	local date="2020-12-31"

	export TEMPLATES_DIR="$TMP_DIR/templates"
	run ./mkprj -d "$date" -p "$TMP_DIR/projects" -t blank test

	[ "$status" -eq 0 ]
	[ "$output" = "$TMP_DIR/projects/20201231 test" ]
	[ -d "$TMP_DIR/projects/20201231 test" ]
	[ -f "$TMP_DIR/projects/20201231 test/hello.txt" ]
}
