# Entradas do estoque

```shell
curl -H "Token: $TOKEN"
     "https://dominio.com/admin/api/v1/inventory_items/<ID_DO_ITEM>/entries"
```

> O comando acima retorna um JSON estruturado como este:

```json
[
  {
    "inventory_entries": {
      "id":                "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
      "inventory_item_id": "28b69e24-4fec-2f1c-63dd-6afe36a0dbd2",
      "description":       "Entrada no estoque com grande desconto",
      "quantity":          15.0,
      "cost_per_unit":     150.0,
      "on_sale":           true,
      "website_sale":      true,
      "point_of_sale":     true,
      "created_at":        "2014-21-04T13:00:00Z",
      "updated_at":        "2014-25-05T14:00:00Z"
    }
  }
]
```

Cada item do estoque possui várias **entradas**. Uma entrada é um lote
comprado e representa uma determinada quantidade física.

Por exemplo, o item Tênis Air Max (_item do estoque_) possui dois lotes
(_entrada do estoque_), um comprado no dia 21/04 e outro no dia 21/05.
O primeiro lote possui uma quantidade de 15 unidades e o segundo 35 unidades.

A API para entradas do estoque permite seu aplicativo acessar e gerenciar
todos estes
registros. Você pode listar, criar e editar entradas.

Lembre-se que uma entrada no estoque está sempre associada a um item do
estoque.

<aside class="notice">
  Esta URL serve apenas para acessar Entradas do Estoque. Veja Itens do
  Estoque mais acima caso desejado.
</aside>

No exemplo ao lado, a entidade possui o atributo `inventory_item_id`, o qual é
o ID do item ao qual a entrada pertence.

## Listando entradas

`GET /admin/api/v1/inventory_items/<ID_DO_ITEM>/entries`

Como uma entrada pertence a um item do estoque em particular, você deve
especificar o ID do item que você deseja ver as entradas.

Estes são os possíveis parâmetros:

Parâmetro | Description
--------- | -----------
on_sale   | Especifique 1 se você quer apenas entradas à venda, 0 (zero) para entradas não à venda.
page      | A página que você deseja ver. Se não especificado, usa o valor 1.

### Exemplos

`GET /admin/api/v1/inventory_items/2/entries`

Retornará todas as entradas do item 2.

`GET /admin/api/v1/inventory_items/2/entries?on_sale=1`

Retornará apenas entradas disponíveis à venda.

## Lendo uma entrada específica

`GET /admin/api/v1/inventory_items/<ID_DO_ITEM>/entries/<ID_DA_ENTRADA>`

Como uma entrada pertence a um item do estoque em particular, você deve
especificar o ID do item que você deseja ver as entradas.

Não há parâmetros disponíveis.

### Exemplos

`GET /admin/api/v1/inventory_items/1/entries/2`

Retornará apenas a entrada com ID 2 que pertence ao item com ID 1.

## Criando entradas

`POST /admin/api/v1/inventory_items/2/entries`

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Atributo       | Tipo    | Descrição
-------------- | ------- | -----------
description    | String  | Descrição do item do estoque.
quantity\*     | Float   | Quantidade unitária desta entrada.
cost_per_unit\*| Float   | Custo por item, em R$, ex.: 10.12
on_sale\*      | Boolean | _true_ se estiver à venda, _false_ caso contrário
website_sale\* | Boolean | _true_ para disponibilizar à venda no e-commerce, _false_ caso contrário
point_of_sale\*| Boolean | _true_ para disponibilizar à venda no ponto de venda, _false_ caso contrário

Em caso de sucesso, você receberá de volta a entidade criada. Caso contrário,
uma mensagem de erro.

## Atualizando uma entrada

`PUT /admin/api/v1/inventory_items/<ID_DO_ITEM>/entries/<ID_DA_ENTRADA>`

Você deve substituir `<ID_DA_ENTRADA>` pelo ID único da entrada.

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Atributo       | Tipo    | Descrição
-------------- | ------- | -----------
description    | String  | Descrição do item do estoque.
quantity\*     | Float   | Quantidade unitária desta entrada.
cost_per_unit\*| Float   | Custo por item, em R$, ex.: 10.12
on_sale\*      | Boolean | _true_ se estiver à venda, _false_ caso contrário
website_sale\* | Boolean | _true_ para disponibilizar à venda no e-commerce, _false_ caso contrário
point_of_sale\*| Boolean | _true_ para disponibilizar à venda no ponto de venda, _false_ caso contrário

<aside class="notice">
Não é possível alterar o ID de um registro.
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
