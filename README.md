# Advent of Code 2025

## Configuration

1. Copy the `config/example.exs` file to `config/config.exs`
2. Set the current Advent of Code calendar year.
3. Set the adventofcode.com session cookie value (see Authentication)

## Mix Tasks

### `mix test --only answer`

Run all real input based tests for part 1 and part 2.

### `mix gen.day [n]`

Generate a starting module and download your input for the day.

### `mix inputs.get`

Since inputs should not be shared in a public repository, this allows
downloading all missing inputs for existing solutions.

Keep in mind that all "answer" tests are based on my own inputs and will likely
fail for others. However, you can look at the "left" side of the failed
assertions to get answer for your own inputs.

## Authentication

Used to download your input.

1. Open a web browser
2. Go to https://adventofcode.com
3. Log in (if not already)
4. Open dev tools
5. Find and copy the session cookie value
6. Add the cookie value to the `:aoc` application config under the `:cookie` key.
