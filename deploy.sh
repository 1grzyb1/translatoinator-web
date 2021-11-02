docker build -t grzybek/translatoinator-web .
docker save grzybek/translatoinator-web | bzip2 | pv | ssh grzybek docker load
ssh grzybek docker rm $(docker stop $(docker ps -a -q --filter ancestor=grzybek/translatoinator-web --format="{{.ID}}"))
ssh grzybek docker run -p 5000:5000 --net=host -d grzybek/translatoinator-web