# RailsCodebook

## UPDATE: please reinstall gem and see the Initialization part of readme (the last one)

### Bear in mind, this is still WORKinPROGRESS and can be buggy, all issues filed will be appreciated as well as new ideas and help of all kinds :)

[![Build Status](https://travis-ci.org/redrick/rails_codebook.png?branch=master)](https://travis-ci.org/redrick/rails_codebook)
[![Coverage Status](https://coveralls.io/repos/redrick/rails_codebook/badge.png)](https://coveralls.io/r/redrick/rails_codebook)
[![Gem Version](https://badge.fury.io/rb/rails_codebook.png)](http://badge.fury.io/rb/rails_codebook)



## What is this ?

This is a gem tested with ruby 2.0.0-p247 and rails 4.0.0
First of all what the codebook is... usually is the collection of values that can be passed to [select_tag](http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-select_tag). As we are working on bigger projects, we do not want to make them heavy by just adding other model and controller and bunch of stuff for every codebook we use, there are potentially ten, almost a hundred in each project and it started to be overwhelming.
So there we go and create this little thing, which stores all the values for us in [redis](http://redis.io/) (noSQL database) and lets us comunicate with all the values through simple DSL, I will explain all as you read :)
OK that is the intro, lets dive in... (oh and for those "pics or didn't happen")

![#](https://raw.github.com/redrick/rails_codebook/master/doc/pictures/select_box.png)

## How can I install the damn thing ?

simple as always:
``` ruby
gem install rails_codebook
```

or by adding to your gemfile:
```
gem 'rails_codebook'
```

and running:
```
bundle install
```

after bundle, there is just the simple step of mounting routes like this (this goes to your ```config/routes.rb```):
```
# mount with
mount RailsCodebook::Engine => '/codebooks'
```

after that you kinda need to run (for default config and stuff all described in Configuration little later):

```
rails g rails_codebook:install
```



## How is it used ?

After installing gem make sure you  redis is running, if not simply run it with:
```
redis-server
```


### Configuration

for proper configuration make sure you run the install generator !
and for the options inside: 

```ruby
RailsCodebook.redis = Redis.new(db:'1') # the way to tell gem what redis DB to use

# config block defining key to look for in the yaml files given
# for more info about initialization of values look all the way down :)
RailsCodebook.configure do |config|
  config.cb_key = 'codebook'
  config.cb_data_path = ['config/locales/codebooks/cs.yml'] 
end

# initializing redis content, please do not change or remove
RailsCodebook::Engine.initialize_content
```




### Possibilities



#### 2WAYS

So as wee see it there are two options you want to put inside the select boxes:
= first are the values specially created and only used in main model in form of FK that references to this values
= and the second are the activerecord models that need to be codebookified, so they are not that heavy and can be worked with 

so I got two solutions:
= has_codebooks
= acts_as_codebook
(will explain the usage later)



#### GUI

As I was doing this, I needed some interface to manage Redis values apart from [redis-commander](http://nearinfinity.github.io/redis-commander/) which can be messy when I am only interested in some stuff that I want to add/remove/edit...
So here are screen of the GUI made for the values so we got them under controll :)


![#](https://raw.github.com/redrick/rails_codebook/master/doc/pictures/screen-1.png)

![#](https://raw.github.com/redrick/rails_codebook/master/doc/pictures/screen-2.png)

![#](https://raw.github.com/redrick/rails_codebook/master/doc/pictures/screen-3.png)

![#](https://raw.github.com/redrick/rails_codebook/master/doc/pictures/screen-4.png)



#### API

Also I am using it in Rails project that is REST API (as server) and there is Angularjs front, which from time to time needs (on search pages etc..) to ask for one/all members of certain codebook, so there is the light API:

as you added the ```mount RailsCodebook::Engine => '/codebooks'``` into your routes, whole gem is accessible at that route, I will take it as root (it actually is root for the gem :) )

you can use routes: 
  
  ```ruby
  # list of all codebook values 
  # you can change the language (because I forgot to mention that
  # I count with you using 'name' column as place for translation key)
  # use only two letters {en, cs, sk, pl}
  GET "/api/(:lang)"

  # you can look through all values by passing GET query under 'q' key
  GET "/api/(:lang)?q=somequery"

  # for getting one codebook, cb_name is its name, please do not use others that '_' in names
  GET "/(:lang)/:cb_name"
  
  # you can look through the codebook values by passing GET query under 'q' key
  GET "/(:lang)/:cb_name?q=somequery"

  # show method of one of the codebooks thorugh its cb_name and id
  GET "/(:lang)/:cb_name/:id"
  ```



### Usage

OK and now to the best part :) I got this developed and tested against ActiveRecord '4.0.1' but I am not saying it is not possible it will run on older versions too...
It adds two methods to Activerecord that generate those codebook ones, here they are both in one model:
``` ruby
class Article < ActiveRecord::Base

  has_codebooks({
    'importance_cb' => 'importances',
    'options' => {
      'fk_cb' => 'value'
    }
  })

  acts_as_codebook({
    'key'   => 'id',
    'value' => 'title'
  })
end
```

#### has_codebooks

this method is for defining which codebooks is the model using and for better usability olson on which column which codebook is mapped, so the use for simple declaring the column => codebook :

```ruby
has_codebooks({
  'importance_cb' => 'importances'
})
```

you can pass as many codebooks as you want and as added value I was solving polymorphism, when you got a model like [HERE](http://guides.rubyonrails.org/association_basics.html#polymorphic-associations) and I came to issue, that every model that can be associated with the polymorphic table needs to have its role in the polymorphic table (given that every model has set of its own roles)... this started to be messy, so I added it here and you can use it like this:
```ruby
has_codebooks({
  "role_cb" => "polymorphic"             # says look to options, you are not going to find cb_name here :)
  "options" => {
    "role_cb" => {                       # in case there are more codebooks that need these options
      "cb_format" => "projectable_type"  # will always be joined from (cb_format is column where the first part is) :
                                         # cb_format+"_"+model.table_name+"_"+column_name.pluralized
    }
  }
})
```

Also for the curious cases I added the 'fk_cb' config option, it is for defining what will be put as FK (yes sometimes you need a string value otherwise it is always the ID), you can use it inside the column config or inside options alone(for all):
```ruby
has_codebooks({
  "status_cb"     => "boolean", # defining column_name => codebook_name
  "importance_cb" => "importance",
  "options" => {
    "status_cb" => {
      "fk_cb" => "id" # which value from codebook to use as FK for the model (usually id, value)
                      # can also be defined for each one codebook :)
    }
    "fk_cb" => "value" # all other will use this fallback or the default _value one :)
  }
})
```
If you need more, I will gladly add those, just write a suggestion in issues :)


Calling this in your model adds a bunch of methods into the ActiveRecord model always starting in the column_name stripped from '_cb' so for 'type_cb' all will start with 'type' (now on I will use base_column_name):

  * base_method_name+"\_object" => gives you the actual rel object

  * self.base_method_name+"\_codebook\_name" => prints out the codebook name for you

  * base_method_name => serialized json format of actual object
 
  * self.base_method_name+"\_object\_all"  => returns array of all codebook objects 

  * self.base_method_name+"\_collection" => collection that can be passed to select_tag options

  * self.base_method_name+"\_all" => serialized object_all

  * self.base_method_name+"\_values" => array of all "values" (translated names into actual language)

  * self.base_method_name+"\_keys" => array of all keys



#### acts_as_codebook

is the second way I already mentioned, you can easily transform existing ActiveRecord model into codebook by adding this to it and maybe defining which value to take as key and which as value, like this:
```ruby
acts_as_codebook({
  "key"        => "name_for_key",
  "value"      => "name_for_value"
})
```
it, as previous one adds some methods to ActiveRecord model, so if you got problems with method names, I gave you the 'method' option to set different name, otherwise the default (model_name) will be appplied:
```ruby
acts_as_codebook({
  "method"        => "method_base_name"
})
```
And here are methods that are added (method name will be reffered to as base_method_name as before :) ):

  * base_method_name+"\_object" => gives you the actual object in cb form 

  * self.base_method_name+"\_name" => prints out the codebook name for you

  * base_method_name+"\_this" => serialized json format of actual object
 
  * self.base_method_name+"\_object\_all"  => returns array of all model rows as cb objects 

  * self.base_method_name+"\_all" => serialized object_all

  * self.base_method_name+"\_values" => array of all "values"

  * self.base_method_name+"\_keys" => array of all keys




### Initialization

If you want to use this gem, you somehow need to initialize all the values inside it.
For that purpose I made it as simple as possible. I am counting on you that you are creating a multilang application, so you are familiar  with [I18n](http://guides.rubyonrails.org/i18n.html) concepts in rails and you are using them in this application.
Therefore you got to have your translations for every codebook value you want to use.

I myself use the initializzation process like this:

in ```config/locales``` I created myself the ```codebooks``` directory where I placed all the files with different translations of codebook values in certain format:
```config/locales/codebook/cs.yml```
```yaml
cs:
  codebook:  # this is the cb_key you can define in config block in case you dont like my default
    boolean: # this is the codebook name
      'yes': 'ano' # this is the value
      'no': 'ne'
    importance:
      low: 'nízká'
      medium: 'střední'
      high: 'vysoká'
```

So after keeping this in mind I will take your yml files (you can enter multiple relative routes into array) and loop through them and produce redis "rows" like this one (first one from the yml above):
```
#<RailsCodebook::Codebook:0x007fbb6d2e4a98 
  @id=1,  
  @name="codebook.boolean.yes", 
  @value="yes", 
  @cb_name="boolean",
  @persisted=true, 
  @_model_name="rails_codebook/codebook", 
  @created_at=2013-11-28 10:14:57 +0100, 
  @updated_at="2013-11-28 10:14:57", 
  @sequence=100, 
  @deleted=0> 
```
do not worry that you have no idea what those other attributes are, either way for not you use only first four :)



#### OK that is all for now, TUNE FOR MORE INFO



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/redrick/rails_codebook/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

