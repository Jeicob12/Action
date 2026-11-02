#!/usr/bin/env bash
# Arma un informe Markdown a partir de las variables de entorno de la action.
set -euo pipefail

trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

una_linea() {
  printf '%s' "$1" | tr '\n\r' ' '
}

fail() {
  echo "::error::$1"
  echo "$1" >&2
  exit 1
}

titulo="$(trim "${TITULO:-}")"
responsable="$(trim "${RESPONSABLE:-}")"
descripcion="$(trim "${DESCRIPCION:-}")"
prioridad="$(trim "${PRIORIDAD:-media}")"
prioridad="$(printf '%s' "$prioridad" | tr '[:upper:]' '[:lower:]')"

if [[ -z "$titulo" ]]; then
  fail "El parámetro 'titulo' es obligatorio."
fi

if [[ -z "$responsable" ]]; then
  fail "El parámetro 'responsable' es obligatorio."
fi

if [[ -z "$descripcion" ]]; then
  fail "El parámetro 'descripcion' es obligatorio."
fi

case "$prioridad" in
  baja|media|alta) ;;
  *)
    fail "Prioridad inválida: '${prioridad}'. Los valores aceptados son baja, media y alta."
    ;;
esac

fecha="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

informe="$(cat <<EOF
## ${titulo}

| Campo | Valor |
| --- | --- |
| Responsable | ${responsable} |
| Prioridad | ${prioridad} |
| Fecha (UTC) | ${fecha} |

${descripcion}
EOF
)"

linea="Informe: $(una_linea "$titulo") | Responsable: $(una_linea "$responsable") | Prioridad: ${prioridad}"
archivo="${GITHUB_WORKSPACE:-.}/informe.md"

printf '%s\n' "$informe" > "$archivo"

if [[ -n "${GITHUB_STEP_SUMMARY:-}" ]]; then
  {
    echo "### Informe generado"
    echo
    printf '%s\n' "$informe"
    echo
  } >> "$GITHUB_STEP_SUMMARY"
fi

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  if [[ -r /dev/urandom ]]; then
    delimitador="INFORME_$(od -An -N8 -tx1 /dev/urandom | tr -d ' \n')"
  else
    delimitador="INFORME_$$"
  fi

  {
    echo "informe<<${delimitador}"
    printf '%s\n' "$informe"
    echo "${delimitador}"
    echo "prioridad=${prioridad}"
    echo "linea=${linea}"
    echo "archivo=${archivo}"
  } >> "$GITHUB_OUTPUT"
fi

echo "Informe generado para '${titulo}' con prioridad '${prioridad}'."
echo "Archivo: ${archivo}"
