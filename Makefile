test:
	docker run -it --rm --name haproxy-syntax-check my-haproxy haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
build:
	docker build -t my-haproxy ./haproxy
run:
	docker network create internal || true
	docker run --rm --network=internal -d tutum/hello-world
	docker rm -f my-running-haproxy || true
	docker run --rm --network=internal -p "1936:1936" --name my-running-haproxy my-haproxy
hatop:
	docker exec -it my-running-haproxy hatop -s /var/run/haproxy.sock