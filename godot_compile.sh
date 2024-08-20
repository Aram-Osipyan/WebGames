rm -R ./app/views/wordle
mkdir ./app/views/wordle
./bin/godotv4 --headless --export-release "Web" --path ./app/godot/wordle/
exit 0