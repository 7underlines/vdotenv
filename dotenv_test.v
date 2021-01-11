module dotenv

import os

// fn test_load() {
// 	load()
// 	host := os.getenv('POSTGRES_HOST')
// 	assert host == 'localhost'
// }
fn test_parse() {
	text := 'POSTGRES_HOST=localhost_parse'
	parse_line(text)
	host := os.getenv('POSTGRES_HOST')
	assert host == 'localhost_parse'
}
