# V dotenv

https://docs.docker.com/compose/environment-variables/#the-env_file-configuration-option

https://docs.docker.com/compose/env-file/
[12 factor apps](https://12factor.net/config)

## Syntax rules

These syntax rules apply to the .env file:

- Dotenv expects each line in an env file to be in VAR=VAL format.
- Lines beginning with # are processed as comments and ignored.
- Blank lines are ignored.
- There is no special handling of quotation marks. This means that they are part of the VAL.


## Usage:
```shell
v install logtom.dotenv
```
Create a file called .env in the root folder of your application.
Fill it with key=value pairs.
Add it to your .gitignore file.

... then in your v source:
```v
module main

import logtom.dotenv

fn main(){
    dotenv.load()
    
}
```

## License
[GPL-3.0](LICENSE)
