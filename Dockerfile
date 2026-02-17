FROM python:3.10.2
RUN apt-get update && apt-get install -y ca-certificates curl gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs netcat-openbsd p7zip-full
WORKDIR /usr/src/openfda
ADD . ./
RUN rm -rf .eggs _python-env openfda.egg-info logs
RUN ./bootstrap.sh
RUN ./_python-env/bin/python -m ensurepip --upgrade && \
    ./_python-env/bin/python -m pip install --upgrade pip setuptools && \
    ./_python-env/bin/python -m pip install -e . --no-build-isolation
CMD ["./scripts/all-pipelines-docker.sh"]

