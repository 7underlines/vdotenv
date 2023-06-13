import thomaspeissl.dotenv
import os

fn main() {
	// load .env environment file, error if the required vars are not found
	// also create a placeholder .env file if none found
	dotenv.require('POSTGRES_HOST', 'JWT_SECRET')
	// you can use build in os.getenv()
	println(os.getenv('POSTGRES_HOST'))
	// you can also use dotenv.get() if you need fallback handling
	secret := dotenv.get('JWT_SECRET') or {
		'default_dev_token' // default, not found, or simply the same on all environments
	}
	println(secret)
}
