require "kemal"

Kemal.config.port = 3000

get "/" do
  "Hello World!"
end

Kemal.run
