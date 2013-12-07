Widget Management System (WMS)
========================

### Prerequisites and Dependencies

Paperclip gem is used. Thus imagemagick is required
For Mac user, use [homebrew](http://brew.sh/)
```
brew install imagemagick
```

## Installation
For the first time installation, run the following command:
```
bundle install
rale db:crate:all
rake db:migrate
```


## Run the server
```
rails s
```

## Database

### MongoDB
# Create index
```
rake db:mongoid:create_indexes
```

#### Installation
Follow this instruction [MongoDB](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/)

## Useful  Links
1. [Devise](https://github.com/plataformatec/devise)
2. [Paperclip](https://github.com/thoughtbot/paperclip)
3. [Homebrew](http://brew.io/)


