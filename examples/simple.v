import treffner.vdotenv
import os

fn main() {
	// load .env environment file
	vdotenv.load()
	// you can use build in os.getenv()
	println(os.getenv('POSTGRES_HOST'))
	// you can also use dotenv.get() if you need fallback handling
	secret := vdotenv.get('JWT_SECRET') or {
		'default_dev_token' // default, not found, or simply the same on all environments
	}
	println(secret)
}
