module vdotenv

import os

pub fn load() {
	file := os.dir(os.executable()) + os.path_separator + '.env'
	if !os.exists(file) {
		return
	}
	contents := os.read_file(file) or { return }
	lines := contents.split_into_lines()
	for line in lines {
		parse_line(line.trim_space())
	}
}

fn parse_line(line string) {
	arr := line.split('=')
	if arr.len != 2 {
		return
	}
	part := arr[0].trim_space()
	if part.len < 1 || part[0..1] == '#' {
		return
	}
	os.setenv(arr[0].trim_space(), arr[1].trim_space(), true)
}

pub fn get(key string) ?string {
	if os.getenv(key) == '' {
		return error('key is empty')
	}
	return os.getenv(key)
}

pub fn fallback_get(key string, fallback string) string {
	if os.getenv(key) != '' {
		return os.getenv(key)
	}
	return fallback
}

pub fn must_get(key string) string {
	if os.getenv(key) == '' {
		println('error: failed to get required environment variable $key')
		exit(1)
	}
	return os.getenv(key)
}

pub fn required(required_keys ...string) {
	mut missing_keys := []string{}
	mut content := ''
	for key in required_keys {
		if os.getenv(key) == '' {
			missing_keys << key
			content += key + '=\n'
		}
	}
	if missing_keys.len > 0 {
		mut multi := 'variables'
		if missing_keys.len == 1 {
			multi = 'variable'
		}
		println('error: failed to get required environment $multi: $missing_keys')
		file := os.dir(os.executable()) + os.path_separator + '.env'
		if !os.exists(file) {
			os.write_file(file, content) or {
				exit(1)
			}
			println('created .env file with blank required fields') // maybe add something like - please fill in your data
		}
		exit(1)
	}
}
