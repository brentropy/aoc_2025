# Aoc

## Configuration

1. Copy the `config/example.exs` file to `config/config.exs`
2. Set the current Advent of Code calendar year.
3. Set the adventofcode.com session cookie value (see Authentication)

## Mix Tasks

### `mix gen.day [n]`

Generate a starting module and download your input for the day.

## Authentication

Used to download your input.

1. Open a web browser
2. Go to https://adventofcode.com
3. Log in (if not already)
4. Open dev tools
5. Find and copy the session cookie value
6. Add the cookie value to the `:aoc` application config under the `:cookie` key.
