#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "::error::$1"
  echo "$1" >&2
  exit 1
}

precio="${PRECIO:-}"
descuento="${DESCUENTO:-}"

if ! [[ "$precio" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  fail "El precio debe ser un número mayor o igual a 0."
fi

if ! [[ "$descuento" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
  fail "El descuento debe ser un porcentaje entre 0 y 100."
fi

dentro_de_rango="$(awk -v d="$descuento" 'BEGIN { print (d >= 0 && d <= 100) ? "si" : "no" }')"
if [[ "$dentro_de_rango" != "si" ]]; then
  fail "El descuento debe ser un porcentaje entre 0 y 100."
fi

total="$(awk -v p="$precio" -v d="$descuento" 'BEGIN { printf "%.2f", p * (1 - d / 100) }')"

echo "Precio con descuento: ${total}"

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "total=${total}" >> "$GITHUB_OUTPUT"
fi
