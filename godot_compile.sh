rm -R ./app/views/wordle
mkdir ./app/views/wordle
./bin/godotv3 --headless --export "Web" --path ./app/godot/wordlev3/
exit 0