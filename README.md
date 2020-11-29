[sika.io](https://sika.io) | <ondrej@sika.io>

# ELK Training

    Ondrej Sika <ondrej@ondrejsika.com>
    https://github.com/ondrejsika/elk-training

## Related repositories

- Loggen - https://github.com/ondrejsika/loggen
- Demo ELK on Digital Ocean - https://github.com/ondrejsika/terraform-demo-elk

## Course

## About Me - Ondrej Sika

**Freelance DevOps Engineer, Consultant & Lecturer**

- Complete DevOps Pipeline
- Open Source / Linux Stack
- Cloud & On-Premise
- Technologies: Git, Gitlab, Gitlab CI, Docker, Kubernetes, Terraform, Prometheus, ELK / EFK, Rancher, Proxmox, DigitalOcean, AWS

## Star, Create Issues, Fork, and Contribute

Feel free to star this repository or fork it.

If you found bug, create issue or pull request.

Also feel free to propose improvements by creating issues.

## Live Chat

For sharing links & "secrets".

<https://tlk.io/sika-elk>

TODO: Course content

## Overview

- Elasticsearch
- Kibana
- Beats
- Logstrash

## Elasticsearch

## Kibana

## Beats

[Filebeat Overview](https://www.elastic.co/guide/en/beats/filebeat/7.x/filebeat-overview.html)

![](./images/filebeat.png)

## Logstash

## Install

## Elasticsearch & Kibana

### Using Docker

Simple single node installation for development

```
cd examples/elk/docker/elk-local
docker-compose up -d
```

### Demo ELK on Digital Ocean

Source: [ondrejsika/terraform-demo-elk](https://github.com/ondrejsika/terraform-demo-elk)

See:

- http://elk.sikademo.com:9200
- http://elk.sikademo.com:5601
- https://es.elk.sikademo.com
- https://kb.elk.sikademo.com

### Using Kubernetes

#### Elastic Cloud on Kubernetes

- Intro - https://www.elastic.co/elastic-cloud-kubernetes
- Docs / Tutorial - https://www.elastic.co/guide/en/cloud-on-k8s/current/index.html
- Github - https://github.com/elastic/cloud-on-k8s

#### Setup

```
kubectl apply -f https://download.elastic.co/downloads/eck/1.3.0/all-in-one.yaml
```

#### Install Elasticsearch & Kibana

```
kubectl apply -f ./k8s/ns-elk-single-node.yml
kubectl apply -f ./k8s/elk-single-node
```

Wait until Elasticsearch and Kibana will be GREEN

```
kubectl get -f ./k8s/elk-single-node
```

Get password for user `elastic`

```
kubectl get secret main-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo
```

See:

- https://es.k8s.sikademo.com
- https://lb.k8s.sikademo.com

## Filebeat

[Docs](https://www.elastic.co/downloads/beats/filebeat) | [Quick Start Installation](https://www.elastic.co/guide/en/beats/filebeat/7.10/filebeat-installation-configuration.html#installation)

### Mac

```
brew install elastic/tap/filebeat-full
```

### Debian

```
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.10.0-amd64.deb
sudo dpkg -i filebeat-7.10.0-amd64.deb
```

## Filebeat

### Filebear Inputs

[Docs](https://www.elastic.co/guide/en/beats/filebeat/7.10/configuration-filebeat-options.html)

- Log
- Stdin
- Container
- Docker
- Syslog

#### From file

[Docs](https://www.elastic.co/guide/en/beats/filebeat/7.10/filebeat-input-log.html)

Run loggen

```
loggen -log-file /tmp/default.log -log-prefix loggen-file
```

Run filebeat

```
filebeat -c $(pwd)/filebeat/filebeat-input-log.yml -e
```

#### From STDIN

[Docs](https://www.elastic.co/guide/en/beats/filebeat/7.10/filebeat-input-stdin.html)

Run loggen & filebeat

```
loggen -log-prefix loggen-stdin | filebeat -c $(pwd)/filebeat/filebeat-input-stdin.yml -e
```

#### From Docker

[Docs](https://www.elastic.co/guide/en/beats/filebeat/master/filebeat-input-docker.html)

Run some Docker container

```
docker run --name loggen -d ondrejsika/loggen
docker run --name loop -d ondrejsika/infinite-counter
```

```
filebeat -c $(pwd)/filebeat/filebeat-input-docker.yml -e
```

#### From Container

[Docs](https://www.elastic.co/guide/en/beats/filebeat/master/filebeat-input-container.html)

(similar to Docker)

```
filebeat -c $(pwd)/filebeat/filebeat-input-container.yml -e
```

### Filebeat Outputs

- Elasticsearch
- Logstash
- File
- Console

#### File

[Docs](https://www.elastic.co/guide/en/beats/filebeat/7.10/console-output.html)

```
loggen | filebeat -c $(pwd)/filebeat/filebeat-output-file.yml -e
```

#### Console

[Docs](https://www.elastic.co/guide/en/beats/filebeat/7.10/console-output.html)

```
loggen | filebeat -c $(pwd)/filebeat/filebeat-output-console.yml -e
```

### Multiline Log Messages

[Docs](https://www.elastic.co/guide/en/beats/filebeat/7.10/multiline-examples.html)

#### Python Traceback Example

```
cat log-examples/multiline-python.txt | filebeat -c $(pwd)/filebeat/filebeat-multiline-python.yml -e
```

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
