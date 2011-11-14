
set :root_dir,   File.dirname( File.expand_path( __FILE__ ) ) + '/'
set :config,     YAML.load( IO.read( settings.root_dir + 'config.yaml' ) )
set :log,        File.new( settings.root_dir + 'log.txt', 'a' )

configure do

    repo_dir = settings.config['repo_dir']
    if settings.config.is_a?( String ) || !repo_dir || repo_dir.empty?
        raise "Empty 'repo_dir' in 'config.yaml'."
    end

    if !settings.config['user']
        raise "Empty 'user' in 'config.yaml'."
    end

    if !File.exist?( repo_dir + '/.git' )
        raise "Could not find git repository at: #{repo_dir}"
    end
end

helpers do
    def bad_request( str )
        log '[BAD REQUEST] ' + str

        status 400
        body str
    end

    def log( str )
        str = "[#{Time.now.to_s}] #{str}"
        STDERR.puts str
        settings.log << str
    end
end

get '/' do
end

post '/' do
    if !params[:token] || params[:token] != settings.config['token']
        bad_request "Invalid token."
        return
    end

    if !params[:payload]
        bad_request "Missing param 'payload'."
        return
    end

    begin
        push = ::JSON.parse( params[:payload] )
    rescue
        bad_request "Could not parse 'payload' data, expected valid JSON."
        return
    end

    if !push['repository'].is_a?( Hash ) || !push['repository']['url']
        bad_request "Missing repository data in 'payload'."
        return
    end

    ret = `cd #{settings.config['repo_dir']} && sudo -u #{settings.config['user']} git pull`
    log '[PULL] ' + ret
    ret
end

at_exit do
    settings.log.close
end