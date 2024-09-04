rm -R $1
mkdir $1
./bin/godotv3 --no-window --export "Web" --path $2
exit 0