# justfile grammar: https://github.com/casey/just/blob/master/GRAMMAR.md

cli:
  just --list               = list alphabetically
  just --summary            = more concise
  just --list --unsorted    = order they're in file
  just --list --list-prefix = tab separator
  just --evaluate           = evaluate vars
  just --show recipe_name   = show the recipe
  just --choose             = choose recipes where take no args
  just --chooser            = set chooser default fzf or $JUST_CHOOSER

set shell := ["python3", "-c"]
set shell := ["bash", "-uc"]
set shell := ["zsh", "-uc"]

# export all vars as env
set export
# load .env file
set dotenv-load

# POSITIONAL ARGS =====
  # recipe args passed as positional args to cmds
set positional-arguments
@foo bar:
  echo $0 # name of recipe
  echo $1

system-info:
    @echo "This is an {{arch()}} machine".
    echo "This here will show command"

alias b := build
build:
  echo 'Building!'

version := "0.2.7"
tardir  := "awesomesauce-" + version
tarball := tardir + ".tar.gz"

publish:
    rm -f {{tarball}}
    mkdir {{tardir}}
    cp README.md *.c {{tardir}}
    tar zcvf {{tarball}} {{tardir}}
    scp {{tarball}} me@server.com:release/
    rm -rf {{tarball}} {{tardir}}

foo:
    -cat foo # continue even if errors : prefix with hyphen
    echo 'Done!'

# BUILTIN FUNCTIONS ================================================
# retrieve env var w/ name key, abort if not there
aa := env_var(key)
# retrieve env var w/ name key, returning default if not there
env_var_or_default(key, default)
# retrieve path of cwd before just chdir'd before executing
invocation_directory()

rustfmt:
    find {{invocation_directory()}} -name \*.rs -exec rustfmt {} \;

# run from cwd
build:
    cd {{invocation_directory()}}; ./some_script_that_needs_to_be_run_from_here

# path of curr justfile
justfile()
# path of parent dir of curr justfile
justfile_directory()

script:
  ./{{justfile_directory()}}/scripts/some_script

# path of just executable (/bin/just)
just_executable()

executable:
    @echo The executable is at: {{just_executable()}}

# DOT ENV (hi.env)

DATABASE_ADDRESS=localhost:6379
SERVER_PORT=1337

serve:
  @echo "Starting server with database $DATABASE_ADDRESS on port $SERVER_PORT..."
  ./server --database $DATABASE_ADDRESS --port $SERVER_PORT

# BACKTICKS - COMMAND EVALUATION ==================================
localhost := `dumpinterfaces | cut -d: -f2 | sed 's/\/.*//' | sed 's/ //g'`

serve:
    ./serve {{localhost}} 8080

# This backtick evaluates the command `echo foo\necho bar\n`, which produces the value `foo\nbar\n`.
stuff := ```
    echo foo
    echo bar
  ```

# CONDITIONAL EXPRESSIONS ==============================================
foo := if "2" == "2" { "Good!" } else { "1984" }
foo := if "hello" != "goodbye" { "xyz" } else { "abc" }
# short-circuit (backticks not run when shouldn't)
foo := if env_var("RELEASE") == "true" { `get-something-from-release-database` } else { "dummy-value" }

bar:
  @echo "{{foo}}"

bar foo:
  echo {{ if foo == "bar" { "hello" } else { "goodbye" } }}

# SETTING VARS FROM CLI ===============================================
os := "linux"
# $ just os=macos
# $ just --set os bsd

# ENV VARIABLES ========================================================
export RUST_BACKTRACE := "1"
test:
    cargo test

# equivalent

test $RUST_BACKTRACE="1":
    cargo test

# RECIPE PARAMETERS ======================================================
# param = target
build target:
    @echo 'Building {{target}}...'
    cd {{target}} && make

# $ just build my-awesome-project

# pass args to dependency
default: (build "main")
build target:
  @echo 'Building {{target}}...'
  cd {{target}} && make

# params may have default values
default := 'all'
test target tests=default:
    @echo 'Testing {{target}}:{{tests}}...'
    ./test --tests {{tests}} {{target}}

# $ just test server -- default values ommitted
# $ just test server unit -- or supplied

# concat
test triple=(arch + "-unknown-unknown"):

# variadic: put + or *
# + = one or more args and expand to string containing
backup +FILES:
  scp {{FILES}} me@server.com:

# * = zero or more args and expand to string containing
commit MESSAGE *FLAGS:
  git commit {{FLAGS}} -m "{{MESSAGE}}"

# variadic assigned default values; overridden by cli args
test +FLAGS='-q':
  cargo test {{FLAGS}}

# quote substitutions if contain spaces
search QUERY:
  lynx 'https://www.google.com/?q={{QUERY}}'

# exported as var
foo $bar:
  echo $bar

# RUNNING OTHER RECIPES ========================================
a:
  echo 'A!'
b: a
  echo 'B!'
  just c
c:
  echo 'C!'


# RECIPES AS SCRIPTS / OTHER LANGUAGES =================================
polygot: perl sh
perl:
  #!/usr/bin/env perl
  print "Larry Wall says Hi!\n";

sh:
  #!/usr/bin/env sh
  hello='Yo'
  echo "$hello from a shell script!"

foo:
  #!/usr/bin/env bash
  set -euxo pipefail # safer
  hello='Yo'

# MULTILINE =========================================================
# IF / FOR / WHILE
conditional:
  if true; then echo 'True!'; fi

conditional:
  if true; then \
      echo 'True!'; \
  fi

conditional:
  #!/usr/bin/env sh
  if true; then
      echo 'True!'
  fi

# PRIVATE RECIPES ================================================
# START WITH _ are omitted from just --list
test: _test-helper
  ./bin/test
_test-helper:
  ./bin/super-secret-test-helper-stuff

# QUIET RECIPES ================================================
# prefixed with @; inverts all the other @ (only lines starting with @ are echoed)
@quiet:
  echo hello
  echo goodbye
  @# all done!
# shebang are quiet by default

# DEFAULT RECIPES ================================================
default:
  @just --choose

# JUSTFILES IN OTHER DIRS =========================================
# first arg contains a /:
  # split at last /
  # part before last / treated as dir; start search there instead of cwd
  # after last slash treated as normal arg

# all equivalent
$ (cd foo && just build)
$ just foo/build
$ just foo/

# JUSTFILE SCRIPTS ==================================================
$ cat > script <<EOF
#!/usr/bin/env just --justfile

foo:
  echo foo
EOF
$ chmod +x script
$ ./script foo
echo foo
foo
