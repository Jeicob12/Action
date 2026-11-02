# Generar informe

GitHub Action compuesta que recibe parámetros de entrada, valida la prioridad y genera un informe en Markdown.

La action escribe el informe en `informe.md`, lo agrega al resumen del job y expone el resultado como salida del step.

## Parámetros

| Input | Obligatorio | Default | Descripción |
| --- | --- | --- | --- |
| `titulo` | sí | | Título del informe. |
| `responsable` | sí | | Persona responsable de la tarea. |
| `descripcion` | sí | | Detalle de lo que se hizo. |
| `prioridad` | no | `media` | `baja`, `media` o `alta`. Se acepta en mayúsculas y se normaliza. |

Una prioridad distinta de esas tres hace fallar la action.

## Salidas

| Output | Descripción |
| --- | --- |
| `informe` | Informe completo en Markdown. |
| `prioridad` | Prioridad normalizada en minúsculas. |
| `linea` | Resumen de una sola línea. |
| `archivo` | Ruta absoluta de `informe.md` dentro del workspace. |

## Uso

En otro repositorio, después de publicar esta action y crear el tag `v1`:

```yaml
name: Usar la action

on: [push]

jobs:
  informe:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7

      - name: Generar informe
        id: informe
        uses: USUARIO/TpActions@v1
        with:
          titulo: Entrega del práctico
          responsable: Jacobo
          descripcion: Action publicada y probada con un workflow.
          prioridad: alta

      - name: Mostrar resumen
        run: echo "${{ steps.informe.outputs.linea }}"
```

Reemplazá `USUARIO/TpActions` por el nombre real del repositorio.

## Prueba

[`.github/workflows/probar-action.yml`](.github/workflows/probar-action.yml) ejecuta la action con `uses: ./` en tres casos:

- genera el informe con los parámetros recibidos y publica `informe.md` como artefacto;
- acepta `ALTA` y la normaliza a `alta`;
- rechaza una prioridad inválida (`urgente`).

También se puede disparar a mano desde la pestaña **Actions**, con título, responsable, descripción y prioridad.

## Publicar

Desde la raíz de este repositorio, con la [GitHub CLI](https://cli.github.com/) autenticada:

```bash
git init
git add .
git commit -m "Agrega la action de informe y su workflow de prueba."
gh repo create TpActions --public --source=. --remote=origin --push
git tag v1
git push origin v1
```

El tag `v1` es la referencia que consumen otros workflows (`uses: USUARIO/TpActions@v1`). El workflow de este repo no depende de ese tag: prueba la copia del checkout.
