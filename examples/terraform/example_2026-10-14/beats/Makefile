filebeat-my-app:
	slu loggen --json --log-prefix my-app-json | \
		filebeat -e -c $(shell pwd)/my_app.yml \
			--path.data $(shell pwd)/.tmp/my_app \
			--path.home $(shell pwd)/.tmp/my_app \
			--path.logs $(shell pwd)/.tmp/my_app

filebeat-my-app-text:
	slu loggen --log-prefix my-app-text | \
		filebeat -e -c $(shell pwd)/my_app.yml \
			--path.data $(shell pwd)/.tmp/my_app \
			--path.home $(shell pwd)/.tmp/my_app \
			--path.logs $(shell pwd)/.tmp/my_app
