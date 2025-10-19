ARG IMAGE=intersystemsdc/iris-community:2020.3.0.221.0-zpm
ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

WORKDIR /home/irisowner/dev

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    iris stop IRIS quietly

RUN old=http://localhost:52773/crud/_spec && \
	new=http://localhost:52774/loan/api/_spec && \
	sed -i "s|$old|$new|g" /usr/irissys/csp/swagger-ui/swagger-initializer.js

