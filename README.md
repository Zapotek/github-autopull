# GitHub AutoPull

Small Sinatra app to auto-pull fresh code upon pushes to a GitHub repo.

## Installation

Execute `bundle install` to install all dependencies.

## Configuration

Open up `config.yaml` and set:

* `repo_dir` to the path of your local Git repository
* `token` to a secret value
* `user` to a local user that can pull from the GitHub project (i.e. has the proper SSH keys)

Optionally, you can specify a file to be `touch`ed after every pull request.

## Usage

Execute `rackup` from inside the AutoPull directory.

Pass the following URL to the 'Post-Receive URLs' hook: `http://<host>/?token=<token>`