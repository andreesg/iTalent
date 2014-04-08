# iTalent Project

No âmbito da cadeira de Gestão de Projectos de Software do Departamento de Informática da FCTUC.

## Ruby and Rails version

Ruby 2.0.0
Ruby on Rails 4.0.4

## System dependencies

The lists bellow show the most important gems used. For the complete list browse the project `Gemfile`.

### Runtime

* [PostgreSQL](https://bitbucket.org/ged/ruby-pg/wiki/Home): As the database;
* [Bootstrap](https://github.com/twbs/bootstrap-sass): As framework for css styling;
* [Devise](https://github.com/plataformatec/devise): For user authentication.

### Development and Testing

* [RSPEC](https://github.com/rspec/rspec-rails): As the main testing framework;
* [FactoryGirl](https://github.com/thoughtbot/factory_girl): To generate models with ease while testing;
* [Guard](https://github.com/guard/guard-rspec): To automate the testing cicle;
* [Spork](https://github.com/sporkrb/spork-rails): To pre-load the rails testing environment and speed up the testing cicle;
* [Capybara](https://github.com/jnicklas/capybara): To mimic the user action on the browser for tests.

## Configurations

### Environment

First be sure that you have your environment set (see ruby and rails versions above) and that you have postgress installed on your system.
Run the bundler to install the needed gems:
```console
bundle install
bundle update
```

### Database

Ensure that you have created an user in postgreSQL with the proper name, password and previlege to create new databases (view the file `config/database.yml` for the user name and password).
Finaly create the development and test database:
```console
rake db:migrate
rake db:test:prepare
```

## How to run the test suite

Since the testing suite is automated with guard you can simply activate guard and press enter to run all tests:
```console
guard
```
Or you can run rspec manualy:
```console
rake spec
```

## Services (job queues, cache servers, search engines, etc.)

## Deployment instructions

