# Emit a sliced delimited string
function sdstr {
	IFS=' ' read -r -a arr <<< "$3" 2>/dev/null || arr=('' ${(@s:' ':)3})
	echo ${#arr[@]}
	eIdx=0
	while [ "$eIdx" -lt "$1" ]; do
		if [ "$eIdx" != "0" ]; then
			printf "$2"
		fi
		printf "${arr[eIdx]}"
		eIdx=$((eIdx+1))
	done
	echo ''
}
sdstr 7 / "a b c d e f g"
exit