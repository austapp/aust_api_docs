---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='https://austapp.com'>Visitar o Aust</a>

includes:
  - endpoints_inventory_items
  - endpoints_inventory_entries
  - endpoints_orders
  - endpoints_order_items
  - endpoints_people
  - errors

---

# Introdução à API

Bem-vindo à API do Aust! Você pode usar as URLs da nossa API para acessar
informações sobre estoque, pessoas, pedidos e muito mais.

<aside class="warning">
  A API está em versão beta. Algumas alterações ainda podem acontecer.
</aside>

## Como este manual funciona

```shell
Olá! Eu sou um exemplo.
```

> Nesta área, você vê exemplos de como utilizar a API.

Na área escura à direita você pode ver exemplos de como interagir com a API
relativo à seção que você está.

Se você não tem acesso a um terminal shell, sugerimos um plugin
de navegador. No Chrome, adoramos o _Poster_.

Na esquerda, você encontra um índice inteligente, que segue a seção que você
estiver. Experimente rolar a página para baixo para ver o que acontece.

### Métodos e entidades

No menu à esquerda, você vê diversos métodos (ex.: Itens do Estoque, Pedidos etc).
Lá descrevemos como acessar e interagir com cada URL.

Há ainda uma seção especial em cada método chamada **A entidade**.
Lá damos detalhes sobre cada entidade. Sempre que precisar, pule
para esta seção.

### URLs e domínios

Nos exemplo dados, vamos omitir o domínio. Por exemplo,

`GET /admin/api/v1/orders.json`

significa uma requisição HTTP GET para o endereço acima, mas lembre-se
de sempre incluir o seu
domínio (ex.: `http://seudominio.com/admin/api/v1/orders.json`)

# Autorização

> Para autenticar uma requisição, envie no cabeçalho sua API token:

```shell
# No shell, -H significa Header (cabeçalho)
curl -H "Token: 123456789"
     "URL_DA_API"
```

Todo usuário do Aust possui uma chave única para acesso à API chamada
**API Token**. Você pode copiar a sua na página **Configurações** do seu
painel de administração. Ela é secreta e você não deve compartilhá-la com
ninguém.

O Aust espera que você inclua sua API token em todas as requisições em
um cabeçalho chamado `Token`, como no exemplo a seguir:

`curl -H "Token: $API_TOKEN" "https://seudominio.com/admin/api/v1/people.json"`

<aside class="notice">
Você deve substituir $API_TOKEN com sua token verdadeira.
</aside>

Com isto, o Aust autentica sua requisição e pode identificar o usuário que
está realizando as operações.

# IDs e chaves estrangeiras

> UUID tem o formato do ID a seguir:

```shell
{
  "person": {
    "id":         "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
    "first_name": "Luke",
    "last_name":  "Skywalker"
  }
}
```
Todo registro possui um valor único que o identifica. Nós o chamamos de ID.
Este ID possui o formato UUID para que evitemos duplicações.

Quando criando um registro, você pode enviar um ID próprio, desde que
esteja no formato UUID. Desta forma você
consegue manter uma referência remota a um registro que foi criado localmente.

Caso você não especifique um ID, nós vamos gerar um no formato UUID
automaticamente e enviá-lo na resposta à sua requisição.

Caso você especifique um ID inválido, ou seja, não usando formato UUID, nós
retornaremos uma mensagem de erro indicando o problema. Veja detalhes na seção
_Erros_.

# Paginação

> Por exemplo, além da entidade, você também tem acesso ao atributo **meta**.

```json
{
  "people": [{
    "id":         "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
    "first_name": "Luke",
    "last_name":  "Skywalker"
  }],
  "meta": {
    "page":        "2",
    "total_pages": "95"
  }
}
```

Quando você acessa uma URL da API, você recebe registros divididos por páginas.

No exemplo à direita, a entidade **meta** está presente. Com ela você é informado
da página atual e do total de páginas.

Com estas informações em mãos, você pode realizar requisições adicionais
para ler as demais páginas desejadas.

Para especificar uma página, use o atributo `page`, como no exemplo abaixo:

`curl "https://seudominio.com/api/v1/people.json?page=3"`

Neste caso, a página 3 será retornada.

<aside class="notice">
  Por simplicidade, omitiremos **meta** dos exemplos daqui em diante.
</aside>

# Métodos

Aqui vamos descrever cada uma das entidades que você pode interagir através
da API.

