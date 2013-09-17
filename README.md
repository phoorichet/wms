Widget Management System (WMS)
========================

## Prerequisites and Dependencies
Paperclip gem is used. Thus imagemagick is required
```
brew install imagemagick
```

## Installation
For the first time installation, run the following command:
```
bundle install
rake db:migrate
```

## TODO
1. Add Devise authentication gem -> Done!
2. Add Paperclip and link it to User model -> Done!
3. Create a parser on raw data which is uploaded through Paperclip

## Note

## Useful  Links
1. [Devise](https://github.com/plataformatec/devise)
2. [Paperclip](https://github.com/thoughtbot/paperclip)
