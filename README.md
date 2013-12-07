Widget Management System (WMS)
========================

### Prerequisites and Dependencies

Paperclip gem is used. Thus imagemagick is required
For Mac user, use [homebrew](http://brew.sh/)
```
brew install imagemagick
```

## Installation
Clone the repo from Github
```
git clone git@github.com:phoorichet/wms.git
```

For the first time installation, run the following command in wms directory:
```
bundle install
rale db:crate:all
rake db:migrate
```

### MongoDB
#### Installation
Follow this instruction [MongoDB](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/)

#### Create index
```
rake db:mongoid:create_indexes
```

## Run the server
```
rails s
```


## Useful  Links
1. [Devise](https://github.com/plataformatec/devise)
2. [Paperclip](https://github.com/thoughtbot/paperclip)
3. [Homebrew](http://brew.io/)


