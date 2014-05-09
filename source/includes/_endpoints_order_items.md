# Itens de Pedido

Um pedido possui muitos itens. Cada item nada mais é que uma referência
a uma mercadoria.

Por exemplo, um pedido tem 2 itens, um enviado e o outro cancelado. Cada
item possui um preço separadamente. O pedido apenas agrupa os itens sob uma
mesma entidade.

Através desta API você pode gerenciar os itens de um pedido existente. É aqui
que você pode alterar o status de um item.

## Lendo itens de um pedido

```shell
{
  "order_items": [{
    "id":                 "24b26e45-2fec-3f2c-86dd-6afe36a0dbd2",
    "price":              18.0,
    "quantity":           10.0,
    "status":             "pending",
    "order_id":           "72b87e72-3fec-3f6c-27dd-3afe36a0dbd2",
    "inventory_item_id":  "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
    "inventory_entry_id": "63f79e72-2fec-3f6c-57dd-6afe36a0dbd2",
    "created_at":         "2014-21-04T13:00:00Z",
    "updated_at":         "2014-25-05T14:00:00Z"
  }],
  "orders": [{
    "id":          "72b87e72-3fec-3f6c-27dd-3afe36a0dbd2",
    "total":       180.0,
    "environment": "point_of_sale",
    "customer_id": "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
    "order_item_ids": [
      "24b26e45-2fec-3f2c-86dd-6afe36a0dbd2"
    ],
    "created_at":  "2014-21-04T13:00:00Z",
    "updated_at":  "2014-25-05T14:00:00Z"
  }],
  "inventory_items": [{
    "id":               "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
    "name":             "Air Max",
    "description":      "Tênis de corrida Air Max",
    "year":             "2011",
    "price":            179.90,
    "on_sale":          true,
    "barcode":          "5555-5555",
    "reference_number": "seu_numero_personalizado",
    "manufacturer_id":  "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
    "taxonomy_id":      "83216e35-3fec-1d2c-37dd-6afe36a0dbd2",
    "created_at":       "2014-21-04T13:00:00Z",
    "updated_at":       "2014-25-05T14:00:00Z"
  }]
}
```


`GET /admin/api/v1/orders/<ID_DO_PEDIDO>/items`

Esta requisição retornará o exemplo ao lado. A resposta possui uma
array de Itens do pedido (order_items) e das demais entidades relacionadas.

A resposta contém:

Entidade        | Chave             | Descrição
--------------- | ----------------- | ---------
Itens do Pedido | `order_items`     | Todos os itens do pedido requisitado.
Pedido          | `order`           | O pedido relacionado.
Items do Estoque | `inventory_items` | Os itens do estoque de cada item do pedido.
Entradas do Estoque | `inventory_entries`  | As entradas do estoque de cada item do pedido.

### Quando requisitar um pedido?

Para ver detalhes de um pedido.

Quando você requisita um pedido, você recebe apenas a listagem dos seus
itens, sem muitos detalhes, e outras informações daquele pedido, como
o comprador.

### Quando requisitar itens de um pedido?

Para ver detalhes sobre os itens do pedido.

Requisitando itens de um pedido, você recebe informações mais detalhadas
sobre os Itens em si, como o Item do Estoque relacionado, semelhante ao
exemplo ao lado.

