# QSD - Cupons
Microserviço de gerenciamento de promoções e cupons para o projeto <b>Quero Ser 
Dev</b> da Locaweb. Consiste em um painel de gerenciamento e uma API REST para
comunicação com os sistemas de `Vendas` e `Produtos`.

---
## Índice
- [1. Descritivo do painel de gerenciamento](#descritivo)
- [2. Consulta de cupom](#consulta_cupom)
- [3. Uso / queima de cupons](#queima_cupons)

---
## <a name="descritivo"></a>1. Descritivo do painel de gerenciamento
O sistema de `Cupons` provê uma interface gráfica web adequada para que o setor de marketing possa criar `Promoções` e dentro delas, gerenciar `Cupons`.
O visual é baseado no tema Locastyle, oficial da Locaweb e que pode ser explorado a fundo no link a seguir: [Locastyle](https://github.com/locaweb/locawebstyle/).

---

## <a name="queima_cupons"></a>2. Consulta de cupom (GET)
```
http://localhost/api/v1/coupons/confer?coupon=:coupon&price=:price&product=:product_id
```
- `coupon` é o código do cupom. Ex.: `NATAL0001`
- `price` é o valor da compra do cliente. Ex.: `200`
- `product` é o ID do produto ao qual o cupom está vinculado. Ex.: `1`

### Cupom existente e produto conferindo
- <b>Cabeçalho:</b> HTTP 200 (OK)
- <b>Corpo:</b> Valor do desconto calculado em BRL sobre o valor o `price` enviado

```json
{
  "discount": "10.0"
}
```

### Cupom inexistente
- <b>Cabeçalho:</b> HTTP 404 (Not Found)
- <b>Corpo:</b> Descrição do erro

```json
{
  "error": "Cupom inexistente"
}
```

### Cupom não pertence ao produto especificado
- <b>Cabeçalho:</b> HTTP 422 (Unprocessable Entity)
- <b>Corpo:</b> Descrição do erro

```json
{
  "error": "Cupom inválido para o produto especificado"
}
```

---

## <a name="queima_cupons"></a>3. Uso / queima de cupons (POST)
```
http://localhost/api/v1/coupon/:code/burn
```
- `code` é o código do cupom. Ex.: `NATAL0001`

### Corpo da requisição

```json
{
  "order_number": ":order_number",
  "date": ":date"
}
```
- `order_number` é o número da ordem responsável por usar o cupom. Ex.: `5E2357`
- `date` é o valor do uso do cupom. Ex.: `2020-03-12`

### Cupom existente
- <b>Cabeçalho:</b> HTTP 200 (OK)
- <b>Corpo:</b> Objeto `Coupon` com seu novo estado, `burnt`

```json
{
  "id":1,
  "status":"burnt",
  "promotion_id":1,
  "code":"NATAL0001",
  "created_at":"2020-02-10T19:27:40.009Z",
  "updated_at":"2020-02-10T19:27:40.038Z"
}
```

### Cupom inexistente
- <b>Cabeçalho:</b> HTTP 404 (Not Found)
- <b>Corpo:</b> Vazio