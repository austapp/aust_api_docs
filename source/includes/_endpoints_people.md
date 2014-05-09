# Pessoas

A API para pessoas permite seu aplicativo acessar clientes, fornecedores,
vendedores e outros. Não está incluído qualquer administrador, colaborador ou
aqueles com acesso ao painel administrativo do Aust.

## Listando pessoas

```shell
curl -H "Token: $TOKEN"
     "https://seudominio.com/admin/api/v1/inventory_items.json"
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
      "created_at":             "2014-21-04T13:00:00Z",
      "updated_at":             "2014-25-05T14:00:00Z",
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

Faça a seguinte requisição HTTP:

`GET http://seudominio.com/admin/api/v1/people.json`

Estes são os possíveis parâmetros:

Parâmetro | Description
--------- | -----------
id        | Se especificado, retorna apenas a pessoa com aquele ID.
search    | Um termo que você deseja buscar. Pesquisa por nome, email e CPF/CNPJ
role      | Qual o papel do usuário. Valores aceitos são "customer" e "supplier"
page      | A página que você deseja ver. Se não especificado, usa o valor 1.

A resposta contém:

Entidade        | Chave      | Descrição
--------------- | ---------- | ---------
Pessoa          | `people`   | A pessoa requisitada.

### Exemplos

`GET /admin/api/v1/people.json?search=luke+skywalker`

Todas as pessoas que tiverem os termos `luke skywalker` no nome, email ou CPF/CNPJ serão retornadas.

## Atributos da entidade

Quando a entidade é retornada, estes são os atributos presentes.

Atributo                 | Tipo    | Descrição
------------------------ | ------- | -----------
id                       | String  | É um valor único de identificação para cada pessoa.
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
created_at               | Date    | Data de criação do registro. Formato ISO 8601.
updated_at               | Date    | Data da última atualização do registro. Formato ISO 8601.
