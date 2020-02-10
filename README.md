## Uso / queima de cupons
Endpoint:
```
http://localhost/api/v1/coupon/:code/burn
```

Onde `code` é o código do cupom. Por exemplo: `NATAL0001`.

### Cupom existente
É retornado um JSON com o objeto do cupom e seu novo estado. No caso, `burned`.

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
Em caso do cupom candidato à queima não existir, retorna-se uma mensagem HTTP com código 404 (Not Found), sem corpo.