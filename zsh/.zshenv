export PATH="/usr/local/bin/:$HOME/.local/bin:/snap/bin:$PATH"
export EDITOR='nvim'
export VISUAL='nvim'
export ANKI_WAYLAND=1
# Load OpenAI key when shell starts
export OPENAI_API_KEY=$(gpg --decrypt ~/Documents/openai_api_key.txt.gpg 2>/dev/null | tr -d '\n')
export GEMINI_API_KEY=$(gpg --decrypt "$HOME/Documents/gemini_api_key.txt.gpg" 2>/dev/null | tr -d '\n')
# export TERM=xterm-256color
. "$HOME/.cargo/env"
