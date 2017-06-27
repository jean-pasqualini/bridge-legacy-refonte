### Bridge legacy refonte 

Le legacy dans cet exemple est en php sans framework et la refonte avec le framework symfony

#### Usage
1. bash
2. eval $(docker-machine env [nomdockermachine])
3. cd [chemindupoc]
4. docker stop $(docker ps -aq)
5. docker-compose up

#### Refonte

http://[ip]/hello<br><br>

#### Legacy

http://[ip]/une-page<br><br>

Dans les entête de la réponse on retrouve X-fallback legacy l'orsque c'est le legacy qui répond