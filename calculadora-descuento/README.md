# Calculadora de descuento

GitHub Action compuesta que recibe un precio y un descuento porcentual, y calcula el precio final.

## Parámetros

| Input | Obligatorio | Descripción |
| --- | --- | --- |
| `precio` | sí | Precio original. Número mayor o igual a 0. |
| `descuento` | sí | Porcentaje de descuento, entre 0 y 100. |

## Salida

| Output | Descripción |
| --- | --- |
| `total` | Precio final, con dos decimales. |

El cálculo es `precio * (1 - descuento / 100)`.

## Prueba

El workflow [`.github/workflows/test-descuento.yml`](../.github/workflows/test-descuento.yml) ejecuta la action con precio `1500` y descuento `10`.

Resultado esperado:

```
Precio con descuento: 1350.00
```

## Uso

```yaml
- uses: Jeicob12/action/calculadora-descuento@main
  id: calculo
  with:
    precio: "1500"
    descuento: "10"

- run: echo "Precio con descuento ${{ steps.calculo.outputs.total }}"
```
