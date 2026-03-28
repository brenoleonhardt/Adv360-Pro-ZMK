#!/usr/bin/env bash


flash() {
	file=$(ls -t firmware/*-$1-clique.uf2 | head -1)
	target=/var/run/media/$USER/ADV360PRO/
	if [[ -z "$file" ]]; then
		notify-send -a adv360-flash -t 10000 -i error "Adv360 Flash" "Firmware file not found!"
		return
	fi
	if [[ ! -d "$target" ]]; then
		notify-send -a adv360-flash -t 10000 -i error "Adv360 Flash" "Plug in keyboard first!"
		return
	fi
	notify-send -a adv360-flash -t 10000 "Adv360 Flash" "Flashing $1-side..."
	err=$(cp "$file" "$target" 2>&1)
	if [[ $? -ne 0 ]]; then
		notify-send -r 91722 -a adv360-flash -t 10000 -u critical -i error "Adv360 Flash" "$err"
		return
	fi
	notify-send -a adv360-flash -t 10000 "Adv360 Flash" "Flashed successfully!"
}

export -f flash

yad --fixed \
	--center \
	--window-icon="applications-system" \
	--name="adv360-flash" \
	--image="usb-creator-gtk" \
	--title="Adv360 Flash" \
	--text="\nFlash Advantage360\n" \
	--buttons-layout=center \
	--button="Exit":0 \
	--button="Left!go-left":"bash -c \"flash left\"" \
	--button="Right!go-right":"bash -c \"flash right\""

