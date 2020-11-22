module dotenv

import os
import io

pub fn load() {
	file := os.dir(os.executable()) + os.path_separator
	+ '.env'
	if !os.exists(file) {
		return
	}
	
	mut f := os.open_file(file, 'r', 0) or {
		return
	}
	defer {
		f.close()
	}
	mut reader := io.new_buffered_reader({
		reader: io.make_reader(f)
	})
	for {
		line := reader.read_line() or {
			break
		}
		parse_dot_env_line(line.trim_space())
	}
}

fn parse_dot_env_line(line string) {
	arr := line.split('=')
	if arr.len != 2 {
		return
	}
	os.setenv(arr[0].trim_space(), 
	arr[1].trim_space(), true)
}
