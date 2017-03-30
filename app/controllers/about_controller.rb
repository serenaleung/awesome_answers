class AboutController < ApplicationController

  def index

    # you can do something like this(assuming about folder is in views folder):
    # render 'about/index'

    # you can also do:
    # render :index
    # the above will assume that `index` template is inside `about` folder
    # because we're inside the `AboutController`

    # if you put nothing, then Rails will default to rendering:
    # app/views/about/index.html.erb because we're inside the AboutController
    # and `index` action (method) in that controller.

    # Note convention in naming Rails template:
    # ACTION.FORMAT.TEMPLATING_SYSTEM
    # FORMAT: default to `html` unless you specify otherwise, for instance
    #         if you go to: http://localhost:3000/about.text then the FORMAT
    #         will be `text`
    # TEMPLATING_SYSTEM: default to ERB unless you install another gem for
    #                    an alternate templating system. Available ones include
    #                    HAML and SLIM
  end

end
