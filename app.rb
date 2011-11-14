post '/' do
    # sample code from GitHub's example
    push = JSON.parse(params[:payload])
    "I got some JSON: #{push.inspect}"
end
