# Project QR-Code Label Maker

Creates QR-Codes for the Inventories using a label printer

# Installation

Run included setup script to get started:

```sh
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install qr-encode lpr imagemagick
```

# Usage


## simple qr only (no label)

```sh
bash qr-maker.sh -m "hello world!"
```

## qr with centered label beneath:

```sh
bash qr-maker.sh -m "hello world!" -l "best qr message"
```

# Hardware Used

- Label printer (I'm using the Brother QL-710W)


# Hardware Specific Setup

- used the following site for setup (installed both cups and lpr drivers, and make this default printer for the machine)
- (used 62mm x 8mm tape for the printing, and also set this up under advanced settings)

