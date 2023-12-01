#!/bin/bash

promptYesNo() {
    while true; do
        read -rp "$1 [Y/n] " yn
        case $yn in
        [Yy]*) return 0 ;; # Yes
        [Nn]*) return 1 ;; # No
        "") return 0 ;;    # Default Yes
        *) echo "Please answer yes or no." ;;
        esac
    done
}

if ! command -v cargo &>/dev/null; then
    echo "Cargo is not installed"
    exit 1
else
    echo "cargo is installed!"
fi

if ! command -v cargo-generate &>/dev/null; then
    echo "cargo-generate is not installed"

    if promptYesNo "Do you want to install cargo-generate?"; then
        echo "Installing cargo-generate..."
        cargo install cargo-generate
        echo "cargo-generate installed successfully."
    else
        echo "Skipping installation."
    fi
else
    echo "cargo-generate is installed!"
fi

if ! command -v cargo-watch &>/dev/null; then
    echo "cargo-watch is not installed."

    if promptYesNo "Do you want to install cargo-watch?"; then
        echo "Installing cargo-watch..."
        cargo install cargo-watch
        echo "cargo-watch installed successfully."
    else
        echo "Skipping installation."
    fi
else
    echo "cargo-watch is installed!"
fi

echo
echo "------------------------------------------------------------"
echo

generateNewDay() {
    if [ -z "$1" ]; then
        echo "Usage: ./run.sh create <day>"
        exit 1
    fi

    echo "Generating new day $1..."

    cargo generate --path ./template --name "$1"
}

work() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: ./run.sh work <day> <part>"
        exit 1
    fi

    cargo watch -x "check -p $1" -x "test --package ""$1"" --bin ""$2"""

}

run() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: ./run.sh run <day> <part>"
        exit 1
    fi

    cargo run --package "$1" --bin "$2"

}

case $1 in
create)
    generateNewDay "$2"
    shift
    ;;
work)
    work "$2" "$3"
    shift
    ;;
run)
    run "$2" "$3"
    shift
    ;;
--default)
    shift
    ;;
*) ;;

esac
