
# http://book.cakephp.org/3.0/en/quickstart.html
#
# Note: In order to test the following tasks you have to
#	brew install php56 php56-intl

help:
	@echo
	@echo "Available tasks"
	@echo "  composer           : download composer"
	@echo "  app_init           : create a demo bookmarker app"
	@echo "  db_upgrade         : create the db tables"
	@echo "  db_downgrade       : destroy the db tables"
	@echo "  db_bake            : generate the controllers, models, views, test cases, and fixtures"
	@echo "  db_show_tables     : show the table descriptions"
	@echo "  db_show_data       : show the table rows"
	@echo "  app_start          : start the php embedded server to serve the app"
	@echo "  clean              : remove all created files"


composer:
	curl -s https://getcomposer.org/installer | php

app_init:
	php composer.phar create-project --prefer-dist cakephp/app bookmarker
	cd bookmarker && php ../composer.phar install

db_upgrade:
	mysql -uroot -p < schema/000/upgrade.sql
	mysql -uroot -p < schema/001/upgrade.sql
db_downgrade:
	mysql -uroot -p < schema/001/downgrade.sql
	mysql -uroot -p < schema/000/downgrade.sql
db_show_tables:
	mysql -uroot -p -t < schema/show_tables.sql
db_show_data:
	mysql -uroot -p -t < schema/show_data.sql
db_bake:
	cd bookmarker && bin/cake bake all users
	cd bookmarker && bin/cake bake all bookmarks
	cd bookmarker && bin/cake bake all tags

app_start:
	cd bookmarker && bin/cake server &
	open http://localhost:8765/bookmarks
	# After patching: http://localhost:8765/bookmarks/tagged/cakephp/


clean:
	rm -f composer.phar
	rm -rf bookmarker/
