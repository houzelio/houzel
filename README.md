# ![](https://user-images.githubusercontent.com/70602199/100478253-5bb3c580-30c9-11eb-9a82-d1d66620739b.png)

This is Houzel - a self hosted HIS system built with Rails and Backbone.js. The project aims to provide a simple and fast
platform to improve the patient care.

# Getting started

## Configure Basic Settings

Copy files
```bash
cp config/database.yml.example config/database.yml
cp config/houzel.yml.example config/houzel.yml
```

Review the files ```config/database.yml``` and ```config/houzel.yml``` in your favorite text editor.

## Install houzel via Docker
Although there is no official Houzel image, Docker is the preferred way to test and run Houzel in production.

If you want to deploy houzel using Docker, you could make a Houzel image from [here](https://github.com/houzelio/houzel-docker).

## Install houzel on your Own Machine

To begin, clone houzel to your local system
```bash
git clone git@github.com:houzel/houzel.git
cd houzel/
```

Install required Ruby libraries
```bash
bundle install
```

Install all JavaScript dependencies
```bash
yarn install
```

Set up the secret file
```bash
bundle exec rake houzel:secret
```

Set up the database
```bash
bundle exec rake db:create db:migrate
```

## Software stack

- Ruby (MRI) 2.5.8
- Git 2.8.4+
- Yarn 1.13.0+
- PostgreSQL 9.6+

## Get involved

- Contributing to the source code
- Help translate Houzel
- Report or fix bugs
- Request new features

# License

Houzel is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
