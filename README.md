# Calculadora de descuento

Action compuesta que aplica un descuento porcentual sobre un precio y devuelve el total final.

## Descripción

Recibe el precio original y el porcentaje de descuento. Calcula el precio con descuento y lo muestra en el log. También lo publica en la salida `total`.

## Inputs

| Input | Obligatorio | Descripción |
| --- | --- | --- |
| `precio` | sí | Precio original. Número mayor o igual a 0. |
| `descuento` | sí | Porcentaje de descuento, entre 0 y 100. |

## Procesamiento

```text
total = precio * (1 - descuento / 100)
```

El total se redondea a dos decimales. Si el precio es negativo, o el descuento no es un porcentaje entre 0 y 100, la action termina con error.

## Resultado esperado

Con precio `1500` y descuento `10`:

```text
Precio con descuento: 1350.00
```

La salida `total` vale `1350.00`.

## Prueba

El workflow [`.github/workflows/test-descuento.yml`](.github/workflows/test-descuento.yml) ejecuta la action en este repositorio:

```yaml
- uses: ./calculadora-descuento
  with:
    precio: "1500"
    descuento: "10"
```

Se dispara al hacer push de la action y también a mano, desde **Actions → Test Calculadora Descuento → Run workflow**.

La corrida que verificó el resultado: [Test Calculadora Descuento](https://github.com/Jeicob12/Action/actions/runs/41538761977).

## Uso

```yaml
- name: Calcular descuento
  id: calculo
  uses: Jeicob12/Action/calculadora-descuento@calculadora-descuento
  with:
    precio: "1500"
    descuento: "10"

- name: Mostrar precio con descuento
  run: echo "Precio con descuento ${{ steps.calculo.outputs.total }}"
```

## Saludo personalizado

En la raíz del repositorio también está la action **Saludo Personalizado**. Recibe `nombre` e imprime el saludo. El workflow [`.github/workflows/test.yml`](.github/workflows/test.yml) la prueba con `nombre: jacobo vocos` y el resultado es `Hola jacobo vocos`.
