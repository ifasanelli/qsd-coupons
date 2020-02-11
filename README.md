# QSD - Cupons
Microserviço de gerenciamento de promoções e cupons para o projeto <b>Quero Ser 
Dev</b> da Locaweb. Consiste em um painel de gerenciamento e uma API REST para
comunicação com os sistemas de Vendas e Produtos.

---
## Índice
### 1. Promoções

### 2. Cupons
- [2.x. Uso / queima](#queima_cupons)
---

## <a name="queima_cupons"></a>2.x. Uso / queima de cupons
```
http://localhost/api/v1/coupon/:code/burn
```

Onde `code` é o código do cupom. Por exemplo: `NATAL0001`.

### Cupom existente
- <b>Cabeçalho:</b> HTTP 200 (OK)
- <b>Corpo:</b> Objeto `Coupon` com seu novo estado, `burned`

```json
{
  "id":1,
  "status":"burned",
  "promotion_id":1,
  "code":"NATAL0001",
  "created_at":"2020-02-10T19:27:40.009Z",
  "updated_at":"2020-02-10T19:27:40.038Z"
}
```

### Cupom inexistente
- <b>Cabeçalho:</b> HTTP 404 (Not Found)
- <b>Corpo:</b> Vazio