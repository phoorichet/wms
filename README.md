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
rake db:migrate
```

Nodejs has been used for ruby gem libs. It is required by default.
For Mac use, use brew.
```
brew install node
```


## Run the server
```
rails s
```

## Database

### MongoDB

#### Installation
Follow this instruction [MongoDB](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/)

## Note
Run Elasticsearch
elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml

## Useful  Links
1. [Devise](https://github.com/plataformatec/devise)
2. [Paperclip](https://github.com/thoughtbot/paperclip)
3. [Homebrew](http://brew.io/)
