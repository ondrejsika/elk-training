[sika.io](https://sika.io) | <ondrej@sika.io>

# ELK Training

    Ondrej Sika <ondrej@ondrejsika.com>
    https://github.com/ondrejsika/elk-training

## Related repositories

- Loggen - https://github.com/ondrejsika/loggen

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

## Install

## Elasticsearch & Kibana

### Using Docker

Simple single node installation for development

```
cd examples/elk/docker/elk-local
docker-compose up -d
```

## Filebeat

[Docs](https://www.elastic.co/downloads/beats/filebeat)

### Mac

```
brew install elastic/tap/filebeat-full
```

## Filebeat

### From log file

[Docs](https://www.elastic.co/guide/en/beats/filebeat/7.10/filebeat-input-log.html)

```
cd filebeat
```

Run loggen

```
loggen -log-file default.log -error -warn -info -debug
```

Run filebeat

```
filebeat -c $(pwd)/filebeat-log.yml -e
```

### From STDIN

[Docs](https://www.elastic.co/guide/en/beats/filebeat/7.10/filebeat-input-stdin.html)

Run loggen & filebeat

```
loggen -log-prefix loggen-stdout -error -warn -info -debug | filebeat -c $(pwd)/filebeat-stdin.yml -e
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
