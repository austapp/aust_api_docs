# Itens do estoque

```shell
curl -H "Token: $TOKEN"
     "https://seudominio.com/admin/api/v1/inventory_items"
```

> O comando acima retorna um JSON estruturado como este:

```json
[
  {
    "inventory_items": {
      "id":               "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
      "name":             "Air Max",
      "description":      "Tênis de corrida Air Max",
      "year":             "2011",
      "price":            179.90,
      "on_sale":          true,
      "barcode":          "5555-5555",
      "reference_number": "seu_numero_personalizado",
      "created_at":       "2014-21-04T13:00:00Z",
      "updated_at":       "2014-25-05T14:00:00Z",
      "manufacturer": {
        "id":   "72188e72-1fec-3f6c-37dd-6afe36a0dbd2",
        "name": "Nike"
      },
      "taxonomy": {
        "id":   "83216e35-3fec-1d2c-37dd-6afe36a0dbd2",
        "name": "Tênis"
      }
    }
  }
]
```

> Cada requisição, seja de listagem, criação ou atualização, retorna a entidade como descrita acima.

A API para itens do estoque permite seu aplicativo acessar todos os registros.
Você pode listar, criar e editar itens.

No Aust, um Item do Estoque representa uma mercadoria
independente de quantidade ou aspectos físicos, apenas o conceito.

A entidade que representa a mercadoria fisicamente chama-se Entrada do Estoque.
Um Item possui muitas Entradas no estoque. Pense numa Entrada como um lote
de uma mercadoria. Cada Entrada possui um quantidade e um custo unitário.

<aside class="notice">
  Esta URL serve apenas para acessar Itens do Estoque. Veja Entradas do
  Estoque mais abaixo.
</aside>

## Listando itens

`GET /admin/api/v1/inventory_items`

Estes são os possíveis parâmetros:

Parâmetro | Description
--------- | -----------
id        | Se especificado, retorna apenas o registro com ID correspondente.
search    | Um termo que você deseja buscar. Pesquisa por nome, descrição, código de barras, número de referência, nome do fabricante, nome da categoria.
on_sale   | Especifique 1 se você quer apenas itens a venda, 0 (zero) para itens não à venda.
page      | A página que você deseja ver. Se não especificado, usa o valor 1.

### Exemplos

`GET /admin/api/v1/inventory_items?on_sale=1`

Retornará apenas itens à venda.

`GET /admin/api/v1/inventory_items?search=nike`

Retornará apenas itens que contenham a palavra chave `nike`.

## Lendo um item específico

`GET /admin/api/v1/inventory_items/<ID_DO_ITEM>`

Você deve especificar o ID do item que você deseja ver.

Não há parâmetros disponíveis.

### Exemplos

`GET /admin/api/v1/inventory_items/3`

Retornará apenas o item que tem o ID 3


## Criando itens

`POST /admin/api/v1/inventory_items`

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Atributo | Tipo | Descrição
--------- | ----------- | -----------
name\*             | String  | Nome/modelo do item do estoque.
description      | String  | Descrição do item do estoque.
year             | String  | Ano de fabricação do item, ex.: "1994"
price\*            | Float   | Preço do item, ex.: 10.12
on_sale          | Boolean | _true_ se estiver à venda, _false_ caso contrário
barcode          | String  | Código de barras do produto.
reference_number | String  | Número de referência personalizado. Se você possui uma identificação própria, você pode usá-la aqui.
manufacturer_id\*  | String  | ID único do fabricante do item. Obrigatório apenas se você não especificar um nome para o fabricante.
manufacturer_name\* | String | Caso queira criar um novo fabricante, deixe seu ID em branco e especifique uma string aqui. Caso o nome já exista, o fabricante anterior será utilizado. Obrigatório apenas se você não especificar um ID.
taxonomy_id\*      | String  | ID único da categoria à qual este registro pertencerá.

Em caso de sucesso, você receberá de volta a entidade criada. Caso contrário,
uma mensagem de erro.

## Atualizando itens

`PUT /admin/api/v1/inventory_items/<ID_DO_ITEM>`

Você deve substituir `<ID_DO_ITEM>` pelo ID único do registro que você quer
atualizar.

Estes são os possíveis atributos (os obrigatórios possuem um asterísco \*):

Parâmetro | Tipo | Descrição
--------- | ----------- | -----------
name\*             | String  | Nome/modelo do item do estoque.
description      | String  | Descrição do item do estoque.
year             | String  | Ano de fabricação do item, ex.: "1994"
price\*            | Float   | Preço do item, ex.: 10.12
on_sale          | Boolean | _true_ se estiver à venda, _false_ caso contrário
barcode          | String  | Código de barras do produto.
reference_number | String  | Número de referência personalizado. Se você possui uma identificação própria, você pode usá-la aqui.
manufacturer_id\*  | String  | ID único do fabricante do item. Obrigatório apenas se você não especificar um nome para o fabricante.
manufacturer_name\* | String | Caso queira criar um novo fabricante, deixe seu ID em branco e especifique uma string aqui. Caso o nome já exista, o fabricante anterior será utilizado. Obrigatório apenas se você não especificar um ID.
taxonomy_id\*      | String  | ID único da categoria à qual este registro pertencerá.

<aside class="notice">
Não é possível alterar o ID de um registro.
</aside>

Caso a requisição funcione, você receberá de volta a entidade. Caso contrário,
uma mensagem de erro.

## A entidade

Quando a entidade é retornada, estes são os atributos presentes.

Atributo                 | Tipo    | Descrição
------------------------ | ------- | -----------
id                       | String  | Um valor único de identificação de cada registro.
name                     | String  | Nome/modelo do item do estoque.
description              | String  | Descrição do item do estoque.
year                     | String  | Ano de fabricação do item, ex.: "1994"
price                    | Float   | Preço do item, ex.: 10.12
on_sale                  | Boolean | Retorna true se estiver à venda.
barcode                  | String  | Código de barras do produto.
reference_number         | String  | Número de referência personalizado.
manufacturer             | Entidade | Entidade do fabricante do item.
taxonomy                 | Entidade | Entidade da categoria que o item pertence.
created_at               | Date    | Data de criação do registro. Formato ISO 8601.
updated_at               | Date    | Data da última atualização do registro. Formato ISO 8601.
