rm -R ./app/views/quiz
mkdir ./app/views/quiz
./bin/godotv3 --no-window --export "Web" --path ./app/godot/quiz/
exit 0