function virtualenv_prompt_info(){
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX:=[}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX:=]}"
}

# Automatic venv activation/deactivation
_toggleVenvShell() {
  # deactivate shell if .venv doesn't exist and not in a subdir
  if [[ ! -a "$PWD/.venv" ]]; then
    if [[ "$VENV_ACTIVE" == 1 ]]; then
      if [[ "$PWD" != "$venv_dir"* ]]; then
	deactivate
        export VENV_ACTIVE=0
      fi
    fi
  fi

  # activate the venv if .venv exists
  if [[ "$VENV_ACTIVE" != 1 ]]; then
    if [[ -a "$PWD/.venv" ]]; then
      export venv_dir="$PWD"
      source .venv/bin/activate
      export VENV_ACTIVE=1
    fi
  fi
}
chpwd_functions+=(_toggleVenvShell)

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1
