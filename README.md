# JudgeMe - Like it or not

A simple approval application that pokes fun at the importance
given to voting... or does it? Like or dislike as you will.

## Overview

People or organizations can setup an _Account_ in JudgeMe to list their
items, or _Artifacts_, for other people to like or dislike. JudgeMe
provides two modalities for users to express their approval: web and sms.

### Web Interface

The web interface provides a simple display for users to click a thumbs-up
or thumbs-down icon for a particular artifact. The images are then replaced
by the number of users selecting each (e.g., 504 Likes, 372 Dislikes).
There are two distinct use cases:

- POS-like device, where the artifact's page is pre-loaded on the screen
- mobile browser, where a visitor snaps a QR code linking direct to artifact's page

### SMS Interface

The SMS interface takes form as an HTTP callback that you can register
with an SMS provider. For example, using TextMarks as your provider with
keyword 'JUDGEME', a user could text 41411 with 'JUDGEME Art001 Like'
(case-insensitive) for artifact 'Art001'. 'Dislike' is also supported.
The user then receives back a message containing the total number of likes
and dislikes, respectively.

## Install

JudgeMe was developed using ruby 1.9.2-p290. You are using RVM, aren't you?
Just run this command to install the right ruby.

    rvm install 1.9.2-p290

Now create a gemset for the application

    rvm use --create 1.9.2-p290@judgeme

JudgeMe manages its dependencies using Bundler (gasp!). If you don't yet have
Bundler installed, install it now.

    gem install bundler

Now install the JudgeMe dependencies with

    bundle install
    
Now migrate the database with

    rake db:migrate

## Configuration

### Setup SMS

JudgeMe was developed using TextMarks for SMS-enabling the application. Any provider
that can make a custom HTTP callback upon receiving a message should do though.
The provider should be able to make a GET request containing the the phone number,
message, and unique device identifier in the URL path for each subscriber message.
Just register your keyword (e.g., JUDGEME) and use the provider's HTTP callback
mechanism/API to configure the service. The full setup of an SMS provider is
outside the scope of this document.

JudgeMe provides a semi-RESTful* callback endpoint

    GET /users/[PHONE_NUMBER]/votes/[MESSAGE]?serial=[UNIQ_DEVICE_ID]

This is configured in TextMarks API Settings with a callback URL such as

    http://judgeme.herokuapp.com/users/\p/votes/\0?serial=\u

Note, you need to use your own domain, unless you want to send users to our server. :)

*semi--because a GET request _should_ be safe, i.e., not change state on the server.

### Setup Accounts and Artifacts

To quickly get some data in the database, we've provided a rake task
that'll add some auto-generated seed data for you.

    rake db:seed

Regular management is currently done through the console.

    rake console

To create new user:

    User.create(:name => "John Smith", :username => "johnny", :email => "john@smith.com", :phone => "5551234567")

TODO: document the Account and Artifacts objects.

## Usage

Being a Sinatra app, any Rack-capable web server can run JudgeMe.

### Development

To run it locally, we've provided a nice little Rake task that
invokes Unicorn using `config/unicorn.conf`.

    rake server

Then open your web browser to [http://localhost:2007](). You can change
the goofy port in `unicorn.conf`

You'll find three files in the `log` directory.

- `log/sinatra.log` for application output
- `log/unicorn-stdout.log` for unicorn's stdout (like apache's access_log)
- `log/unicorn-stderr.log` for unicorn's sterr (like apache's error_log)

### Production

The quickest way to see a live site is using Heroku. Install the Heroku gem.

    gem install heroku

Create a new site on Heroku with

    heroku create --stack cedar

Now push your code out.

    git push heroku master

And open it in your browser.

    heroku open

Well, you shouldn't really see anything because you haven't setup any
artifacts or users yet. But I trust you'll figure it out. :)

## Colophon

JudgeMe is written in Ruby for the Sinatra framework using a nice mix of technologies,
including DataMapper, Haml, Sass, CoffeeScript and jQuery, SQLite3 and PostgreSQL,
Unicorn and Thin. When we finally start writing tests, we'll be using Riot and RR.