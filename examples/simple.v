import dotenv
import os

fn main() {
	dotenv.load()
	println(os.getenv('POSTGRES_HOST'))
	println(os.getenv('JWT_SECRET'))
}
