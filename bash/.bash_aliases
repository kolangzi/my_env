alias ll='ls -alF'
alias la='ls -A'
alias rm='rm -iv'
alias del='mv -t ~/.local/share/Trash/files'
alias cp='cp -iv'
alias mv='mv -iv'
alias grx='rg -n'
alias fd='fdfind'
alias vi='nvim'
alias python='python3'

con() {
	local portnum=$1
	local devpath="/dev/ttyUSB${portnum}"

	if [ -c "$devpath" ]; then
		echo "Connecting to $devpath..."
		sudo tio "$devpath" -b 115200
	else
		echo "Error: Device $devpath not found!"
	fi
}

scpmac() {
    local direction=$1
    local path=$2
    local target=$3
    local remote="smwang@192.168.10.185:/Users/smwang/scp_dir/"

    if [[ "$direction" == "get" ]]; then
        if [[ -z "$path" ]]; then
            echo "Usage: scpmac get <REMOTE_PATH> [LOCAL_TARGET_DIR]"
            return 1
        fi

        local dest="${target:-.}"
        scp -r "${remote}${path}" "$dest"

    elif [[ "$direction" == "put" ]]; then
        if [[ -z "$path" ]]; then
            echo "Usage: scpmac put <LOCAL_PATH>"
            return 1
        fi

        scp -r "$path" "$remote"
    else
        echo "Usage: scpmac get <REMOTE_PATH> [LOCAL_TARGET_DIR] | scpmac put <LOCAL_PATH>"
        return 1
    fi
}

wangsync() {
	# 1. 인자값(이름)이 없으면 에러 메시지 출력 후 종료
	if [ -z "$1" ]; then
		echo "❌ 에러: 생성할 디렉토리 이름을 입력해주세요."
		echo "사용법: wangsync <원하는_이름>"
		return 1
	fi

	# 2. rsync 실행
	# ${PWD}/ : 현재 디렉토리의 '내용물'만 보냄 (슬래시 중요!)
	# .../wang/$1 : wang 폴더 밑에 입력받은 이름으로 들어감
	sudo rsync -av --chown=smwang:smwang --delete --exclude='*.git/' "${PWD}/" "/home/ldap/smwang/wang/$1"
}

# ARM GCC
#export ARM_GCC_PATH=/tools/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-elf
export ARM_GCC_PATH=/tools/arm-gnu-toolchain-13.2.Rel1-x86_64-aarch64-none-elf
export PATH="${ARM_GCC_PATH}/bin:${T32_PATH}:${HOME}/bin:${PATH}"
export PATH="${PATH}:/usr/lib/x86_64-linux-gnu"

export PATH=~/.local/bin:"$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
