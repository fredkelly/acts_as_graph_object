acts_as_graph_object
====================

ActiveRecord extension that maps models to Facebook Open Graph objects.

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
  
### Default URL Method
In order to use the built in @model.url method you need to set the following config option:
```
# ./config/environments/production.rb
routes.default_url_options[:host] = 'my-app.com'
```