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

Parâmetro | Description
--------- | -----------
status    | Valores aceitos são: _pending_ para pedidos com itens pendentes, _shipped_ para os que estão despachados e _cancelled_ para aqueles que todos os itens foram cancelados
environment | Valores aceitos são: _website_ para pedidos realizados via e-commerce e _point\_of\_sale_ para os pedidos realizados via ponto de venda.
page      | A página que você deseja ver. Se não especificado, usa o valor 1.

A resposta contém:

Entidade        | Chave             | Descrição
--------------- | ----------------- | ---------
Pedidos         | `orders`          | Os pedidos requisitadas.
Pessoas         | `customers`       | Clientes de cada pedido.

### Exemplos

`GET /admin/api/v1/orders`

Retorna todos os pedidos.

`GET /admin/api/v1/orders?status=pending`

Retorna apenas pedidos que possuem alguns itens com envios pendentes.

`GET /admin/api/v1/orders?environment=point_of_sale&status=pending`

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
itens do pedidos.

A URL para realizar a requisição é a seguinte:

`POST /admin/api/v1/orders`

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Atributo       | Tipo    | Descrição
-------------- | ------- | -----------
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
environment    | String  | Local onde o pedido foi criado. Valores aceitos: _website_ para e-commerce, _point_of_sale_ para ponto de venda e _api_ para outras fontes. Se nada for especificado, usa _api_ por padrão.
customer_id\*  | String  | ID de uma pessoa que será definida como cliente do pedido.


<aside class="notice">
Não é possível alterar o ID de um registro. Se você deseja alterar itens do
pedido, veja a seção Itens do Pedido.
</aside>

Caso a requisição funcione, você receberá de volta a entidade. Caso contrário,
uma mensagem de erro.

## A entidade

Quando a entidade é retornada, estes são os atributos presentes.

Atributo           | Tipo    | Descrição
------------------ | ------- | -----------
id                 | String  | Um valor único de identificação de cada registro.
inventory_item_id  | String  | ID do item ao qual esta entrada pertence.
description        | String  | Descrição desta entrada.
quantity           | Float   | Quantidade unitária deste lote/entrada.
cost_per_unit      | Float   | Custo unitário desta entrada, ex.: 10.12
on_sale            | Boolean | Define se esta entrada está à venda. Caso seja _false_, não será posto a venda em lugar algum.
website_sale       | Boolean | Define se esta entrada está à venda via e-commerce.
point_of_sale      | Boolean | Define se esta entrada está à venda via ponto de venda.
created_at         | Date    | Data de criação do registro. Formato ISO 8601.
updated_at         | Date    | Data da última atualização do registro. Formato ISO 8601.
