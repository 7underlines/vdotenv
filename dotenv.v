module dotenv

import os
// import io

pub fn load() {
	file := os.dir(os.executable()) + os.path_separator + '.env'
	if !os.exists(file) {
		return
	}
	contents := os.read_file(file) or {
		return
	}
	lines := contents.split_into_lines()
	for line in lines {
		parse_line(line.trim_space())
	}
	// mut f := os.open_file(file, 'r', 0) or {
	// 	return
	// }
	// defer {
	// 	f.close()
	// }
	// mut reader := io.new_buffered_reader({
	// 	reader: io.make_reader(f)
	// })
	// for {
	// 	line := reader.read_line() or {
	// 		break
	// 	}
	// 	parse_line(line.trim_space())
	// }
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
		//panic('failed to get variable $key')
		println('error: failed to get required environment variable $key')
		exit(1)
	}
	return os.getenv(key)
}
