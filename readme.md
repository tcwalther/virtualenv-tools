# Python Virtualenv Tools

If you envy Rubyists for their nice management of gemsets, this collection of script might be for you. Virtualenvs work great when they are used for a single project each. If you find yourself reusing the same virtualenvs in multiple folders, you might prefer a centralized solution.

With these scripts you:
- organize all your virtualenvs in `~/.virtualenvs/`
- activate virtualenvs using `activate foo`, including bash tab completion
- list available virtualenvs using `list-envs`
- create new virtualenvs using the same old `virtualenv` command
- inherit system site packages in new virtualenvs by default (if you don't want this behaviour, pass `--no-site-packages`)


## Usage

```bash
$ # Create a virtualenv:
$ virtualenv foo
Creating virtualenv...
Installing newest pip and ipython...
Done.

$ # Activate the virtualenv:
$ activate foo

(foo)$ # Verify that system packages were inherited:
(foo)$ pip freeze
nose==1.3.0
numpy==1.7.1
numpydoc==0.5
pandas==0.16.2
requests==2.7.0
scipy==0.12.1
virtualenv==13.1.0
... (this is of course a stripped example output)

(foo)$ # Deactivate the virtualenv:
(foo)$ deactivate

$ # list existing virtualenvs
$ list-envs
foo
$ # delete virtualenv
$ delete-env foo
Do you really want to delete the virtual environment foo?
1) Yes
2) No
#? 1
virtualenv foo deleted.

$ 
```

## Installation
Clone this repo into `~/.virtualenvs`:
```bash
$ git clone https://github.com/tcwalther/virtualenv-tools.git ~/.virtualenvs
```

Check that it worked: `ls ~/.virtualenvs/activate-env.sh`

Then add the following to your `~/.bash_profile`:

```bash
export PATH="$HOME/.virtualenvs:$PATH"
alias activate="source activate-env.sh"
alias virtualenv="create-env.sh"
complete -o default -o nospace -W "$(list-envs | awk '{print $0}' ORS=' ')" activate
complete -o default -o nospace -W "$(list-envs | awk '{print $0}' ORS=' ')" delete-env
```

A `source ~/.bash_profile`, or a log-out and log-in later, and you are ready to go.
