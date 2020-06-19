subject=#123
echo ${subject[0]}
echo ${subject[0:]}
echo $subject[0]
echo ${subject[0]}
echo ${subject[0]} | head -c 1
[ echo ${subject[0]} | head -c 1 = "#" ] && echo yes
[ echo $subject | head -c 1 = "#" ] && echo yes
[[ echo $subject | head -c 1 = "#" ]] && echo yes
[[ $( echo $subject | head -c 1 ) = "#" ]] && echo yes
exit
echo $PATH
exit
PS1='[PEXP\[\]ECT_PROMPT>' PS2='[PEXP\[\]ECT_PROMPT+' PROMPT_COMMAND=''
export PAGER=cat
display () {     TMPFILE=$(mktemp ${TMPDIR-/tmp}/bash_kernel.XXXXXXXXXX);     cat > $TMPFILE;     echo "bash_kernel: saved image data to: $TMPFILE" >&2; }
whoami
echo $?
