ENV['ELASTICSEARCH_URL'] = Figaro.env.aws_elastic_search_url

Searchkick.aws_credentials = {
  access_key_id: Figaro.env.aws_key_id,
  secret_access_key: Figaro.env.aws_secret_id,
  region: Figaro.env.aws_search_kick_region
}
