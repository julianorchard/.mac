# .mac

Managed in a macish way with `stow`... maybe YADM would've been better but
yeah, I haven't used GNU stow for this before so thought it would be fun to try
it out!

## Stow

Use this wrapper command to deploy:

```sh
./jim terminal
```

Stow everything:

```sh
./jim $(find * -prune -type d)
```

## Brew

Back-up:

```sh
brew bundle dump --force --file="${HOME}/Brewfile"
```

Resurrection 🍺

```sh
brew bundle install --file="${HOME}/Brewfile"
```
