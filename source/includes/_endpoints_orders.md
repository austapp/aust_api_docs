# Pedidos

Pedidos são compras realizadas através do site e-commerce ou através do ponto
de venda. Cada pedido é composto por vários itens. São estes itens que recebem
um _status_ de enviado, pendente ou cancelado.

Por exemplo, um pedido tem 2 itens, um enviado e o outro cancelado. Cada
item possui um preço separadamente. O pedido apenas agrupa os itens sob uma
mesma entidade.

Através desta API você pode gerenciar os pedidos realizados através da
loja virtual ou do ponto de venda. Você pode ver detalhes, criar novos pedidos
e definir seu status.

<aside class="notice">
Para ler informações específicas sobre Itens do Pedido, veja seção
correspondente abaixo.
</aside>

## Listando pedidos

> Veja todos os pedidos existentes no endereço abaixo:

```shell
curl -H "Token: $TOKEN"
     "https://seudominio.com/admin/api/v1/orders"
```

> O comando acima retorna um JSON estruturado como este:

```json
{
  "orders": [{
    "id":               "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
    "total":            180.5,
    "environment":      "point_of_sale",
    "approved":         true,
    "customer_id":      "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
    "order_item_ids": [
      "24b26e45-2fec-3f2c-86dd-6afe36a0dbd2"
    ],
    "created_at":       "2014-21-04T13:00:00Z",
    "updated_at":       "2014-25-05T14:00:00Z"
  }],
  "customers": [{
    "id":   "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
    "name": "Tony Montana"
  }]
}
```

`GET /admin/api/v1/orders`

Estes são os possíveis parâmetros:

Parâmetro | Descrição
--------- | -----------
items_status | Busca pedidos considerando seus itens. Valores aceitos são: _pending_ para pedidos que possuem itens com envio pendentes; _shipped_ para os que estão despachados; e _cancelled_ para aqueles que todos os itens foram cancelados. <br /><br />Aceita `Array`, exemplo: <br />`?items_status=pending` ou <br />`?items_status[]=pending&items_status[]=shipped`
approved  | Se o pedido foi aprovado por administradores e deduziu itens do estoque. Valores aceitos são `1` para aprovados e `0` (zero) para não aprovados. Veja os exemplos.<br /><br />Para buscar pedidos com _aprovação pendente_, use o valor `pending`.<br /><br />Pedidos não aprovados também são conhecidos como _Pedidos Não Empenhados_.
environment | Local onde o pedido foi criado. Valores aceitos: _website_ para e-commerce, _point_of_sale_ para ponto de venda e _api_ para outras fontes. Se nada for especificado, usa _api_ por padrão.
page      | A página que você deseja ver. Se não especificado, usa o valor 1.

A resposta contém:

Entidade        | Chave             | Descrição
--------------- | ----------------- | ---------
Pedidos         | `orders`          | Os pedidos requisitadas.
Pessoas         | `customers`       | Clientes de cada pedido.

### Exemplos

`GET /admin/api/v1/orders`

Retorna todos os pedidos.

`GET /admin/api/v1/orders?items_status=pending`

Retorna apenas pedidos que possuem alguns itens com envios pendentes.

`GET /admin/api/v1/orders?items_status[]=pending&items_status[]=shipped`

Retorna pedidos que possuam alguns itens pendentes e outros enviados.

`GET /admin/api/v1/orders?approved=pending`

Retorna apenas pedidos que estão aguardando aprovação de um administrador.
Isto significa que não foram subtraídas quantidades de itens do estoque.

`GET /admin/api/v1/orders?approved=0`

Retorna apenas pedidos que não foram aprovados por administradores.
Também conhecido como Pedidos Não Empenhados.

`GET /admin/api/v1/orders?environment=point_of_sale&items_status=pending`

Retorna apenas pedidos realizados através do ponto de venda e que tenha algum
item pendente.

## Lendo um pedido específico

> Quando você cria, atualiza ou lê um pedido específico, os seus itens são retornados na mesma requisição.

```json
{
  "orders": [{
    "id":          "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
    "total":       180.0,
    "environment": "point_of_sale",
    "approved":    true,
    "customer_id": "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
    "order_item_ids": [
      "24b26e45-2fec-3f2c-86dd-6afe36a0dbd2"
    ],
    "created_at":  "2014-21-04T13:00:00Z",
    "updated_at":  "2014-25-05T14:00:00Z"
  }],
  "order_items": [{
    "id":                 "24b26e45-2fec-3f2c-86dd-6afe36a0dbd2",
    "price":              18.0,
    "quantity":           10.0,
    "status":             "pending",
    "order_id":           "72b87e72-3fec-3f6c-27dd-3afe36a0dbd2",
    "inventory_item_id":  "32c38e72-1fec-3f6c-37dd-4afe36a0dbd2",
    "inventory_entry_id": "63f79e72-2fec-3f6c-57dd-6afe36a0dbd2",
    "created_at":         "2014-21-04T13:00:00Z",
    "updated_at":         "2014-25-05T14:00:00Z"
  }],
  "customers": [{
    "id":         "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
    "first_name": "Tony",
    "last_name":  "Montana",
    "email":      "tony@montana.com",
    "social_security_number":  "12312312312"
  }]
}
```
`GET /admin/api/v1/orders/<ID_DO_PEDIDO>`

