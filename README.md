# README

Simple API to create orders and invoices
It act as a producer to confluent Kafka

## Run

You will need postgres running (you have the docker-compose)

```shell
git clone git@github.com:ruby-kafka-poc/orders_api.git
cd orders_api

open https://confluent.cloud
# Create a free account (no credit card needed free for 1 month), create a cluster,
# create a global API key
# go to cluster, cluster overview, cluster settings and get the bootstrap server

# WARNING DO NOT COMMIT THIS THINGS ANYWHERE!!!
echo "
BOOTSTRAP_SERVERS=AAAAAAAAAA:9092
SECURITY_PROTOCOL=sasl_ssl
SASL_MECHANISM=PLAIN
SASL_USERNAME=BBBBBB
SASL_PASSWORD=CCCCCCC
" >> .priv_env
export $(cat ./.private_env | sed 's/#.*//g' | xargs )


bundle install
bundle update
bundle exec rake db:create db:migrate db:seed
```

## Routes

```shell
GET    /invoices/:invoice_id/items
POST   /invoices/:invoice_id/items
PATCH  /invoices/:invoice_id/items/:id
PUT    /invoices/:invoice_id/items/:id
DELETE /invoices/:invoice_id/items/:id
GET    /invoices
POST   /invoices
GET    /invoices/:id
PATCH  /invoices/:id
PUT    /invoices/:id
DELETE /invoices/:id
GET    /orders/:order_id/items
POST   /orders/:order_id/items
PATCH  /orders/:order_id/items/:id
PUT    /orders/:order_id/items/:id
DELETE /orders/:order_id/items/:id
GET    /orders
POST   /orders
GET    /orders/:id
PATCH  /orders/:id
PUT    /orders/:id
DELETE /orders/:id
```
