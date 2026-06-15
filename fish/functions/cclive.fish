function cclive --description 'Live Claude Code token/cost monitor for the current 5h block'
    npx ccusage@latest blocks --live $argv
end