O único parâmetro possível é o ID do pedido.

A resposta contém:

Entidade        | Chave            | Descrição
--------------- | ---------------- | ---------
Pedido          | `order`          | O pedido requisitado.
Itens do Pedido | `order_items`    | Todos os itens do pedido requisitado.
Pessoa          | `customers`      | O cliente do pedido.

### Exemplos

`GET /admin/api/v1/orders/2`

Retorna apenas o pedido com ID 2.

<aside class="notice">
Este método retorna também os itens do pedido (veja exemplo ao lado).
</aside>

## Criando um pedido

Para criar um pedido, você deve especificar na mesma requisição quais os
itens do pedido.

A URL para realizar a requisição é a seguinte:

`POST /admin/api/v1/orders`

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Atributo       | Tipo    | Descrição
-------------- | ------- | -----------
approved       | Boolean | Define se o pedido deve ser criado como aprovado. Valores aceitos: _true_ se o pedido já foi aprovado, o que subtrairá itens do estoque imediatamente.<br /><br />Deixe em branco caso esteja pendente de aprovação dos administradores, o que significa que não abateu itens do estoque ainda.<br /><br /> Defina _false_ caso o pedido deva ser criado como não aprovado (também conhecido como Pedido Não Empenhado).
environment    | String  | Local onde o pedido foi criado. Valores aceitos: _website_ para e-commerce, _point_of_sale_ para ponto de venda e _api_ para outras fontes. Se nada for especificado, usa _api_ por padrão.
customer_id\*  | String  | ID de uma pessoa que será definida como cliente do pedido.
order_items\*  | Entidade | Entidade _Itens de Pedido_.
created_at           | Date   | Data de criação do registro no formato ISO 8601. Se não especificado, nós a definiremos automaticamente.

Em caso de sucesso, você receberá de volta a entidade criada. Caso contrário,
uma mensagem de erro.

<aside class="notice">
Para ver a entidade _Itens do Pedido_ e saber quais atributos são aceitos, veja a
seção Itens do Pedido.
</aside>

## Atualizando um pedido

`PUT /admin/api/v1/orders/<ID_DO_PEDIDO>`

Você deve substituir `<ID_DO_PEDIDO>` pelo ID único do pedido.

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Atributo       | Tipo    | Descrição
-------------- | ------- | -----------
approved       | Boolean | Define se o pedido está aprovado ou não. Valores aceitos: _true_ se o pedido já foi aprovado, o que subtrairá itens do estoque imediatamente.<br /><br />Defina _false_ caso o pedido tenha sido desaprovado (também conhecido como Pedido Não Empenhado).<br /><br />Caso ele já esteja aprovado, você não pode alterá-lo para desaprovado, e vice-versa.

<aside class="notice">
Não é possível alterar o ID de um registro. Se você deseja alterar itens do
pedido, veja a seção Itens do Pedido.
</aside>

Caso a requisição funcione, você receberá de volta a entidade. Caso contrário,
uma mensagem de erro.

## A entidade

Quando a entidade é retornada, estes são os atributos presentes.

Atributo         | Tipo   | Descrição
---------------- | ------ | -----------
id               | String | Um valor único de identificação de cada registro.
total            | Float  | Valor total do pedido, somando todos os itens (exceto os cancelados).
environment      | String | Local onde o pedido foi criado. Valores possíveis: _website_ se o pedido foi feito via e-commerce, _point_of_sale_ para ponto de venda do Aust e _api_ para outras fontes (ex.: via ERP).
customer_id      | String  | ID único do cliente final/consumidor que realizou o pedido.
order_item_ids   | Array  | Retorna os IDs de todos os itens do pedido.
approved         | Boolean | Define quanto à aprovação do pedido. Possíveis valores: _true_ se o pedido já foi aprovado, o que subtrairá itens do estoque imediatamente.<br /><br />_Null_ (nulo, nada) caso esteja pendente de aprovação dos administradores, o que significa que não abateu itens do estoque ainda.<br /><br /> Valor _false_ caso o pedido tenha sido desaprovado (também conhecido como Pedido Não Empenhado).
created_at       | Date   | Data de criação do registro. Formato ISO 8601.
updated_at       | Date   | Data da última atualização do registro. Formato ISO 8601.
