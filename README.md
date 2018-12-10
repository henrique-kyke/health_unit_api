# Health Unit API

This is a simple API that returns a UBS (Unidades Básicas de Saúde) list based on a given location (latitude and longitude). It can also import UBSs froma a CSV, through a rake task.

To see a running sample use this [link](http://health-unit-lb-442422093.us-east-1.elb.amazonaws.com/api/v1/find_ubs?query=-23.471405,-46.647994)


### Technologies
Health Unit API uses the following technologies:

#### Commons
- Ruby >= 2.5.0
- Rails 5.2.0
- Mongoid (Mongo DB)
- Searchkick (ElasticSearch)

#### Development and test environments
- Thin
- MongoDB
- ElasticSearch
- RSpec (only to test)

#### Production environment
- Unicorn

The [sample link](http://health-unit-lb-442422093.us-east-1.elb.amazonaws.com/api/v1/find_ubs?query=-23.471405,-46.647994) is runing on AWS using following resources:

- Docker and Docker Compose
- AWS Elastic Container Service (Fargate)
- MongoDB Atlas
- AWS ElasticSearch Service
- AWS Elastic Load Balancer


### Model
Health Unit API has one model as MongoDB Document:

### health_units

type | name
----- | ------
string | name
string | address
string | city
float | latitude
float | longitude
string | phone
string | size
string | adaptation\_for\_seniors
string | medical_equipment
string | medicine
datetime | created_at
datetime | updated_at

### Clone
You can clone this project from this [Github repo](https://github.com/henrique-kyke/health_unit_api)

### Config
You need have MongoDB and ElasticSearch previouslly installed adn running. Then configure _config/mongoid.yml_, _application.yml_ with your desired environment settings.

To set up dependencies, in project folder, run:
```shell
$ bundle install
```

### Import UBSs from ubs.csv
It's easy to import `ubs.csv` (included in this project for practicality). You need run:
```shell
$ rails ubs:import
```
Or
```shell
$ rails ubs:import RAILS_ENV=< desired environment >
```

### Run
Once UBS base is dumped, to execute a standalone thin, run:
```shell
$ rails s
```
To test in your browser or preferred client tool, see next item.

### Route
Health Unit API has only a valid route. This route return UBSs ordered from closest to farthest UBS

#### Endpoint*
```ruby
GET '/api/v1/find_ubs'
```
Sample: _//api/v1/find\_ubs?query=-6.57,-35.107&page=1&per_page=10_

\* _Requires parameter. See below:_
#### Parameters
parameter | description | sample | required
------ | ------ | ------ |------
query | a lat/long comma splited from where search calculate proximity | -6.57,-35.107 | true
page | number of desired page (defaut = 1 if param omitted)| 5 | false
per_page | quantity of entries to be show per page (defaut = 10 if param omitted)| 20 | false

#### Response 200 (application/json)
```json
{
    "current_page": 1,
    "per_page": 10,
    "total_entries": 19,
    "entries": [{
        "id": "5c0db2f706518421a78b31f4",
        "name": "UNIDADE BASICA DE SAUDE JOSE BIBI",
        "address": "POVOADO SAO JOAQUIM DOS MELOS",
        "city": "Tuntum",
        "phone": "9935225071",
        "geocode": {
            "lat": -5.89795231819136,
            "lon": -44.8160004615771
        },
        "scores": {
            "size": 1,
            "adaptation_for_seniors": 1,
            "medical_equipment": 1,
            "medicine": 1
        }
    }, {
        "id": "5c0db2e706518421a78b31ec",
        "name": "US OSWALDO DE SOUZA",
        "address": "TV ADALTO BOTELHO",
        "city": "Aracaju",
        "phone": "7931791326",
        "geocode": {
            "lat": -10.9112370014188,
            "lon": -37.0620775222768
        },
        "scores": {
            "size": 2,
            "adaptation_for_seniors": 3,
            "medical_equipment": 1,
            "medicine": 2
        }
    }, {
        "id": "5c0db2f106518421a78b31ef",
        "name": "POSTO DE SAUDE DE BOM JESUS DA ALDEIA",
        "address": "RUA TEOFILO OTONI",
        "city": "Jequitinhonha",
        "phone": "3337411423",
        "geocode": {
            "lat": -16.447874307632,
            "lon": -41.0098600387561
        },
        "scores": {
            "size": 1,
            "adaptation_for_seniors": 2,
            "medical_equipment": 1,
            "medicine": 1
        }
    }, {...}
  ]
}
```

#### Response 406 (application/json)
If query not supplied
```json
{
    "error": {
        "message": "precisa ser informada",
        "full_message": "query precisa ser informada ",
        "field": "query"
    }
}
```

### Test
To execute tests, on project folder run:
```shell
$ rspec spec
```
### Deployment
This project was deployed on AWS ECS Fargate with `docker-compose`, `aws-cli` and `ecs-cli`, previouslly setted up with AWS credentials. Also it was created a cluster, repository for docker container, VPC, subnets, Application Load Balancer and target groups on AWS.

Before push the container it's necessary to set `docker-compose.yml` and `ecs-params.yml` with AWS required params

Once all this stuffs be made it's time to deploy. To make it easier, the basic commands to deploy are included on `docker-push.sh`. It:

- sets your AWS credentials to default cluster config
- builds, tags and pushes container image to AWS Docker repostory
- creates task definitions and update service in the cluster with zero downtime

To execute delpoy, run:
```shell
$ ./docker-push.sh
```
The above stages will be logged and service status will be shown.



