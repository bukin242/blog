# INSTALL

* RVM
```
$ rvm install 2.7.1
$ rvm use 2.7.1@blog --ruby-version --create
```

* bundle
```
$ bundle install
$ yarn add @rails/webpacker@next
$ rails webpacker:install
```

* Изменить файл .env, вставить свой логин, пароль от бд
```
$ rails db:create
$ rails db:migrate
```

* Запуск приложения
```
$ rails s
```