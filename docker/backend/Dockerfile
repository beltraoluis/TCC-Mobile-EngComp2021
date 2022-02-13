FROM python
COPY server.tar.gz ./server.tar.gz
RUN apt-get install libpq-dev -y; \
    pip install --upgrade pip; \
    tar -xzf server.tar.gz; \
    cd server; \
    pip3 install -r requirements.txt; \
    python3 api.py