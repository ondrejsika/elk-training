[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io> | [course ->](#course)

![](./images/elastic_banner.svg)

# ELK / Log Management Training

## About Course

- [ELK Training in Czech Republic](https://ondrej-sika.cz/skoleni/elk)
- [ELK Training in Europe & Middle East](https://ondrej-sika.com/training/elk)

### Any Questions?

Write me mail to <ondrej@sika.io>

### Related Courses

- [Kubernetes Training in Czech Republic](https://ondrej-sika.cz/skoleni/kubernetes)
- [Loki Training in Czech Republic](https://ondrej-sika.cz/skoleni/loki) (Log management in Grafana)
- [Kubernetes Training in Europe & Middle East](https://ondrej-sika.com/training/kubernetes)
- [Loki Training in Europe & Middle East](https://ondrej-sika.com/training/kubernetes) (Log management in Grafana)

## Related repositories

- Demo ELK on Digital Ocean - https://github.com/ondrejsika/terraform-demo-elk

## Course

## About Me - [Ondrej Sika](https://sika.io)

**Freelance DevOps Engineer, Consultant & Lecturer**

- Complete DevOps Pipeline
- Open Source / Linux Stack
- Cloud & On-Premise
- Technologies: Git, Gitlab, Gitlab CI, Docker, Kubernetes, Terraform, Prometheus, ELK / EFK, Rancher, Proxmox, DigitalOcean, AWS

## DevOps Live (Czech only)

[![](./images/devopslive_argocd.jpg)](https://ondrej-sika.cz/devopslive)

<https://ondrej-sika.cz/devopslive>

## DevOps Kniha (Czech only)

[![](./images/devops_kniha.jpg)](https://kniha.sika.io)

<https://kniha.sika.io>

## Star, Create Issues, Fork, and Contribute

Feel free to star this repository or fork it.

If you found bug, create issue or pull request.

Also feel free to propose improvements by creating issues.

### Chat

For sharing links & "secrets".

- Zoom Chat
- Slack - https://sikapublic.slack.com/
- Microsoft Teams
- https://sika.link/chat (tlk.io)

## Agenda

- Introduction to ELK
- Install Elasticsearch & Kibana
  - Debian
  - Using Docker
  - Kubernetes (preferred)
- Filebeat
  - Install
  - Configuration
- Kibana
  - Overview
  - Discover
  - Visualize
  - Dashboard
  - Management

## Overview

- Elasticsearch
- Kibana
- Beats

### Elasticsearch Overview

[What is Elasticsearch (Docs)](https://www.elastic.co/guide/en/elasticsearch/reference/current/elasticsearch-intro.html)

Elasticsearch is the distributed search and analytics engine at the heart of the Elastic Stack. Beats facilitate collecting, aggregating, and enriching your data and storing it in Elasticsearch. Kibana enables you to interactively explore, visualize, and share insights into your data and manage and monitor the stack. Elasticsearch is where the indexing, search, and analysis magic happens.

### Kibana Overview

[Kibana Intro (Docs)](https://www.elastic.co/guide/en/kibana/current/introduction.html)

Visualize and analyze your data and manage all things Elastic Stack.

![](./images/intro-kibana.png)

### Beats Overview

[Filebeat Overview](https://www.elastic.co/guide/en/beats/filebeat/8.x/filebeat-overview.html)

![](./images/filebeat.png)

## Install

## Install Elasticsearch & Kibana

### Debian

- https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html
- https://www.elastic.co/guide/en/kibana/current/deb.html

```
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
```

```
sudo apt-get install apt-transport-https
```

```
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
```

```
sudo apt-get update && sudo apt-get install elasticsearch
```

Initial node

Set `cluter.name` and listen on all interfaces (`network.host`) in `/etc/elasticsearch/elasticsearch.yml`

```
vim /etc/elasticsearch/elasticsearch.yml
```

```
sudo /bin/systemctl enable elasticsearch.service --now
```

Reset `elastic` user password

```
/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic --batch
```

```
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node
```

or join cluster

Set `cluter.name` in `/etc/elasticsearch/elasticsearch.yml`

```
vim /etc/elasticsearch/elasticsearch.yml
```

```
export TOKEN=
```

```
/usr/share/elasticsearch/bin/elasticsearch-reconfigure-node --enrollment-token $TOKEN
```

```
sudo /bin/systemctl enable elasticsearch.service --now
```

Install Kibana

```
sudo apt-get update && sudo apt-get install kibana
```

Listen on all interfaces (`server.host`) in `/etc/kibana/kibana.yml`

```
vim /etc/kibana/kibana.yml
```

Create token for Kibana (on ES node)

```
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
```

```
TOKEN=
```

```
/usr/share/kibana/bin/kibana-setup --enrollment-token $TOKEN
```

```
sudo /bin/systemctl enable kibana.service --now
```

HTTP CA is on `/etc/elasticsearch/certs/http_ca.crt`

You can try ES from curl

```
ELASTIC_PASSWORD=
```

```
curl --cacert /etc/elasticsearch/certs/http_ca.crt https://elastic:$ELASTIC_PASSWORD@127.0.0.1:9200
```

### Using Docker

Simple single node installation for development (without auth)

```
cd examples/docker/elk_local
docker compose up -d
```

Simple single node installation with auth and https

```
cd examples/docker/elk_local_secure
docker compose up -d
```

and see [Makefile](examples/docker/elk_local_secure/Makefile)

### Demo ELK on Digital Ocean

Source: [ondrejsika/terraform-demo-elk](https://github.com/ondrejsika/terraform-demo-elk)

See:

- http://elk-docker.sikademo.com:9200
- http://elk-docker.sikademo.com:5601
- https://es.elk-docker.sikademo.com
- https://kb.elk-docker.sikademo.com

### Using Kubernetes

#### Elastic Cloud on Kubernetes

- Intro - https://www.elastic.co/elastic-cloud-kubernetes
- Docs / Tutorial - https://www.elastic.co/guide/en/cloud-on-examples/k8s/current/index.html
- Deploy ECK - https://www.elastic.co/guide/en/cloud-on-examples/k8s/current/k8s-deploy-eck.html
- Github - https://github.com/elastic/cloud-on-k8s

#### Install ECK

<https://www.elastic.co/docs/deploy-manage/deploy/cloud-on-k8s/install-using-helm-chart>

```
helm install \
  elastic-operator \
  --repo https://helm.elastic.co \
  eck-operator \
  -n elastic-system \
  --create-namespace \
  --wait
```

#### Create elk namespace

```
kubectl apply -f ./examples/k8s/ns.yml
```

#### Install Single Node Elasticsearch & Kibana

```
kubectl apply -f ./examples/k8s/elk_single_node
```

Wait until Elasticsearch and Kibana will be GREEN

```
kubectl get -f ./examples/k8s/elk_single_node
```

Get password for user `elastic`

```
kubectl -n elk get secret elk-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
```

or using `slu`:

```
slu eck elastic-password -n elk -e elk
```

See:

- https://es.k8s.sikademo.com
- https://kb.k8s.sikademo.com

Test it:

```
export ELASTIC_PASSWORD=$(kubectl -n elk get secret main-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)
filebeat -c `pwd`/filebeat/filebeat-k8s-test.yml -e
```

#### Upgrade to Elasticsearch Cluster

```
kubectl get -f ./examples/k8s/elk_cluster
```

Wait until Elasticsearch and Kibana will be GREEN

```
kubectl get -f ./examples/k8s/elk_cluster
```

See:

- https://es.k8s.sikademo.com
- https://kb.k8s.sikademo.com

## User Management

## User Management using Terraform

- Provider - https://registry.terraform.io/providers/elastic/elasticstack/latest/docs
- User - https://registry.terraform.io/providers/elastic/elasticstack/latest/docs/resources/elasticsearch_security_user
- API Key - https://registry.terraform.io/providers/elastic/elasticstack/latest/docs/resources/elasticsearch_security_api_key
- Role - https://registry.terraform.io/providers/elastic/elasticstack/latest/docs/resources/elasticsearch_security_role

```
cd ./examples/terraform/users
```

Create `main.auto.tfvars` ...

```
terraform init
```

```
terraform apply
```

See: https://kb.k8s.sikademo.com/app/management/security/users

## Install Filebeat

[Docs](https://www.elastic.co/downloads/beats/filebeat) | [Quick Start Installation](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation-configuration.html#installation)

### Mac

```
brew install elastic/tap/filebeat-full
```

### Debian

```
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-9.0.1-amd64.deb
sudo dpkg -i filebeat-9.0.1-amd64.deb
```

or using `slu`:

```
slu install-bin filebeat
```

## Fake Log Generators

### slu loggen

Plaintext log generator

```
slu loggen
```

JSON log generator

```
slu loggen --json
```

### Flog

Source: https://github.com/mingrammer/flog

Install on Mac

```
brew install mingrammer/flog/flog
```

Run

```
flog -d 100ms --loop
```

### Kubernetes/test/images/logs-generator

Source: https://pkg.go.dev/k8s.io/Kubernetes/test/images/logs-generator

Run in Docker

```
docker run -i \
  -e "LOGS_GENERATOR_LINES_TOTAL=10" \
  -e "LOGS_GENERATOR_DURATION=1s" \
  gcr.io/google_containers/logs-generator:v0.1.1
```

Run in Kubernetes

```
kubectl run logs-generator \
  --image=gcr.io/google_containers/logs-generator:v0.1.1 \
  --restart=Never \
  --env "LOGS_GENERATOR_LINES_TOTAL=1000" \
  --env "LOGS_GENERATOR_DURATION=1m"
```

## Filebeat

### Filebeat Inputs

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html)

- Log
- Stdin
- Container
- Docker
- Syslog
- Kafka

#### From file

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-log.html)

Run `slu loggen`

```
slu loggen --log-file /tmp/default.log --log-prefix loggen-file
```

Run filebeat

```
filebeat -c $(pwd)/examples/filebeat/filebeat-input-log.yml -e
```

#### From STDIN

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-input-stdin.html)

Run `slu loggen` & filebeat

```
slu loggen --log-prefix loggen-stdin | filebeat -c $(pwd)/examples/filebeat/filebeat-input-stdin.yml -e
```

#### From Container

[Docs](https://www.elastic.co/guide/en/beats/filebeat/master/filebeat-input-container.html)

Run some Docker container

```
docker run --name slu-loggen -d sikalabs/slu:v0.74.0 slu loggen --log-prefix loggen-container
docker run --name loop -d ondrejsika/infinite-counter
```

```
filebeat -c $(pwd)/examples/filebeat/filebeat-input-container.yml -e
```

### Filebeat Outputs

- Elasticsearch
- Kafka
- File
- Console

#### File

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/console-output.html)

```
slu loggen | filebeat -c $(pwd)/examples/filebeat/filebeat-output-file.yml -e
```

#### Console

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/console-output.html)

```
slu loggen | filebeat -c $(pwd)/examples/filebeat/filebeat-output-console.yml -e
```

Only logs

```
slu loggen | filebeat -c $(pwd)/examples/filebeat/filebeat-output-console.yml
```

Only message

```
slu loggen | filebeat -c $(pwd)/examples/filebeat/filebeat-output-console.yml | jq .message
```

### Multiline Log Messages

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/multiline-examples.html)

#### Python Traceback Example

```
cat examples/logs/multiline_python.txt | filebeat -c $(pwd)/examples/filebeat/filebeat-multiline-python.yml | jq .message
```

#### Java Traceback Example

```
cat examples/logs/multiline_java.txt | filebeat -c $(pwd)/examples/filebeat/filebeat-multiline-java.yml | jq .message
```

### Processors

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/filtering-and-enhancing-data.html)

- Conditions - https://www.elastic.co/guide/en/beats/filebeat/current/defining-processors.html#conditions

### Add Labels & Tags

- [Docs: Add Labes](https://www.elastic.co/guide/en/beats/filebeat/current/add-labels.html)
- [Docs: Add Tags](https://www.elastic.co/guide/en/beats/filebeat/current/add-tags.html)

Labels and Tags

```
echo x | filebeat -c $(pwd)/examples/filebeat/labels-and-tags.yml
```

Labels

```
echo x | filebeat -c $(pwd)/examples/filebeat/labels-and-tags.yml | jq .labels
```

Tags

```
echo x | filebeat -c $(pwd)/examples/filebeat/labels-and-tags.yml | jq .tags
```

### Add Host Metadata

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/add-host-metadata.html)

```
echo hello | filebeat -c $(pwd)/examples/filebeat/filebeat-processor-host.yml | jq .host
```

```
echo hello | filebeat -c $(pwd)/examples/filebeat/filebeat-processor-host.yml | jq .host.hostname
```

```
echo hello | filebeat -c $(pwd)/examples/filebeat/filebeat-processor-host.yml | jq .host.os
```

#### Drop Fields

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/drop-fields.html)

```
slu loggen | filebeat -c $(pwd)/examples/filebeat/filebeat-processor-drop-fields.yml
```

#### Drop Event

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/drop-event.html)

```
slu loggen | filebeat -c $(pwd)/examples/filebeat/filebeat-processor-drop-event.yml
```

#### Add Docker Metadata

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/add-docker-metadata.html)

```
filebeat -c $(pwd)/examples/filebeat/filebeat-processor-docker.yml -e
```

#### Add Kubernetes Metadata

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/add-kubernetes-metadata.html)

#### Dissect

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/dissect.html)

- https://dissect-tester.jorgelbg.me/ - Dissect Tester

```
echo 'xx 2023/01/12 17:42:40 WARN A warning that should be ignored is usually at this level and should be actionable. (i=1)' | filebeat -c $(pwd)/examples/filebeat/filebeat-processor-dissect-2.yml | jq .dissect
```

### Filebeat Modules

[Docs (List of Modules)](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-modules.html) | [Docs (Configure Modules)](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-modules.html)

Filebeat modules simplify the collection, parsing, and visualization of common log formats.

#### Traefik Example

```
filebeat -c $(pwd)/examples/filebeat/filebeat-module-traefik.yml -e
```

### Filebeat Autodiscovery

[Docs](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-autodiscover.html)

## Install Filebeat on Kubernetes

```
kubectl apply -f ./examples/k8s/filebeat/filebeat.yml
```

or install on cluster without ECK ES and send data to external ES

```
kubectl apply -f ./examples/k8s/filebeat/filebeat_ext.yml
```

## Install Kafka

Install Strimzi - Kafka Operator

```
kubectl create namespace kafka
```

```
kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
```

See operator's pod

```
kubectl get pod -n kafka
```

Install Kafka Cluster

```
kubectl apply -f ./examples/k8s/kafka
```

See Kafka Cluster

```
kubectl get -n kafka kafka
```

Get Bootstrap Node

```
kubectl describe -f examples/k8s/kafka | grep "Bootstrap Servers"
```

Setup `kaf` - Kafka CLI

```
BOOTSTRAP_NODE=
```

Example

```
BOOTSTRAP_NODE=134.122.89.34:32473
```

```
kaf config add-cluster $BOOTSTRAP_NODE -b $BOOTSTRAP_NODE
kaf config use-cluster $BOOTSTRAP_NODE
```

Get nodes

```
kaf nodes
```

Get topics

```
kaf topics
```

## Filebeat and Kafka

Send logs to Kafka

```
export KAFKA_NODE=
```

Example

```
export KAFKA_NODE=134.122.89.34:31031
```

or

```
export KAFKA_NODE=$BOOTSTRAP_NODE
```

Run filebeat

```
slu loggen --log-prefix loggen-kafka | filebeat -c $(pwd)/examples/filebeat/filebeat-output-kafka.yml -e
```

Describe topic logs

```
kaf topic describe logs
```

Read logs from Kafka

```
filebeat -c $(pwd)/examples/filebeat/filebeat-input-kafka.yml
```

Read only message form Kafka logs

```
filebeat -c $(pwd)/examples/filebeat/filebeat-input-kafka.yml | jq -r '.message'
```

See groups

```
kaf groups
```

describe filebeat group

```
kaf group describe filebeat
```

## Kibana

### Kibana Query Language

#### Fulltext search

```
ERROR
```

```
"and should be actionable"
```

#### Exact Match

```
agent.hostname:sika-mac
```

#### Exists

```
event.dataset:*
```

#### Wildcard

```
user_agent.os.name: Mac*
```

#### AND

```
source.address: 176.114.249.139 and http.response.status_code: 500
```

#### OR

```
http.response.status_code: 200 or http.response.status_code: 302
```

```
http.response.status_code: (200 or 302)
```

#### NOT

```
http.response.status_code:* and not http.response.status_code: (200 or 302)
```

## ESQL

- [Announcing Elastic’s piped query language, ES|QL](https://www.elastic.co/blog/esql-elasticsearch-piped-query-language) (blog post)
- [ES|QL: The Elasticsearch Query Language](https://www.elastic.co/guide/en/elasticsearch/reference/current/esql.html) (docs)
- [Getting started with ES|QL](https://www.elastic.co/guide/en/elasticsearch/reference/current/esql-getting-started.html)

```esql
FROM logs-*-*
```

```esql
FROM logs-*-* | limit 10
```

```esql
FROM logs-*-* | WHERE container.name == "traefik-traefik-1" | limit 10
```

```
FROM logs-*-* | WHERE container.name == "traefik-traefik-1" | SORT @timestamp DESC | limit 10
```

## Spaces

![](./images/spaces/spaces-1.png)

![](./images/spaces/spaces-2.png)

![](./images/spaces/spaces-3.png)

![](./images/spaces/spaces-4.png)

![](./images/spaces/spaces-5.png)

## Stream Settings (Fields)

![](./images/stream-settings-fields/stream-settings-fields-1.png)

![](./images/stream-settings-fields/stream-settings-fields-2.png)

![](./images/stream-settings-fields/stream-settings-fields-3.png)

![](./images/stream-settings-fields/stream-settings-fields-4.png)

![](./images/stream-settings-fields/stream-settings-fields-5.png)

![](./images/stream-settings-fields/stream-settings-fields-6.png)

## Discover

![](./images/discover/discover-1.png)

![](./images/discover/discover-2.png)

![](./images/discover/discover-3.png)

![](./images/discover/discover-4.png)

![](./images/discover/discover-5.png)


## Thank you! & Questions?

That's it. Do you have any questions? **Let's go for a beer!**

### Ondrej Sika

- email: <ondrej@sika.io>
- web: <https://sika.io>
- twitter: [@ondrejsika](https://twitter.com/ondrejsika)
- linkedin: [/in/ondrejsika/](https://linkedin.com/in/ondrejsika/)
- Newsletter, Slack, Facebook & Linkedin Groups: <https://join.sika.io>

_Do you like the course? Write me recommendation on Twitter (with handle `@ondrejsika`) and LinkedIn (add me [/in/ondrejsika](https://www.linkedin.com/in/ondrejsika/) and I'll send you request for recommendation). **Thanks**._

Wanna to go for a beer or do some work together? Just [book me](https://book-me.sika.io) :)

## Training Sessions

#### 2025-04-11 CEZ

- ArgoCD with ECK Example - https://github.com/sika-training-examples/2025-05-10_argocd-apps-cez-example
- ELK Terraform Example - https://github.com/sika-training-examples/2025-04-11_cez-elk-terraform-example

#### 2024-11-04

- Terraform Example - https://github.com/sika-training-examples/2024-11-05_elastic-terraform-example

#### 2024-02-21 RPC SK

- Elastic Stack managed by Terraform - https://github.com/sika-training-examples/2024-02-22-rpc-elastic-terraform-example
- Filebeat examples - https://github.com/sika-training-examples/2024-02-21-rpc-elk-examples
