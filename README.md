# V dotenv
People configure their app variables via JSON, YAML, or even gitignored .v files. I personally found env files to work the best, especially with [docker-compose](https://docs.docker.com/compose/environment-variables/#the-env_file-configuration-option).

Further reading:
[12 factor apps](https://12factor.net/config)

## Usage:
```shell
v install logTom.dotenv
```

Create a file called .env in the root folder of your application.
Add it to your .gitignore file.
Fill it with key=value pairs.
Example:
POSTGRES_HOST = localhost

Then in your v source:
```v
module main

import logtom.dotenv
import os

fn main(){
    dotenv.load()
    println(os.getenv('POSTGRES_HOST'))
}
```

## Syntax rules
These syntax rules apply to the .env file:

- Dotenv expects each line in an env file to be in VAR=VAL format.
- Lines beginning with # are processed as comments and ignored.
- Blank lines are ignored.
- There is no special handling of quotation marks. This means that they are part of the VAL.

## Todo
- create example .env file on module installation
- auto add .env to .gitignore
- required method to let people know what variables are needed

## License
[GPL-3.0](LICENSE)
