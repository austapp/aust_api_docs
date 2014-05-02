# Entidades

## Itens do estoque

```shell
curl "http://example.com/api/kittens"
  -H "Authorization: meowmeowmeow"
```

Text


## Entradas do estoque

```shell
curl "http://example.com/api/kittens"
  -H "Authorization: meowmeowmeow"
```

Text

## Pessoas

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get
```

```shell
curl -u "usuario:senha"
     "https://seudominio.com/api/v1/people.json"
```

> O comando acima retorna um JSON estruturado como este:

```json
[
  {
    "person": {
      "id":                     "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
      "first_name":             "Luke",
      "last_name":              "Skywalker",
      "email":                  "new_hope@gmail.com",
      "social_security_number": "14148254393",
      "home_number":            "5555-5555",
      "work_number":            "5555-5555",
      "mobile_number":          "5555-5555",
      "home_area_number":       "53",
      "work_area_number":       "53",
      "mobile_area_number":     "53",
      "receive_newsletter":     true,
      "environment":            "website",
      "enabled":                true,
      "roles":                  ["customer", "supplier"],
      "addresses": [
        {
          "address_1":    "Rua Um Dois Três",
          "address_2":    "Complemento",
          "number":       "123",
          "city":         "Porto Alegre",
          "country":      "BR",
          "default":      true,
          "state":        "RS",
          "zipcode":      "99999000",
          "neighborhood": "Centro"
        }, {
          "address_1":    "Rua Três Quatro",
          "address_2":    "Complemento",
          "number":       "123",
          "city":         "Porto Alegre",
          "country":      "BR",
          "default":      false,
          "state":        "RS",
          "zipcode":      "99999000",
          "neighborhood": "Centro"
        }
      ]
    }
  }
]
```

A API para pessoas permite seu aplicativo acessar clientes, fornecedores,
vendedores e outros. Não está incluído qualquer administrador, colaborador ou
aqueles com acesso ao painel administrativo do Aust.

### HTTP Request

`GET http://example.com/kittens`

### Query Parameters

Parameter | Default | Description
--------- | ------- | -----------
id |                     "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
include_cats | false | If set to true, the result will also include cats.
available | true | If set to false, the result will include kittens that have already been adopted.

### Resposta

Atributo                 | Tipo    | Descrição
------------------------ | ------- | -----------
id                       | String  | É um valor único para este registro.
first_name               | String  | Primeiro nome da pessoa.
last_name                | String  | Último nome da pessoa.
email                    | String  | Email
social_security_number   | String  | Número social. No Brasil, representa CPF.
home_area_number         | String  | DDD do telefone residencial.
home_number              | String  | Número do telefone residencial.
work_area_number         | String  | DDD do telefone de trabalho.
work_number              | String  | Número do telefone de trabalho.
mobile_area_number       | String  | DDD do telefone celular.
mobile_number            | String  | Número do telefone celular.
receive_newsletter       | Boolean | Indica se a pessoa deseja receber emails newsletter.
environment              | String  | Ambiente onde o usuário foi criado.
                         |         | Possíveis valores: website, admin ou point_of_sale.
enabled                  | Boolean | Indica se esta pessoa pode acessar sua conta.
roles                    | Array   | Indica o papel desta pessoa, se é cliente["customer", "supplier"],

<aside class="success">
Remember — a happy kitten is an authenticated kitten!
</aside>

## Get a Specific Kitten

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
api.kittens.get(2)
```

```shell
curl "http://example.com/api/kittens/3"
  -H "Authorization: meowmeowmeow"
```

> The above command returns JSON structured like this:

```json
{
  "id": 2,
  "name": "Isis",
  "breed": "unknown",
  "fluffiness": 5,
  "cuteness": 10
}
```

This endpoint retrieves a specific kitten.

<aside class="warning">If you're not using an administrator API key, note that some kittens will return 403 Forbidden if they are hidden for admins only.</aside>

### HTTP Request

`GET http://example.com/kittens/<ID>`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the cat to retrieve

