#### Switch from rpm-ostree to bootc

- Document packages that are custom-installed:
  ```
  rpm-ostree status
  ```
- Reset Overlays: Run this command to remove layered packages and configuration overrides:
  ```
  sudo rpm-ostree reset
  ```
- Reboot system
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  bootc switch ghcr.io/ckiser074/bishop:latest
  ```
- Reboot again to complete the rebase
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  bootc switch --enforce-container-sigpolicy ghcr.io/ckiser074/bishop:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```