<aside class="notice">
  [Veja como ler um pedido](#lendo-um-pedido-específico).
</aside>

## Lendo um item específico

```shell
{
  "order_item": {
    "id":                 "24b26e45-2fec-3f2c-86dd-6afe36a0dbd2",
    "price":              18.0,
    "quantity":           10.0,
    "status":             "pending",
    "order_id":           "72b87e72-3fec-3f6c-27dd-3afe36a0dbd2",
    "inventory_item_id":  "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
    "inventory_entry_id": "63f79e72-2fec-3f6c-57dd-6afe36a0dbd2",
    "created_at":         "2014-21-04T13:00:00Z",
    "updated_at":         "2014-25-05T14:00:00Z"
  },
  "orders": [{
    "id":          "72b87e72-3fec-3f6c-27dd-3afe36a0dbd2",
    "total":       180.0,
    "environment": "point_of_sale",
    "customer_id": "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
    "order_item_ids": [
      "24b26e45-2fec-3f2c-86dd-6afe36a0dbd2"
    ],
    "created_at":  "2014-21-04T13:00:00Z",
    "updated_at":  "2014-25-05T14:00:00Z"
  }],
  "inventory_items": [{
    "id":               "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
    "name":             "Air Max",
    "description":      "Tênis de corrida Air Max",
    "year":             "2011",
    "price":            179.90,
    "on_sale":          true,
    "barcode":          "5555-5555",
    "reference_number": "seu_numero_personalizado",
    "manufacturer_id":  "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
    "taxonomy_id":      "83216e35-3fec-1d2c-37dd-6afe36a0dbd2",
    "created_at":       "2014-21-04T13:00:00Z",
    "updated_at":       "2014-25-05T14:00:00Z"
  }]
}
```

`GET /admin/api/v1/orders/<ID_DO_PEDIDO>/items/<ID_DO_ITEM>`

Como um item pertence a um pedido em particular, você deve
especificar o ID do pedido e item que você deseja ver.

A resposta contém:

Entidade        | Chave             | Descrição
--------------- | ----------------- | ---------
Item do Pedido  | `order_item`      | I item do pedido requisitado.
Pedido          | `orders`          | Contém o pedido relacionado.
Item do Estoque | `inventory_items` | O item do estoque relacionado.
Entrada do Estoque | `inventory_entries`  | A entrada do estoque relacionada.

### Exemplos

`GET /admin/api/v1/orders/1/items/2`

Retornará apenas o item com ID 2 que pertence ao pedido com ID 1.

<aside class="notice">
  Note como métodos que retornam um registro apenas tem a entidade em singular.
  No exemplo, `order_item`. Na listagem de vários registros, a entidade é
  `order_items`.
</aside>

## Criando um item em um pedido

A URL para realizar a requisição é a seguinte:

`POST /admin/api/v1/orders/<ID_DO_PEDIDO/items`

<aside class="notice">
Para criar um item em um pedido, este pedido já deve existir previamente.
[Veja como criar um pedido](#criando-um-pedido).
</aside>

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Atributo             | Tipo   | Descrição
-------------------- | ------ | -----------
id                   | String | ID do registro. Opcional. Se você não especificar, nós o faremos automaticamente.
price                | Float  | Preço unitário do item, ex.: `18.0`. Se não especificado, vamos usar o valor atual do produto. Recomendamos fortemente você definir este valor para que o cobrado seja exatamente o que foi prometido ao cliente.
quantity\*           | Float  | Quantidade deste item, ex.: `10.0`
status               | String | Valores aceitos são: _pending_ para item com situação pendente, _shipped_ se o item foi despachado e _cancelled_ se o item foi cancelado neste pedido. Caso não seja especificado, o definiremos como pendente automaticamente.
inventory_item_id\*  | String | ID do item do estoque correspondente.
inventory_entry_id   | String | ID da entrada do item de estoque a ser associada a este item. Caso não especificado, nós definiremos a entrada disponível.
created_at           | Date   | Data de criação do registro no formato ISO 8601. Se não especificado, nós o faremos automaticamente.

Em caso de sucesso, você receberá de volta a entidade criada. Caso contrário,
uma mensagem de erro.

## Atualizando um item de pedido

`PUT /admin/api/v1/orders/<ID_DO_PEDIDO>/items/<ID_DO_ITEM>`

Você deve substituir `<ID_DO_PEDIDO>` pelo ID único do pedido ao qual o item
pertence.

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Atributo   | Tipo   | Descrição
---------- | ------ | -----------
price      | Float  | Preço unitário do item, ex.: `18.0`. Se não especificado, vamos usar o valor atual do produto. Recomendamos fortemente você definir este valor para que o cobrado seja exatamente o que foi prometido ao cliente.
quantity   | Float  | Quantidade deste item, ex.: `10.0`
status     | String | Valores aceitos são: _pending_ para item com situação pendente, _shipped_ se o item foi despachado e _cancelled_ se o item foi cancelado neste pedido. Caso não seja especificado, o definiremos como pendente automaticamente.

<aside class="notice">
Não é possível alterar o ID de um registro nem o item do estoque correspondente.
Se precisar fazer isto, exclua o item e crie-o novamente.
</aside>

Caso a requisição funcione, você receberá de volta a entidade. Caso contrário,
uma mensagem de erro.

## Excluindo um item do pedido

`DELETE /admin/api/v1/orders/<ID_DO_PEDIDO>/items/<ID_DO_ITEM>`

Em caso de sucesso, você vai receber o código HTTP 200. Você não receberá a
entidade como resposta porque ela não existe mais.

## A entidade

Quando a entidade é retornada, estes são os atributos presentes.

Atributo           | Tipo    | Descrição
------------------ | ------- | -----------
id                 | String  | Um valor único de identificação de cada registro.
price              | Float   | Preço unitário do item.
quantity           | Float   | Quantidade unitária deste item no pedido.
status             | String  | Situação do item. Valores aceitos são: _pending_ para item com situação pendente, _shipped_ se o item foi despachado e _cancelled_ se o item foi cancelado neste pedido.
order_id           | Float   | ID do pedido ao qual este item pertence.
inventory_item_id  | String  | ID do item do estoque ao qual este item está associado.
inventory_entry_id | String  | ID da entrada/lote do estoque ao qual este item está associado.
created_at         | Date    | Data de criação do registro. Formato ISO 8601.
updated_at         | Date    | Data da última atualização do registro. Formato ISO 8601.
