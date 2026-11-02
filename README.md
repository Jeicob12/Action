# Saludo Personalizado

GitHub Action compuesta que recibe un nombre y muestra un saludo.

## Parámetros

| Input | Obligatorio | Descripción |
| --- | --- | --- |
| `nombre` | sí | Nombre del usuario. |

## Prueba

El workflow [`.github/workflows/test.yml`](.github/workflows/test.yml) se dispara a mano.

1. Entrá a **Actions**.
2. Elegí **Test Action**.
3. Ejecutá **Run workflow**.

El step **Ejecutar Action** imprime:

```
Hola GitHub Actions
```

## Uso

```yaml
- uses: Jeicob12/github-action-jacobo-vocos@main
  with:
    nombre: GitHub Actions
```
