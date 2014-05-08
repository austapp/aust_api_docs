---
title: API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='http://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - endpoints_inventory_items
  - endpoints_inventory_entries
  - endpoints_orders
  - endpoints_people
  - errors

---

# Introdução à API

Bem-vindo à API do Aust! Você pode usar as URLs da nossa API para acessar
informações sobre estoque, pessoas, pedidos e muito mais.

<aside class="warning">
  A API está em versão beta.
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

# Paginação

> Por exemplo, além da entidade, você também tem acesso ao atributo **meta**.

```json
[
  {
    "person": {
      "id":         "35b87e73-3fec-4f2c-86dd-6afe36a0dbd2",
      "first_name": "Luke",
      "last_name":  "Skywalker"
    },
    "meta": {
      "page":        "2",
      "total_pages": "95"
    }
  }
]
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

