# vdotenv
People configure their app variables via JSON, YAML, or even gitignored .v files. I personally found env files to work the best, especially with [docker-compose](https://docs.docker.com/compose/environment-variables/#the-env_file-configuration-option).

Further reading:
[12 factor apps](https://12factor.net/config)

## Features

- fully compatible with docker-compose .env
- useful helper function vdotenv.get()
- vdotenv.required() method to let people know what variables are needed
- automatically create missing .env file with blank required fields when working with vdotenv.required() for an easy setup

## Usage
Create a file called .env in the root folder of your application.
Add it to your .gitignore file. (best practice)
Fill it with key=value pairs.

```shell
POSTGRES_HOST=localhost
POSTGRES_USER=admin
POSTGRES_PASSWORD=postgres_password_goes_here
POSTGRES_DB=admin

JWT_SECRET=jwt_secret_goes_here
```

Then in your v source:
```v
module main

import treffner.vdotenv
import os

fn main() {
    // load .env environment file
    vdotenv.load()
    // optional check if required keys have values - error if something is missing
    // this also creates the .env file with the requested variables for an easy setup
    vdotenv.required('POSTGRES_HOST', 'POSTGRES_USER', 'POSTGRES_PASSWORD', 'POSTGRES_DB')
    // you can use build in os.getenv()
    println(os.getenv('POSTGRES_HOST'))
    // you can also use vdotenv.get() if you need fallback handling
    secret := vdotenv.get('JWT_SECRET') or {
        'default_dev_token' // default, not found, or simply the same on all environments
    }
    println(secret)
}
```

## Syntax rules
These syntax rules apply to the .env file:

- vdotenv expects each line in an env file to be in VAR=VAL format.
- Lines beginning with # are processed as comments and ignored.
- Blank lines are ignored.
- There is no special handling of quotation marks. This means that they are part of the VAL.
- Environment variables may not contain whitespace.

Note that there is also another dotenv module with more relaxed syntax rules (eg. inline comments) available 
https://vpm.vlang.io/mod/zztkm.vdotenv.  
We cannot relax these because we would lose docker .env compatibility.

## Installation

### Install and use vdotenv module as a dependency via v.mod (recommended)

Run "v init" to auto-generate your v.mod file.
```shell
v init
```
Then edit the dependencies in your v.mod file to look like this: 
```v
dependencies: ['treffner.vdotenv']
```
And install with:
```shell
v install
```
To update your dependencies later just run "v install" again.

### Or via VPM:
```shell
v install treffner.vdotenv
```
<!--
Or via [vpkg](https://github.com/vpkg-project/vpkg):

 ```shell
vpkg get https://github.com/treffner/vdotenv --global
``` -->

### Or through Git:
```shell
git clone https://github.com/treffner/vdotenv.git ~/.vmodules/treffner/vdotenv
```

## Test with docker-compose
Clone this repository and execute this commands while in the cloned folder.
```shell
docker-compose run --rm v
println(os.getenv('POSTGRES_HOST'))
```
This should print "localhost".

## Todo/ideas
- test installation via vpkg
- vdotenv.required_example() method to give people examples how the required variables should look like
- .env export compatibility (valid since docker 1.26)

# Module documentation

## Contents
- [fallback_get](#fallback_get)
- [get](#get)
- [load](#load)
- [must_get](#must_get)
- [required](#required)

## fallback_get
```v
fn fallback_get(key string, fallback string) string
```
 use fallback_get if you prefer traditional fallback handling 

[[Return to contents]](#Contents)

## get
```v
fn get(key string) ?string
```
 get is an alternative to os.getenv when you need fallback handling 

[[Return to contents]](#Contents)

## load
```v
fn load()
```
 load parses the .env environment file 

[[Return to contents]](#Contents)

## must_get
```v
fn must_get(key string) string
```
 must_get errors out if key does not exist 

[[Return to contents]](#Contents)

## required
```v
fn required(required_keys ...string)
```
 required checks if given keys have values - errors out if something is missing - also creates the .env file with the given variables for an easy setup 

[[Return to contents]](#Contents)

#### Powered by vdoc. Generated on: 17 Jun 2021 16:23:18

## License
[AGPL-3.0](LICENSE)
