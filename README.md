# acts\_as\_graph\_object

ActiveRecord extension that maps models to Facebook Open Graph objects.

## Installation

```
gem install acts_as_graph_object
```

Then just add the dependancy to your `Gemfile`.

## Usage

### Configuration

```ruby
# app/config/initializers/acts_as_graph_object.rb
ActsAsGraphObject.configure do |config|
  config.namespace = 'my-app'
  config.app_id = 12345
  config.admins = [1245, 6789]
end
```

#### Default URL Method
In order to use the built in `@model.url` method you need to set the following config option:

```ruby
# app/config/environments/production.rb
routes.default_url_options[:host] = 'my-app.com'
```

#### Add acts\_as\_graph\_object...

```ruby
# app/models/movie.rb
class Movie < ActiveRecord::Base
  acts_as_graph_object :custom => [:director, :writer, :cast]

  def cast
  	...
  end
end
```

#### Outputting meta tags

Use the `graph_object_tags_for(@movie)` helper to output the resulting `<meta>` tags. You can use this in combination with `content_for` to push the results into your `<head>`:

```erb
# app/views/layouts/application.html.erb    
<head>
    <%= yield :meta_tags %>
</head>

# app/views/movies/show.html.erb
<% content_for :meta_tags, graph_object_tags_for(@movie) %>
```

#### Overriding from view
If you want to override a value from the view (for example to use a `url_for` helper):

```erb
# app/views/movies/show.html.erb
<% content_for :meta_tags, graph_object_tags_for(@movie, :url => movie_url(@movie)) %>
```

#### Alternative attribute names (v0.0.7)
You can now use non-default names for the standard Open Graph properties and the Gem will attempt to pick these up. Here are the properties and their alternative names:
```ruby
# standard object properties & alternative names
default_properties = {
  :title           => [:name, :label],
  :type            => [:kind, :group, :class],
  :image           => [:picture, :photo],
  :url             => [:permalink, :link],
  :description     => [:info, :details],
  :site_name       => [:site],
  :latitude        => [:lat],
  :longitude       => [:long],
  :street_address  => [:address],
  :locality        => [:locale, :area],
  :region          => [:province, :territory],
  :postal_code     => [:post_code, :zip_code, :zip],
  :country_name    => [:country],
  :email           => [:email_address],
  :phone_number    => [:phone],
  :fax_number      => [:fax]
}
```

#### Notes
This is my first gem so things are a bit rough around the edges, all feedback is happily welcomed :) - please fork/fix to your heart's content.

## Project Goals
1\. Find a way to provide model URLs using the url_for view/controller helpers.

2\. Map common attribute names to `og` meta tags (e.g. title, description, image etc).

3\. Provide helpers that allow resulting meta tags to be easily added to global layout in a standar Rails REST architecture.
  i.e. for all /show actions, add meta tags to head if object has open graph attributes.

4\. Allow for easy configuration for constants such as `fb:app_id` & `fb:admins` as well as an *app namespace* to be used in `og:type` and any custom attributes.

5\. Automatically handle arrays, i.e. `:cast => ['Tom Cruise', 'Kelly McGillis', 'Val Kilmer']` becomes:

```html
<meta property="my-app:cast" content="Tom Cruise" />
<meta property="my-app:cast" content="Kelly McGillis" />
<meta property="my-app:cast" content="Val Kilmer" />
```

6\. Keep it unobtrusive! no heavy configuration in models, something simple, e.g.

```ruby
class Movie < ActiveRecord::Base
  acts_as_graph_object :custom => [:director, :writer, :cast]
end
```

This would map all standard properties `title`, `description`, `image`, `app_id` etc along with the custom properties `director`, `writer` & `cast`.

7\. **Write proper tests and documentation!**