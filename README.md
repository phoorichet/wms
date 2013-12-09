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

## GEMs
WMS was originally developed as a single repo. We then created gems to modulize the package.

1. [wms-core](https://github.com/phoorichet/wms-core) is a gem that contains core library for WMS.
2. [wms-widget-timespentlocation](https://github.com/phoorichet/wms-widget-timespentlocation) is an example of widget implemented as a gem.
3. [wms-widget-wifissid](https://github.com/phoorichet/wms-widget-wifissid) is an example of widget implemented as a gem.


## Useful  Links
1. [Devise](https://github.com/plataformatec/devise)
2. [Paperclip](https://github.com/thoughtbot/paperclip)
3. [Homebrew](http://brew.io/)


