docker build -t niniack/writing:latest .
docker run -i -v $(pwd):/github/workspace --user $UID:$GID niniack/writing:latest