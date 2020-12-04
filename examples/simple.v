import dotenv
import os

fn main() {
	// load .env environment file
	dotenv.load()
	// you can use build in os.getenv()
    println(os.getenv('POSTGRES_HOST'))
    // you can also use dotenv.get() if you need fallback handling
	secret := dotenv.get('JWT_SECRET') or {
		'default_dev_token'
	}
	println(secret)
}
