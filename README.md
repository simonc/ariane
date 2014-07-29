# Project not maintained!

**Ariane is not maintained anymore. Take a look at [breadcrumbs_on_rails](https://github.com/weppos/breadcrumbs_on_rails) instead.**

# Ariane [![Build Status](https://secure.travis-ci.org/simonc/ariane.png?branch=master)](http://travis-ci.org/simonc/ariane)


Ariane is a flexible breadcrumb system for Rails. And it's fully compatible with 
the [Twitter Bootstrap](http://twitter.github.com/bootstrap/) !

It works perfectly with Rails 3 and allows to use I18n.

## Installation

Add the following line to your `Gemfile`:

``` ruby
gem 'ariane'
```

And then execute:

    bundle

## Requirements

* Ruby >= 1.9.x

## Quickstart

To get started, define a before_filter in your `ApplicationController` and use
it to add the first entry:

``` ruby
class ApplicationController < ActionController::Base
  before_filter :set_ariane

  protected

  def set_ariane
    ariane.add 'Home', root_path
  end
end
```

You can then add more entries from your other controllers:

``` ruby
class OtherController < ApplicationController
  protected

  def set_ariane
    super
    ariane.add 'Other', other_path
  end
end
```

Then in your layout, simply call `ariane.render` to see the magic happen:

``` erb
<%= ariane.render %>
```

This will render the following:

``` html
<ul class="breadcrumb">
  <li>
    <a href="/">Home</a>
    <span class="divider">/</span>
  </li>
  <li class="active">Other</li>
</ul>
```
## ariane.add

`ariane.add` takes two arguments, both being optional.

* `text` is the text to use as link text
* `url` is the path to where you want the link to point

Note that if you don't set the url, the text will simply be rendered as is.

Alternatively, you can pass a block to `ariane.add`. The block will receive the new crumb as argument.

``` ruby
ariane.add do |crumb|
  crumb.text = 'Home'
  crumb.url  = root_path
end
```

## Customize the output

Ariane provides a set of renderers you can use to generate the output. To see
the options you can use with each renderer, take a look at the wiki.

The default renderer is `HTMLList` but you can select another one.

### Using ariane.render

You can choose the renderer when calling `ariane.render` by passing it as the
first argument:

``` erb
<%= ariane.render(Ariane::Render::HTML) %>
```

This will render the following text:

``` html
<p class="breadcrumb">
  <a href="/">Home</a> / Other
</p>
```

### Using an initializer

You may also choose to set the renderer when Rails is loaded:

``` ruby
# config/initializers/ariane.rb
Ariane.configure do |config|
  config.default_renderer = Ariane::Render::HTML
end
```

If you want further customization, you can instanciate the renderer and then use
it in `Ariane.configure`.

``` ruby
# config/initializers/ariane.rb
rndr = Ariane::Render::HTML.new(divider: ' | ')

Ariane.configure do |config|
  config.default_renderer = rndr
end
```

Calling `ariane.render` will output the following HTML:

```
<p class="breadcrumb">
  <a href="/">Home</a> | Other
</p>
```

## Bring your own Renderer

Ariane is flexible enough to let you define or extend renderers.

``` ruby
class HTMLOrderedList < Ariane::Render::HTMLList
  def list(crumbs)
    content_tag(:ol, class: options[:list_class]) do
      raw items(crumbs)
    end
  end

  def divider
    content_tag(:span, '|', class: 'separator')
  end
end
```

This example is simple but shows that you can touch pretty anything in the
renderers.

Now if you call

``` erb
<%= ariane.render(HTMLOrderedList) %>
```

You'll obtain the following HTML:

``` html
<ol class="breadcrumb">
  <li>
    <a href="/">Home</a>
    <span class="separator">|</span>
  </li>
  <li class="active">Other</li>
</ul>
```

### Create a renderer from scratch

You can create a complete renderer, simply take a look at
`lib/ariane/render/html.rb` for a complete example implementation.

### I18n

Since Ariane is used in before filters or in the views, it supports
I18n out of the box.

``` ruby
ariane.add t('home'), root_path
```

## Boring legal stuff

Copyright (c) 2012, Simon COURTOIS

Permission to use, copy, modify, and/or distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright notice
and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
THIS SOFTWARE.
