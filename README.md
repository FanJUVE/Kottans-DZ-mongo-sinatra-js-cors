Kottans-DZ-mongo-sinatra-js-cors
================================

## Чтобы получать погоду с сайта на локалке:

1. Перейти в папку /from

2. Сделать bundle

3. Импортировать данные из файла zips.json в БД mongo
$ mongoimport --db mongoweather --collection weathers --type json --file zips.json --jsonArray

4. Запустить app.rb из папки /from на порту 8000 (Это важно! Так как Апп в директории /to тянет данные про погоду с адреса http://localhost:8000/todays_weather.json)
$ shotgun -p 8000 app.rb

5. В другом окне терминала перейти в папку /to

6. Сделать bundle

7. Запустить app.rb из папки /to на порту 8001 (или любом другом)
$ shotgun -p 8001 app.rb



## Чтобы получать погоду с openweather:

1. Перейти в папку /to

2. Сделать bundle

3. Обновить crontab через whenever (сейчас в файле config/schedule.rb стоит запуск скрипта на обновление cron-а раз в день в 0.00 часов)
$ whenever --update-crontab

4. Запустить app.rb из папки /to на порту 8001 (или любом другом)
$ shotgun -p 8001 app.rb