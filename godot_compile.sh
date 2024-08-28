rm -R ./app/views/wordle
mkdir ./app/views/wordle
./bin/godotv3 --no-window --export "Web" --path ./app/godot/wordlev3/
exit 0