#!/usr/bin/env bash
set -euo pipefail

container="${RESOLVE_CONTAINER:-}"
container_user="${RESOLVE_USER:-$(id -un)}"
gpu_backend="${RESOLVE_GPU:-auto}"
resolve_home="${RESOLVE_HOME:-}"

die() {
  echo "davinci-resolve-mcp: $*" >&2
  exit 1
}

host_has_amd_opencl() {
  command -v clinfo >/dev/null 2>&1 || return 1
  clinfo 2>/dev/null | awk '
    function flush_device() {
      if (device_vendor_amd && device_gpu) found = 1
      device_vendor_amd = 0
      device_gpu = 0
    }
    /^[[:space:]]*Device Name/ { flush_device() }
    /Device Vendor/ && ($0 ~ /AMD|Advanced Micro Devices/) { device_vendor_amd = 1 }
    /Device Type/ && ($0 ~ /GPU/) { device_gpu = 1 }
    END { flush_device(); exit !found }
  '
}

case "${gpu_backend,,}" in
  auto)
    if host_has_amd_opencl; then
      gpu_backend="amd"
    elif command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi -L >/dev/null 2>&1; then
      gpu_backend="nvidia"
    else
      die "could not auto-detect an AMD or NVIDIA GPU. Set RESOLVE_GPU=amd or RESOLVE_GPU=nvidia."
    fi
    ;;
  amd|rocm|opencl) gpu_backend="amd" ;;
  nvidia|cuda) gpu_backend="nvidia" ;;
  *) die "invalid RESOLVE_GPU value: ${gpu_backend}. Use auto, amd, or nvidia." ;;
esac

if [ "${gpu_backend}" = "nvidia" ]; then
  container="${container:-davincibox-nvidia-docker}"
  resolve_home="${resolve_home:-${HOME}/.local/share/davinci-resolve-21-nvidia-box-home}"
else
  container="${container:-davincibox-docker}"
  resolve_home="${resolve_home:-${HOME}/.local/share/davinci-resolve-21-box-home}"
fi

case "${resolve_home}" in
  /*) ;;
  *) die "RESOLVE_HOME must be an absolute path: ${resolve_home}" ;;
esac

if ! docker container inspect "${container}" >/dev/null 2>&1; then
  die "container '${container}' does not exist. Run setup first."
fi

if [ "$(docker inspect -f '{{.State.Running}}' "${container}")" != "true" ]; then
  docker start "${container}" >/dev/null
fi

exec docker exec -i \
  -u "${container_user}" \
  -e HOME="${resolve_home}" \
  -e XDG_CONFIG_HOME="${RESOLVE_XDG_CONFIG_HOME:-${resolve_home}/.config}" \
  -e XDG_DATA_HOME="${RESOLVE_XDG_DATA_HOME:-${resolve_home}/.local/share}" \
  -e XDG_CACHE_HOME="${RESOLVE_XDG_CACHE_HOME:-${resolve_home}/.cache}" \
  -w /opt/resolve \
  "${container}" \
  /opt/resolve/bin/ResolveMCP "$@"
