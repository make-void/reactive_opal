# required: opal + browser
`self.$require("browser");`
`self.$require("browser/http");`


class State
  @@state = {}

  def self.all
    @@state
  end

  def self.all=(state)
    @@state = state
  end
end


# env.rb: initial state
State.all = { line: 1 }


# actions
def add_element
  line.append_to $document["container"]
end

class Actions
  def self.handle_click
    -> do
      State.all = { line: State.all[:line]+1 }
      add_element
    end
  end
end



# lib
def apply_view_event_bindings(app_container)
  # real code should scan views and apply listeners when finds on-click="handl"
  app_container.on :click, &Actions.handle_click
end


# view partial
def line
  DOM {
    div.info {
      span.red "added line: #{State.all[:line]}"
    }
  }
end


# view (main view atm)
$document.ready do
  app_container = $document["container"]

  # router / controller
  #
  # if route == "/"
    line.append_to app_container
  # else
  #   info_view.append_to app_container
  # end

  apply_view_event_bindings app_container
end


# notes:

# Browser::HTTP.get "/test.json" do
#   on :success do |res|
#     alert res.json.inspect
#   end
# end
